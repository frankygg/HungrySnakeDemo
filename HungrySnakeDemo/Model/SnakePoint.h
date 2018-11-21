//
//  Point.h
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/13.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnakePoint: NSObject {
    NSInteger x,y;
}
@property (nonatomic)NSInteger x,y;
- (instancetype)initWithCoordinateX:(NSInteger)x Y:(NSInteger)y;
@end
