//
//  YSYColumnCell.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYColumnCell.h"
#import "Masonry.h"

@interface YSYColumnCell()

@property(nonatomic, strong) UILabel *textLab;

@end

@implementation YSYColumnCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _textLab = [[UILabel alloc] init];
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.font = [UIFont systemFontOfSize:14];
        _textLab.layer.cornerRadius = CGRectGetHeight(self.frame)/2.0;
        _textLab.layer.masksToBounds = YES;
        [self.contentView addSubview:_textLab];
        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return self;
}

- (void)setData:(NSString *)data
{
    _textLab.text = data;
}

- (void)setCellType:(YSYColumnCellType)cellType
{
    switch (cellType) {
        case YSYColumnCellTypeUpper:
        {
            _textLab.backgroundColor = [UIColor colorWithRed:45./255 green:68.0/255 blue:134.0/255 alpha:1];
            _textLab.textColor = [UIColor whiteColor];
            
        }
            break;
        case YSYColumnCellTypeBottom:
        {
            _textLab.backgroundColor = [UIColor clearColor];
            _textLab.textColor = [UIColor colorWithRed:127/255.0f green:127/255.0f blue:127/255.0f alpha:1];
            _textLab.layer.borderWidth = 1.0;
            _textLab.layer.borderColor = [UIColor colorWithRed:45./255 green:68.0/255 blue:134.0/255 alpha:1].CGColor;
        }
            break;
        default:
            break;
    }
}


@end
