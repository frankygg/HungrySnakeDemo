//
//  SnakeTests.m
//  HungrySnakeDemoTests
//
//  Created by BoTingDing on 2018/11/14.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Snake.h"

@interface SnakeTests : XCTestCase
@property (nonatomic,strong) Snake *snake;
@end

@interface Snake (Testing)
@property (nonatomic) enum SnakeDirection nextDirection;
@property (nonatomic) enum SnakeDirection oldDirection;
- (BOOL)_checkIfCrash:(SnakePoint *)location;
@end

@implementation SnakeTests

- (void)setUp {
    [super setUp];
    self.snake = [[Snake alloc] init:9 Y:9];
}

- (void)tearDown {
    self.snake = nil;
    [super tearDown];
}

- (void)testSnakeInit {
    SnakePoint *head = [self.snake.points lastObject];
    SnakePoint *tail = [self.snake.points firstObject];
    XCTAssertEqual(4, head.x);
    XCTAssertEqual(4, head.y);
    XCTAssertEqual(5, tail.x);
    XCTAssertEqual(4, tail.y);
}

- (void)testChangeDirectionToFailed {
    [self.snake changeDirectionTo:DirectionRight];
    XCTAssertEqual(self.snake.nextDirection, DirectionLeft);
}

- (void)testChangeDirectionToSuccess {
    [self.snake changeDirectionTo:DirectionUp];
    XCTAssertEqual(self.snake.nextDirection, DirectionUp);
}

- (void)testMove {
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    SnakePoint *tail = [self.snake.points firstObject];
    XCTAssertEqual(3, head.x);
    XCTAssertEqual(4, head.y);
    XCTAssertEqual(4, tail.x);
    XCTAssertEqual(4, tail.y);
}

- (void)testChangeDirectionClockWise {
    [self.snake changeDirectionTo:DirectionUp];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionRight];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionDown];
    [self.snake move];
    XCTAssertEqual(self.snake.nextDirection, DirectionDown);
}

- (void)testTouchLeftWallPoint {
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    XCTAssertEqual(9, head.x);
}

- (void)testTouchUpWallPoint {
    [self.snake changeDirectionTo:DirectionUp];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    XCTAssertEqual(0, head.y);
}

- (void)testTouchDownWallPoint {
    [self.snake changeDirectionTo:DirectionDown];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    XCTAssertEqual(9, head.y);
}

- (void)testTouchRightWallPoint {
    [self.snake changeDirectionTo:DirectionUp];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionRight];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    XCTAssertEqual(0, head.x);
}

- (void)testAddSnakeLength {
    [self.snake addSnakeLength];
    [self.snake move];
    [self.snake move];
    XCTAssertEqual(4, [self.snake.points count]);
}

- (void)testCrashed {
    [self.snake addSnakeLength];
    [self.snake move];
    [self.snake addSnakeLength];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionUp];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionRight];
    [self.snake move];
    [self.snake changeDirectionTo:DirectionDown];
    [self.snake move];
    SnakePoint *head = [self.snake.points lastObject];
    XCTAssertEqual(YES, [self.snake _checkIfCrash:head]);
}


@end
