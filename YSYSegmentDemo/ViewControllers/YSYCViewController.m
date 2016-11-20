//
//  YSYCViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYCViewController.h"

@interface YSYCViewController ()

@end

@implementation YSYCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"=========CC界面！");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"=========欢迎来到CC界面！");
}

@end
