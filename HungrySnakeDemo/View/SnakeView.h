//
//  SnakeView.h
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/12.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnakePoint.h"
@class SnakeView;

@protocol SnakeViewDelegate
- (NSMutableArray<SnakePoint *> *)snakeBodyForView:(SnakeView *)view;
- (SnakePoint*)foodLocationForView:(SnakeView *)view;
@end

@interface SnakeView: UIView
@property (nonatomic, weak) id<SnakeViewDelegate> delegate;
@end
