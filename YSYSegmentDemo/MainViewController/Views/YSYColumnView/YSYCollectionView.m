//
//  YSYCollectionView.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/13.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYCollectionView.h"

@implementation YSYCollectionView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (_ysyDelegate && [_ysyDelegate respondsToSelector:@selector(ysy_touchesBegan:withEvent:)]) {
        [_ysyDelegate ysy_touchesBegan:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (_ysyDelegate && [_ysyDelegate respondsToSelector:@selector(ysy_touchesEnded:withEvent:)]) {
        [_ysyDelegate ysy_touchesEnded:touches withEvent:event];
    }
}

@end
