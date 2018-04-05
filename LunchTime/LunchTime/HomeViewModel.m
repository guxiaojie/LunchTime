//
//  HomeViewModel.m
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "HomeViewModel.h"
#import "RACAFNetworking.h"
#import "CanadaModel.h"

@implementation HomeViewModel

- (instancetype)init {
    if (self = [super init]) {
        
        [self initCommand];
        
        [self initSubscribe];
    }
    return self;
}

- (RACSignal *)netWorkRacSignal {
    NSString *URL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                              initWithBaseURL:[NSURL URLWithString:URL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    return [[[manager rac_GET:@"" parameters:nil]
             catch:^RACSignal *(NSError *error) {
                 //Error
                DDLogError(@"error:%@", error);
                 //TODO: error.code & description
                 return [RACSignal error:[NSError errorWithDomain:@"ERROR" code:error.code userInfo:@{@"Success":@NO, @"Message":@"Bad Network!"}]];
             }]
            reduceEach:^id(id responseObject, NSURLResponse *response){
                DDLogError(@"url:%@,resp:%@",response.URL.absoluteString,responseObject);
                return responseObject;
            }];
}

- (void)initCommand
{
    _fetchProductCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [[self netWorkRacSignal]
                takeUntil:self.cancelCommand.executionSignals];
    }];
    
//     get more data
//    _fetchMoreProductCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
//        return [[self netWorkRacSignal:@(self.page.page_index+1) pageSize:@(pageSize)] takeUntil:self.cancelCommand.executionSignals];
//    }];
}

- (void)initSubscribe
{
    @weakify(self);
    [[_fetchProductCommand.executionSignals switchToLatest] subscribeNext:^(id response) {
        @strongify(self);
        DDLogError(@"%@",response);
        CanadaModel *homeModel = [[CanadaModel alloc] initWithDictionary:response error:nil];
        NSMutableArray *tmp = @[].mutableCopy;
        for (PhotoModel *model in homeModel.rows) {
            HomeCellViewModel *cellViewModel = [[HomeCellViewModel alloc] initWithModel:model];
            [tmp addObject:cellViewModel];
        }
        self.title = homeModel.title;
        self.items = tmp.copy;
    }];
    
    [[RACSignal merge:@[_fetchProductCommand.errors]] subscribe:self.errors];
}

//sub ViewModel
- (HomeCellViewModel *)itemViewModelForIndex:(NSInteger)index {
    if (index >= self.items.count) {
        return nil;
    } else {
        return self.items[index];
    }
}

@end
