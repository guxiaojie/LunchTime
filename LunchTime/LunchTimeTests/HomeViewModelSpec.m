//
//  HomeViewModelSpec.m
//  LunchTimeTests
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveCocoa.h>
#import "Kiwi.h"
#import "TestHomeViewModel.h"

SPEC_BEGIN(HomeViewModelSpec)

describe(@"TestHomeViewModel", ^{
    __block TestHomeViewModel* viewModel = nil;
    
    beforeEach(^{
        viewModel = [TestHomeViewModel new];
    });
    
    afterEach(^{
        viewModel = nil;
    });
    
    context(@"when username is wujunyang and password is freedom", ^{
        __block BOOL success = NO;
        __block NSError *error = nil;
        
        it(@"should login successfully", ^{
            
            RACTuple *tuple = [[viewModel netWorkRacSignal] asynchronousFirstOrDefault:nil success:&success error:&error];
            
            NSDictionary *result = tuple.first;
            
            [[theValue(success) should] beYes];
            [[error should] beNil];
            [[result[@"title"] should] equal:@"About Canada"];
        });
    });
    
    
});

SPEC_END

