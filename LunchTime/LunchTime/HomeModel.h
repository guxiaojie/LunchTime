//
//  HomeModel.h
//  LunchTime
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : JSONModel

@property (nonatomic, strong) NSNumber *pageIndex;

@property (nonatomic, strong) NSNumber *totalCount;

@property (nonatomic, strong) NSNumber *pageSize;

@end
