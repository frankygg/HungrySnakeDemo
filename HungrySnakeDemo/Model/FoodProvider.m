//
//  FoodProvider.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/14.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodProvider.h"

@interface FoodProvider()
@property (nonatomic,strong) SnakePoint *foodLocation;
@property (nonatomic,strong) SnakePoint *wallPoint;
@end
@implementation FoodProvider
- (instancetype)init: (NSInteger)x Y:(NSInteger)y {
    self = [super init];
    if (self) {
        self.wallPoint = [[SnakePoint alloc] initWithCoordinateX:x Y:y];
    }
    return self;
}
-(SnakePoint*)generateNewFoodLocationWithout:(NSMutableArray<SnakePoint *>*) points{
    SnakePoint *result;
    do {
        NSInteger x = arc4random() % self.wallPoint.x;
        NSInteger y = arc4random() % self.wallPoint.y;
        result = [[SnakePoint alloc] initWithCoordinateX:x Y:y];
    } while ([points containsObject:result]);
    self.foodLocation = result;
    return result;
}
-(SnakePoint*)getFoodLocation{
    return self.foodLocation;
}

@end
