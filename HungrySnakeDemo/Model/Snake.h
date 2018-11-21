//
//  Snake.h
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/13.
//  Copyright © 2018年 btding. All rights reserved.
//
#import "SnakePoint.h"
#import "SnakeDirection.h"
@class Snake;

@protocol SnakeDelegate
- (void)snakeDidGainHeadOn:(SnakePoint *)headPoint snake:(Snake *)snake;
- (void)snakeDidCrashOn:(Snake *)snake;
@end

@interface Snake: NSObject {
    NSMutableArray<SnakePoint *> *points;
}
@property (nonatomic,weak) id<SnakeDelegate> delegate;
@property NSMutableArray<SnakePoint *> *points;
- (instancetype)init: (NSInteger)x Y:(NSInteger)y;
- (void)changeDirectionTo:(SnakeDirection)direction;
- (void)move;
- (void)addSnakeLength;
@end
