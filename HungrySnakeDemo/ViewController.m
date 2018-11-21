//
//  ViewController.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/12.
//  Copyright © 2018年 btding. All rights reserved.
//

#import "ViewController.h"
#import "SnakeView.h"
#import "Snake.h"
#import "SnakeDirection.h"
#import "FoodProvider.h"

@interface ViewController ()<SnakeViewDelegate, SnakeDelegate>
@property (nonatomic, strong) Snake* snake;
@property (nonatomic) NSInteger velocityThreshold;
@property (nonatomic) NSInteger pointCount;
@property (nonatomic,strong) SnakeView *gameView;
@property (nonatomic, strong) FoodProvider* foodProvider;
@property (nonatomic,strong) NSTimer *snakeTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestures];
    self.velocityThreshold = 250;
    
}
- (void)initialSetting {
    if (self.snake) {
        self.snake = nil;
    }
    self.foodProvider = nil;
    [self setUpSnakeView];
    self.pointCount = 0;
    self.snakeTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector: @selector(_moveSnake) userInfo:nil repeats:YES];
}

- (void)_addSnakeLength {
    [self.snake addSnakeLength];
}

- (void)_moveSnake
{
    [self.snake move];
    // 通知畫面重畫
    // [self.delegate gameDidupdate:self];
    [self.gameView setNeedsDisplay];
}

- (void)setupGestures
{
    UIPanGestureRecognizer *panGuesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:panGuesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:self.view];
    if(velocity.x > self.velocityThreshold)
    {
        [self.snake changeDirectionTo:DirectionRight];
    }

    if(velocity.x < -self.velocityThreshold)
    {
        [self.snake changeDirectionTo:DirectionLeft];
    }

    if(velocity.y > self.velocityThreshold)
    {
        [self.snake changeDirectionTo:DirectionUp];
    }

    if(velocity.y < -self.velocityThreshold)
    {
        [self.snake changeDirectionTo:DirectionDown];
    }
}

- (void)setUpSnakeView {
    CGFloat widthPadding = 20;
    CGFloat heightPadding = 20;
    CGFloat maxWidth = self.view.bounds.size.width - (widthPadding * 2);
    CGFloat maxHeight = self.view.bounds.size.height - (heightPadding * 2);
    CGRect displayRect;
    displayRect = CGRectMake(widthPadding, heightPadding, maxWidth, maxHeight);
    if (self.gameView) {
        [self.gameView removeFromSuperview];
        self.gameView = nil;
    }
    self.gameView = [[SnakeView alloc] initWithFrame:displayRect];
    self.snake = [[Snake alloc] init:maxWidth / 20 Y:maxHeight / 20];
    self.snake.delegate = self;
    self.foodProvider = [[FoodProvider alloc] init:maxWidth / 20 Y:maxHeight / 20];
    [self.foodProvider generateNewFoodLocationWithout:self.snake.points];
    self.gameView.delegate = self;
    [self.view addSubview: self.gameView];
}

- (void)snakeEatFood
{
    [self.snake addSnakeLength];
    self.pointCount += 1;
//    if (![self.foodProvider generateNewFoodWithEmptySpace: [self.emptySpace copy]]) {
//        [self _snakeWin];
//    }
    [self.foodProvider generateNewFoodLocationWithout:self.snake.points];
    [self.gameView setNeedsDisplay];
}

#pragma mark - SnakeViewDelegate
- (NSMutableArray<SnakePoint *> *)snakeBodyForView:(SnakeView *)view
{
   return self.snake.points;
}

- (SnakePoint*)foodLocationForView:(SnakeView *)view
{
    return self.foodProvider.getFoodLocation;
}

#pragma mark - SnakeDelegate
- (void)snakeDidGainHeadOn:(SnakePoint *)headPoint snake:(Snake *)snake
{
    if (headPoint.x == [self.foodProvider getFoodLocation].x && headPoint.y == [self.foodProvider getFoodLocation].y) {
        [self snakeEatFood];
    }
}

- (void)snakeDidCrashOn:(Snake *)snake
{
    if (self.snakeTimer) {
        [self.snakeTimer invalidate];
        self.snakeTimer = nil;
    }
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:[NSString stringWithFormat:@"You got %lu points !", self.pointCount] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self initialSetting];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)startAction:(UIButton *)sender {
    sender.hidden = YES;
    [self initialSetting];
}

@end


