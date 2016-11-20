//
//  YSYCollectionView.h
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/13.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSYCollectionViewDelegate <NSObject>

- (void)ysy_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)ysy_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface YSYCollectionView : UICollectionView

@property (nonatomic, assign) id<YSYCollectionViewDelegate>ysyDelegate;


@end
