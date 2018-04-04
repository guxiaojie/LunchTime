//
//  HomeViewModel.h
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "BaseViewModel.h"
#import "HomeCellViewModel.h"

@interface HomeViewModel : BaseViewModel

/**
 *  data
 */
@property (nonatomic, strong) NSArray *items; //NO NSMutableArray

@property (nonatomic, strong) NSString *title;

/**
 *  more data
 */
@property (nonatomic, strong) RACSignal *hasMoreData;

/**
 *  request data Command
 */
@property (nonatomic, strong, readonly) RACCommand *fetchProductCommand;

/**
 *  requestion more data
 */
//@property (nonatomic, strong, readonly) RACCommand *fetchMoreProductCommand;

//sub ViewModel
- (HomeCellViewModel *)itemViewModelForIndex:(NSInteger)index;


@end
