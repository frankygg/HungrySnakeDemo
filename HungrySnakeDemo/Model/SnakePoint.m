//
//  Point.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/13.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakePoint.h"
@implementation SnakePoint
@synthesize x,y;
- (instancetype)initWithCoordinateX:(NSInteger)x Y:(NSInteger)y {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}
@end
