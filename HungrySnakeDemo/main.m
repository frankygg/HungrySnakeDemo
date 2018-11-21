//
//  main.m
//  HungrySnakeDemo
//
//  Created by BoTingDing on 2018/11/12.
//  Copyright © 2018年 btding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        __block int (^fibs)(int);
        int (^fibs_)(int)= ^(int n) {
            if (n == 0) {
                return 0;
            }
            if (n == 1) {
                return 1;
            }
            return fibs(n-1) + fibs(n-2);
        };
        fibs = fibs_;
        NSLog(@"%d", fibs(4));
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
