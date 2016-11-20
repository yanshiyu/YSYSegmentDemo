//
//  YSYManageColumnView.h
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSYManageColumnView;

@protocol YSYColumnViewDelegate <NSObject>

- (void)columnView:(YSYManageColumnView *)columnView withTitleArray:(NSMutableArray *)titleArray;

@end

@interface YSYManageColumnView : UIView

@property (nonatomic, strong) NSMutableArray *upperArray;
@property (nonatomic, strong) NSMutableArray *bottomArray;
@property (nonatomic, assign) id<YSYColumnViewDelegate>delegate;


@end
