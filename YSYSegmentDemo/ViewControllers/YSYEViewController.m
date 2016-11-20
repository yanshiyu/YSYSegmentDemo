//
//  YSYEViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYEViewController.h"

@interface YSYEViewController ()

@end

@implementation YSYEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    NSLog(@"=========EE界面！");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"=========欢迎来到EE界面！");
}

@end
