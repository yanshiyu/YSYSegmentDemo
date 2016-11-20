//
//  YSYSegmentControl.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYSegmentControl.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"

#define kHeightOfTopScrollView 44

@interface YSYSegmentControl()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) HMSegmentedControl   *hmSegmentedControl;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger            selectedChannel;

@end

@implementation YSYSegmentControl

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _selectedChannel = 0;
        [self addSubview:self.hmSegmentedControl];
//        self.hmSegmentedControl.sectionTitles = @[@"ewew",@"sdfsf",@"sadfasdf"];
        
        __weak typeof(self) weakSelf = self;
        [self.hmSegmentedControl setIndexChangeBlock:^(NSInteger index) {
            [weakSelf yzt_segmentClicked:index];
        }];
        
    }
    return self;
}

#pragma mark private
- (void)yzt_segmentClicked:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction = index > [self.viewControllers indexOfObject:[self.pageViewController.viewControllers lastObject]] ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageViewController setViewControllers:@[[self.viewControllers objectAtIndex:index]]
                                      direction:direction
                                       animated:YES
                                     completion:NULL];
    self.selectedChannel = index;
}

-(void)yzt_reloadTopViewData
{
    if (self.selectedChannel >= self.channelName.count) {
        self.selectedChannel = self.channelName.count-1;
    }
    
    //字段不够长的话，iOS10中无法显示
    NSMutableArray *sectionArr = [NSMutableArray array];
    for(int i = 0; i < self.channelName.count; i++){
        [sectionArr addObject:[NSString stringWithFormat:@"%@     ",self.channelName[i]]];
    }
    self.hmSegmentedControl.sectionTitles = sectionArr;
    self.hmSegmentedControl.selectedSegmentIndex = self.selectedChannel;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    return self.viewControllers[--index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    
    if ((index == NSNotFound)||(index+1 >= [self.viewControllers count])) {
        return nil;
    }
    return self.viewControllers[++index];
}

- (void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed){
        return;
    }
    
    _selectedChannel = [self.viewControllers indexOfObject:[viewController.viewControllers lastObject]];
    [self.hmSegmentedControl setSelectedSegmentIndex:_selectedChannel animated:YES];
}

#pragma mark setter && getter
- (void)setChannelName:(NSMutableArray *)channelName
{
    _channelName = channelName;
    [self yzt_reloadTopViewData];
}

- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    [self.pageViewController setViewControllers:@[[viewControllers objectAtIndex:_selectedChannel]] direction:UIPageViewControllerNavigationDirectionForward  animated:NO completion:nil];
}

//- (void)setPageViewDic:(NSMutableDictionary *)pageViewDic
//{
//    _pageViewDic = pageViewDic;
//}

- (void)setSegmentController:(UIViewController *)segmentController
{
    _segmentController = segmentController;
}

- (HMSegmentedControl *)hmSegmentedControl
{
    if (!_hmSegmentedControl) {
        CGFloat viewWidth = CGRectGetWidth(self.frame);
        _hmSegmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth- 40, kHeightOfTopScrollView)];
        _hmSegmentedControl.selectedSegmentIndex = 0;
        
        //默认colors
        _hmSegmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16]};

        _hmSegmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16]};
        
        _hmSegmentedControl.backgroundColor = [UIColor colorWithRed:45./255 green:68.0/255 blue:134.0/255 alpha:1];
        _hmSegmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        
        //默认style
        _hmSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _hmSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//        _hmSegmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
        _hmSegmentedControl.selectionIndicatorHeight = 2.0;
        _hmSegmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(4.0, 0, 0, 0);
        _hmSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 18, 0, 18);
    }
    return _hmSegmentedControl;
}

- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_pageViewController.view];
        
        [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hmSegmentedControl.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _pageViewController;
}



@end
