//
//  BaseViewModel.h
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

//errors collection
@property (nonatomic) RACSubject *errors;

//isLoading
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

//cancel request Command
@property (nonatomic, strong, readonly) RACCommand *cancelCommand;


@end
