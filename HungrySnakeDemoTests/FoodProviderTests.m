//
//  FoodProviderTests.m
//  HungrySnakeDemoTests
//
//  Created by BoTingDing on 2018/11/14.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FoodProvider.h"

@interface FoodProviderTests : XCTestCase
@property FoodProvider *foodProvider;
@end

@implementation FoodProviderTests

- (void)setUp {
    [super setUp];
    self.foodProvider = [[FoodProvider alloc] init:20 Y:20];
}

- (void)tearDown {
    self.foodProvider = nil;
    [super tearDown];
}

- (void)testGenerateNewFoodLocationWithoutLocations {
    NSMutableArray<SnakePoint*>* locations = [[NSMutableArray alloc] init];
    [locations addObject: [[SnakePoint alloc] initWithCoordinateX:1 Y:1]];
    SnakePoint *foodLocation = [self.foodProvider generateNewFoodLocationWithout:locations];
    XCTAssertLessThan(foodLocation.x, 20);
    XCTAssertLessThan(foodLocation.y, 20);
}

- (void)testGetFoodLocation {
    NSMutableArray<SnakePoint*>* locations = [[NSMutableArray alloc] init];
    [locations addObject: [[SnakePoint alloc] initWithCoordinateX:2 Y:3]];
    SnakePoint *generatedLocation = [self.foodProvider generateNewFoodLocationWithout:locations];
    SnakePoint *foodLocation = [self.foodProvider getFoodLocation];
    XCTAssertEqual(foodLocation.x, generatedLocation.x);
    XCTAssertEqual(foodLocation.y, generatedLocation.y);
}


@end
