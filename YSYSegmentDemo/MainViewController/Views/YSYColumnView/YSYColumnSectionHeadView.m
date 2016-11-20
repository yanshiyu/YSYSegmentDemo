//
//  YSYColumnSectionHeadView.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYColumnSectionHeadView.h"
#import "Masonry.h"

@interface YSYColumnSectionHeadView()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;

@end

@implementation YSYColumnSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1];
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor colorWithRed:98/255.0f green:98/255.0f blue:98/255.0f alpha:1];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(70);
        }];
        
        _detailLab = [[UILabel alloc] init];
        _detailLab.textColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
        _detailLab.font = [UIFont systemFontOfSize:12];
        _detailLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_detailLab];
        [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLab.mas_right).offset(0);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(160);
        }];

    }
    return self;
}


- (void)setSectionType:(YSYColumnSectionType)sectionType
{
    switch (sectionType) {
        case YSYColumnSectionTypeUpper:
        {
            _titleLab.text = @"已添加";
            _detailLab.text = @"点击删除，长按拖动顺序";
        }
            break;
        case YSYColumnSectionTypeBottom:
        {
            _titleLab.text = @"未添加";
            _detailLab.text = @"点击添加";
        }
            break;
        default:
            break;
    }
}

@end
