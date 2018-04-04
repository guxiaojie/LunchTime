//
//  HomeCellViewModel.h
//  LunchTime
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "BaseViewModel.h"
#import "CanadaModel.h"

@interface HomeCellViewModel : BaseViewModel

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *descrip;
@property (nonatomic, copy, readonly) NSString *img;
@property (nonatomic, copy, readonly) RACSignal *imageData;

- (instancetype)initWithModel:(PhotoModel *)model;

@end
