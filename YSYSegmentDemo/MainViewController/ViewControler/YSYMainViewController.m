//
//  YSYMainViewController.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYMainViewController.h"
#import "YSYAViewController.h"
#import "YSYBViewController.h"
#import "YSYCViewController.h"
#import "YSYDViewController.h"
#import "YSYEViewController.h"
#import "YSYFViewController.h"
#import "YSYGViewController.h"

#import "YSYSegmentControl.h"
#import "YSYManageColumnView.h"
#import "Masonry.h"

@interface YSYMainViewController ()<YSYColumnViewDelegate>

@property (nonatomic, strong) YSYSegmentControl   *slideSwitchView;
@property (nonatomic, strong) YSYManageColumnView *columnView;
@property (nonatomic, copy)   NSMutableArray      *segItemArray;
//@property (nonatomic, copy)   NSMutableArray      *segVCArray;
@property (nonatomic, copy)   NSMutableDictionary *segDictionary;
@property (nonatomic, strong) UIButton            *rightBtn;
@property (nonatomic, strong) UIView              *statusView;
@property (nonatomic, copy)   NSString            *defaultStr;

@end

@implementation YSYMainViewController

#pragma mark life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *deviceVersion = [[UIDevice currentDevice] systemVersion];
    _defaultStr = [NSString stringWithFormat:@"%@Column",deviceVersion];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1]];
    [self.view addSubview:self.statusView];
    
    [self yzt_initData];
    [self yzt_buildSegment];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 2) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark private
- (void)yzt_initData
{
    NSArray *titleArr = @[@"AA",@"BB",@"CC",@"DD",@"EE",@"FF",@"GG",@"BC"];
    
    NSArray *VcArr = @[[YSYAViewController new],[YSYBViewController new],[YSYCViewController new],[YSYDViewController new],[YSYEViewController new],[YSYFViewController new],[YSYGViewController new],[YSYBViewController new]];
    
    self.segDictionary = [NSMutableDictionary dictionaryWithObjects:VcArr forKeys:titleArr];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:_defaultStr])
    {
        self.segItemArray = [NSMutableArray arrayWithArray:titleArr];
    }
    else
    {
        self.segItemArray = [[NSUserDefaults standardUserDefaults] objectForKey:_defaultStr];
    }
    
//    self.segVCArray = [NSMutableArray arrayWithArray:VcArr];
}

-(void)yzt_buildSegment
{
//    NSMutableDictionary *tmppageViewDic = [NSMutableDictionary new];
//    for (int i = 0; i < self.segItemArray.count ; i ++ ) {
//        [tmppageViewDic setObject:self.segVCArray[i] forKey:self.segItemArray[i]];
//    }
    
//    self.slideSwitchView.pageViewDic = tmppageViewDic;
    
    [self yzt_reloadSegment];
    
    [self yzt_reloadColumn];
    
    [self.view addSubview:self.rightBtn];
}

- (void)yzt_reloadSegment
{
    self.slideSwitchView.channelName = self.segItemArray;
    NSMutableArray *pageVCs = [NSMutableArray new];
    for (NSString *title in self.segItemArray) {
        
        UIViewController *vc = [self.segDictionary objectForKey:title];
        [pageVCs addObject:vc];
        
    }
    self.slideSwitchView.viewControllers = pageVCs;
}

- (void)yzt_reloadColumn
{
    self.columnView.upperArray = [NSMutableArray arrayWithArray:self.segItemArray];
    
    NSMutableArray *temArr = [NSMutableArray arrayWithObjects:@"AA",@"BB",@"CC",@"DD",@"EE",@"FF",@"GG",@"BC", nil];
    [temArr removeObjectsInArray:self.segItemArray];
    self.columnView.bottomArray = temArr;
}

#pragma mark YSYColumnViewDelegate
- (void)columnView:(YSYManageColumnView *)columnView withTitleArray:(NSMutableArray *)titleArray
{
    if (![self.segItemArray isEqualToArray: titleArray]) {
        self.segItemArray = titleArray;
        
        [[NSUserDefaults standardUserDefaults]setObject:titleArray forKey:_defaultStr];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self yzt_reloadSegment];
    }
    
    [_columnView removeFromSuperview];
}

#pragma mark setter method
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat viewWidth = CGRectGetWidth(self.view.frame);
        [_rightBtn setImage:[UIImage imageNamed:@"finance_column"] forState:UIControlStateNormal];
        [_rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
        _rightBtn.frame = CGRectMake(viewWidth - 40, 20, 40, 44);
        _rightBtn.backgroundColor = [UIColor colorWithRed:46.0f/255.0f green:70.0f/255.0f blue:132.0f/255.0f alpha:1.0f];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (YSYManageColumnView *)columnView
{
    if (!_columnView) {
        _columnView = [[YSYManageColumnView alloc] init];
        _columnView.delegate = self;
        _columnView.frame = [UIScreen mainScreen].bounds;
    }
    return _columnView;
}

- (YSYSegmentControl *)slideSwitchView
{
    if (!_slideSwitchView) {
        _slideSwitchView = [[YSYSegmentControl alloc] initWithFrame:CGRectMake(0 , 20 , [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20)];
        [_slideSwitchView setUserInteractionEnabled:YES];
        [self.view addSubview:_slideSwitchView];
    }
    return _slideSwitchView;
}

- (UIView *)statusView
{
    if (!_statusView) {
        _statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20)];
        _statusView.backgroundColor = [UIColor colorWithRed:45./255 green:68.0/255 blue:134.0/255 alpha:1];
    }
    return _statusView;
}


#pragma mark event response
- (void)rightBtnClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.columnView];
}



@end
