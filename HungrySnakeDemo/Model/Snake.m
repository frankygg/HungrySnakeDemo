//
//  Snake.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/13.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snake.h"
#import "SnakeDirection.h"

@interface Snake()
@property (nonatomic) enum SnakeDirection oldDirection;
@property (nonatomic) enum SnakeDirection nextDirection;
@property (nonatomic) NSInteger growthCount;
@property (nonatomic,strong) SnakePoint *wallPoint;
@end

@implementation Snake
@synthesize points;
- (instancetype)init: (NSInteger)x Y:(NSInteger)y {
    self = [super init];
    if (self) {
        self.points = [[NSMutableArray alloc] init];
        self.growthCount = 0;
        self.oldDirection = DirectionLeft;
        self.nextDirection = DirectionLeft;
        self.wallPoint = [[SnakePoint alloc] initWithCoordinateX:x Y:y];
        NSInteger middleX = self.wallPoint.x / 2;
        NSInteger middleY = self.wallPoint.y / 2;
        //initial tail
        [self _enqueue:[[SnakePoint alloc] initWithCoordinateX:middleX + 1 Y:middleY]];
        //initail head
        [self _enqueue:[[SnakePoint alloc] initWithCoordinateX:middleX Y:middleY]];
    }
    return self;
}

- (void)changeDirectionTo:(SnakeDirection)direction
{
    if (direction + self.oldDirection == 5) {
        return;
    }
    self.nextDirection = direction;
}

- (void)move
{
    SnakePoint *newHead = [self _getNewHeadPosition];
    [self _movedTo:newHead];
}

- (SnakePoint*)_getNewHeadPosition
{
    SnakePoint *oldHeadPoint = self.points.lastObject;
    if (!oldHeadPoint) {
        return [[SnakePoint alloc] initWithCoordinateX:0 Y:0];
    }
    NSInteger newX = oldHeadPoint.x;
    NSInteger newY = oldHeadPoint.y;
    switch (self.nextDirection) {
        case DirectionUp:
            newY += 1;
            newY = newY > self.wallPoint.y ? 0 : newY;
            self.oldDirection = DirectionUp;
            break;
        case DirectionDown:
            newY -= 1;
            newY = newY < 0 ? self.wallPoint.y : newY;
            self.oldDirection = DirectionDown;
            break;
        case DirectionLeft:
            newX -= 1;
            newX = newX < 0 ? self.wallPoint.x : newX;
            self.oldDirection = DirectionLeft;
            break;
        case DirectionRight:
            newX += 1;
            newX = newX > self.wallPoint.x ? 0 : newX;
            self.oldDirection = DirectionRight;
            break;
    }
    SnakePoint *newHead = [[SnakePoint alloc] initWithCoordinateX:newX Y:newY];
    return newHead;
}
- (void)_movedTo:(SnakePoint *)location
{
//    BOOL isCrashIntoBody = [self _checkIfCrash:location];
//    if (isCrashIntoBody) {
//        [self.delegate snakeDidCrashIntoBody:self];
//        return;
//    }
    [self _enqueue:location];
    [self _dequeue];
    if( ([self.points count ] > 2) && ([self _checkIfCrash:location])) {
        [self.delegate snakeDidCrashOn:self];
    }
}

- (void)_dequeue {
    if (self.growthCount > 0) {
        self.growthCount -= 1;
        return;
    }
    id headObject = [self.points objectAtIndex:0];
    if (headObject != nil) {
        [self.points removeObjectAtIndex:0];
    }
}

- (void)_enqueue:(id)anObject {
    [self.delegate snakeDidGainHeadOn:anObject snake:self];
    [self.points addObject:anObject];
}

- (void)addSnakeLength {
    self.growthCount += 2;
}

- (BOOL)_checkIfCrash:(SnakePoint *)location
{
    int occurrences = 0;
    for (SnakePoint* point in self.points) {
        if (point.x == location.x && point.y == location.y) {
            occurrences += 1;
        }
    }
    return occurrences == 2;
}


@end
