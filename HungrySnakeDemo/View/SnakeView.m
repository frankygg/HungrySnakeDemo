 //
//  SnakeView.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/12.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeView.h"

@implementation SnakeView

- (void)drawRect:(CGRect)rect {
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSMutableArray<SnakePoint *> *bodyPositions = [self.delegate snakeBodyForView:self];
    SnakePoint *foodPosition = [self.delegate foodLocationForView:self];

    
//    CGFloat rectLength = self.bounds.size.width / (farestPoint.x+1);
    CGFloat rectLength = 20.f;
    SnakePoint *head = bodyPositions.lastObject;
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddRect(context, self.bounds);
    CGContextSetLineWidth(context, 2.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(context, 2.0);
    for (SnakePoint *point in bodyPositions) {
        CGContextAddRect(context, CGRectMake(rectLength*point.x, rectLength*point.y, rectLength, rectLength));
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextAddRect(context, CGRectMake(rectLength*head.x, rectLength*head.y, rectLength, rectLength));
    CGContextDrawPath(context, kCGPathFillStroke);
    if (foodPosition) {
        CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
        CGContextAddArc(context, rectLength * foodPosition.x + (rectLength/2), rectLength*foodPosition.y + (rectLength/2), rectLength/2, 0, M_PI * 2.0, 0);
        CGContextDrawPath(context, kCGPathFill);
    }
}
@end
