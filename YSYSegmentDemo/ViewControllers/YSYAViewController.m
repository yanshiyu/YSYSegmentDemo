//
//  YSYAViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYAViewController.h"

@interface YSYAViewController ()

@end

@implementation YSYAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];

    NSLog(@"=========AA界面！");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"=========欢迎来到AA界面！");
}


@end
