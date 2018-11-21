//
//  FoodProvider.h
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/14.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakePoint.h"

@interface FoodProvider: NSObject
-(SnakePoint*)generateNewFoodLocationWithout:(NSMutableArray<SnakePoint *>*) points;
-(SnakePoint*)getFoodLocation;
- (instancetype)init: (NSInteger)x Y:(NSInteger)y;
@end
