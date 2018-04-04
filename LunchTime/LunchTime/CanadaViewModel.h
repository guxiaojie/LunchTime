//
//  CanadaViewModel.h
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "RACAFNetworking.h"

@interface CanadaViewModel : BaseViewModel

@property (nonatomic, copy) NSString *title;

@property(nonatomic,strong) RACSubject *errorSubject;

- (RACSignal *)netWorkRacSignal;

@end
