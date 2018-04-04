//
//  Photo.m
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "PhotoModel.h"
#import "JSONKeyMapper.h"

@implementation PhotoModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description" : @"des"
                                                       }];
}

@end
