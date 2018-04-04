//
//  Photo.h
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoModel;

@interface PhotoModel : JSONModel
@property(strong, nonatomic) NSString  <Optional> *title;
@property(strong, nonatomic) NSString  <Optional> *imageHref;
@property(strong, nonatomic) NSString  <Optional> *des;
@end
