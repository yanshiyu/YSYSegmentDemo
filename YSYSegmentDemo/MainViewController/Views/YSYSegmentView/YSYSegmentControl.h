//
//  YSYSegmentControl.h
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/7.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSYSegmentControl : UIView

@property (nonatomic, strong) UIViewController    *segmentController;
@property (nonatomic, strong) NSMutableArray      *viewControllers;
@property (nonatomic, strong) NSMutableArray      *channelName;
//@property (nonatomic, strong) NSMutableDictionary *pageViewDic;

@end
