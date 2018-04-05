//
//  HomeViewModelTest.m
//  LunchTimeTests
//
//  Created by Guxiaojie on 2018/4/5.
//  Copyright © 2018年 SageGu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DDLog.h>
#import <CocoaLumberjack.h>
#import "Macros.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import <JSONModel/JSONModel.h>
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import <RealReachability.h>
#import "HomeViewModel.h"
#import "OCMock.h"


@interface HomeViewModel()

- (RACSignal *)netWorkRacSignal;

@end

@interface HomeViewModelTest : XCTestCase

@end

@implementation HomeViewModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNetError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test net error"];
    HomeViewModel *vm = [[HomeViewModel alloc] init];
    HomeViewModel *ocMockvm = OCMPartialMock(vm);
    OCMStub([ocMockvm netWorkRacSignal]).andReturn([RACSignal error:nil]);
    [ocMockvm.fetchProductCommand.errors subscribeNext:^(id x) {
        [expectation fulfill];
    }];
    [ocMockvm.fetchProductCommand execute:nil];
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (void)testNetSuccess {
    XCTestExpectation *expectation = [self expectationWithDescription:@"test net error"];
    HomeViewModel *vm = [[HomeViewModel alloc] init];
    HomeViewModel *ocMockvm = OCMPartialMock(vm);
    OCMStub([ocMockvm netWorkRacSignal]).andReturn([RACSignal return:[self dictWithFileName:@"data"]]);
    [ocMockvm.fetchProductCommand.errors subscribeNext:^(id x) {
        XCTFail();
    }];
    [[RACObserve(ocMockvm, items) skip:1] subscribeNext:^(NSArray *x) {
        XCTAssert(x.count > 0);
        [expectation fulfill];
    }];
    [ocMockvm.fetchProductCommand execute:nil];
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (NSDictionary *)dictWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dict;
}

- (void)testBreakItems {
    HomeViewModel *vm = [[HomeViewModel alloc] init];
    PhotoModel *mOne = [[PhotoModel alloc] init];
    mOne.title = @"test";
    mOne.imageHref = @"test";
    mOne.des = @"teest";
    vm.items = @[mOne];
    XCTAssert([vm itemViewModelForIndex:0] != nil);
    XCTAssert([vm itemViewModelForIndex:1] == nil);
    XCTAssert([vm itemViewModelForIndex:2] == nil);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
