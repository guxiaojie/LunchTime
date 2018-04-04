//
//  CanadaModel.h
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoModel.h"

@interface CanadaModel : JSONModel
@property(strong, nonatomic) NSString *title;
@property (nonatomic) NSArray <PhotoModel> *rows;

@end
