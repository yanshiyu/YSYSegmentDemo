//
//  YSYColumnCell.h
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSYColumnCellType) {
    YSYColumnCellTypeUpper,
    YSYColumnCellTypeBottom
};

@interface YSYColumnCell : UICollectionViewCell

@property (nonatomic, copy)   NSString          *data;
@property (nonatomic, assign) YSYColumnCellType cellType;

@end
