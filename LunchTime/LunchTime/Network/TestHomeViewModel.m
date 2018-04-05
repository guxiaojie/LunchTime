//
//  TestHomeViewModel.m
//  LunchTime
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "TestHomeViewModel.h"
#import "RACAFNetworking.h"

@implementation TestHomeViewModel

#pragma mark - Methods

-(RACSignal *)netWorkRacSignal
{
    NSString *URL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                              initWithBaseURL:[NSURL URLWithString:URL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [[manager rac_GET:@"" parameters:nil] subscribeNext:^(RACTuple *x) {
            
            //return data
            NSLog(@"data:%@", x.first);
            
            [subscriber sendNext:x];
        } error:^(NSError *error) {
        } completed:^{
            [subscriber sendCompleted];
        }];
    }];
}

@end
