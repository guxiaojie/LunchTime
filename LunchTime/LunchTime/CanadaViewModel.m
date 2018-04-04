//
//  CanadaViewModel.m
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "CanadaViewModel.h"

@implementation CanadaViewModel

-(id)init
{
    if (self = [super init] )
    {
        //绑定access_token
//        RAC(self,access_token) = [[[self.loginCommand executionSignals] switchToLatest]deliverOn:[RACScheduler mainThreadScheduler]];
        
        //初始化错误处理
        self.errorSubject = [RACSubject subject];
    }
    return self;
}

-(RACSignal *)netWorkRacSignal
{
    NSString *URL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                              initWithBaseURL:[NSURL URLWithString:URL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    return [[[manager rac_GET:@"" parameters:nil]
             catch:^RACSignal *(NSError *error) {
                 //对Error进行处理
//                 DDLogError(@"error:%@", error);
                 //TODO: 这里可以根据error.code来判断下属于哪种网络异常，分别给出不同的错误提示
                 return [RACSignal error:[NSError errorWithDomain:@"ERROR" code:error.code userInfo:@{@"Success":@NO, @"Message":@"Bad Network!"}]];
             }]
            reduceEach:^id(id responseObject, NSURLResponse *response){
//                DDLogError(@"url:%@,resp:%@",response.URL.absoluteString,responseObject);
                
                return responseObject;
            }];
}


/**
 *  @author wujunyang, 16-01-12 23:01:11
 *
 *  @brief  网络请求
 *
 *  @return return value description
 *
 *  @since <#version number#>
 */
 
@end
