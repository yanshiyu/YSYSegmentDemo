//
//  YSYFViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYFViewController.h"

@interface YSYFViewController ()

@end

@implementation YSYFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    NSLog(@"=========FF界面！");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"=========欢迎来到FF界面！");
}

@end
