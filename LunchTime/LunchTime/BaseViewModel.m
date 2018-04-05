//
//  BaseViewModel.m
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _errors = [RACSubject subject];
        
        _cancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    
    return self;
}

- (void)dealloc {
    [_errors sendCompleted];
}


@end
