//
//  YSYColumnSectionHeadView.h
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSYColumnSectionType) {
    YSYColumnSectionTypeUpper,
    YSYColumnSectionTypeBottom
};

@interface YSYColumnSectionHeadView : UICollectionReusableView

@property (nonatomic, assign) YSYColumnSectionType sectionType;

@end
