//
//  YSYBViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYBViewController.h"

@interface YSYBViewController ()

@end

@implementation YSYBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    NSLog(@"=========BB界面！");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"=========欢迎来到BB界面！");
}


@end
