//
//  HomeCellViewModel.m
//  LunchTime
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "HomeCellViewModel.h"

@interface HomeCellViewModel()
@property (nonatomic, strong) PhotoModel *model;
@end

@implementation HomeCellViewModel

- (instancetype)initWithModel:(PhotoModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (NSString *)title {
    return self.model.title;
}

- (NSString *)descrip {
    if (self.model.des == nil || self.model.des.length == 0) {
        return @"There is no description";
    }
    return self.model.des;
}

- (NSString *)img {
    return self.model.imageHref;
}

@end
