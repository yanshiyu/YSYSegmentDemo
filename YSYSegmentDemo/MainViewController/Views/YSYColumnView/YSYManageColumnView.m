//
//  YSYManageColumnView.m
//  YSYSegmentDemo
//
//  Created by yanshiyu on 16/6/8.
//  Copyright © 2016年 yanshiyu. All rights reserved.
//

#import "YSYManageColumnView.h"
#import "Masonry.h"
#import "YSYColumnCell.h"
#import "YSYColumnSectionHeadView.h"
#import "YSYCollectionView.h"

static NSString *cellId = @"cellId";
static NSString *headId = @"headId";

#define cellWidth  ([[UIScreen mainScreen] bounds].size.width - 5*15)/4

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YSYManageColumnView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,YSYCollectionViewDelegate>

@property (nonatomic, strong) YSYCollectionView *collectionView;
@property (nonatomic, strong) UIView            *collectionHeadView;
@property (nonatomic, strong) UIView            *tempMoveCell;
@property (nonatomic, assign) CGPoint           lastPoint;
@property (nonatomic, strong) NSIndexPath       *originalIndexPath;
@property (nonatomic, strong) NSIndexPath       *moveIndexPath;
@property (nonatomic, assign) CGFloat           columnViewHeight;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation YSYManageColumnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.collectionView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    }
    return self;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.bottomArray.count != 0) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.upperArray.count;
    }else{
        return self.bottomArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSYColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        cell.data = [self.upperArray objectAtIndex:indexPath.row];
        cell.cellType = YSYColumnCellTypeUpper;
        
    }else{
        cell.data = [self.bottomArray objectAtIndex:indexPath.row];
        cell.cellType = YSYColumnCellTypeBottom;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    YSYColumnSectionHeadView *headView = (YSYColumnSectionHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        headView.sectionType = YSYColumnSectionTypeUpper;
        
    }else{
        
        headView.sectionType = YSYColumnSectionTypeBottom;
    }
    return headView;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *text = [self.upperArray objectAtIndex:indexPath.row];
        if (![text isEqualToString:@"AA"] && self.upperArray.count > 4) {
            [self.upperArray removeObject:text];
            [self.bottomArray addObject:text];
            [self.collectionView reloadData];
        }
    }else{
        NSString *text = [self.bottomArray objectAtIndex:indexPath.row];
        [self.bottomArray removeObject:text];
        [self.upperArray addObject:text];
        [self.collectionView reloadData];
    }
    [self ysy_refreshColumnViewHeight];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, 28);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.frame.size.width, 44);
}

//设置每组的cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,15,21.5,15);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 23;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12.5;
}

#pragma mark YSYCollectionViewDelegate
- (void)ysy_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    self.longPress.enabled = indexPath.row != 0;
}

- (void)ysy_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.longPress.enabled = YES;
}

#pragma mark event response
- (void)longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self ysy_gestureBegan:longPress];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self ysy_gestureChange:longPress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [self ysy_gestureEndOrCancle:longPress];
        }
            break;
        default:
            break;
    }
}

- (void)buttonClick
{
    if ([self.delegate respondsToSelector:@selector(columnView:withTitleArray:)]) {
        [self.delegate columnView:self withTitleArray:self.upperArray];
    }
}

- (void)close
{
    [self removeFromSuperview];
}

#pragma mark private method
- (void)ysy_refreshColumnViewHeight
{
    if (self.bottomArray.count%4 == 0)
    {
        if (self.bottomArray.count != 0) {
            _columnViewHeight = 210;
        }
        else{
            _columnViewHeight = 170;
        }
        
    }
    else if (self.bottomArray.count%4 == 1)
    {
        _columnViewHeight = 260;
    }
    else if (self.bottomArray.count%4 == 2)
    {
        _columnViewHeight = 260;
    }else if (self.bottomArray.count%4 == 3)
    {
        _columnViewHeight = 260;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_columnViewHeight);
    }];
}

- (void)ysy_addGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    longPress.delegate = self;
    [_collectionView addGestureRecognizer:longPress];
    
    self.longPress = longPress;
}

- (void)ysy_gestureBegan:(UILongPressGestureRecognizer *)longPress
{
    _originalIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
    YSYColumnCell *cell = (YSYColumnCell *)[self.collectionView cellForItemAtIndexPath:_originalIndexPath];
    cell.hidden = YES;
    _tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
    _tempMoveCell.frame = cell.frame;
    [self.collectionView addSubview:_tempMoveCell];
    _lastPoint = [longPress locationOfTouch:0 inView:longPress.view];

}

- (void)ysy_gestureChange:(UILongPressGestureRecognizer *)longPress
{
    CGFloat tranX = [longPress locationOfTouch:0 inView:longPress.view].x - _lastPoint.x;
    CGFloat tranY = [longPress locationOfTouch:0 inView:longPress.view].y - _lastPoint.y;
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    
    _lastPoint = [longPress locationOfTouch:0 inView:longPress.view];
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:_lastPoint];
    YSYColumnCell *cell = (YSYColumnCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (index.row != 0 || !CGRectIntersectsRect(cell.frame, _tempMoveCell.frame)) {
        [self ysy_changeCell];
    }
}

- (void)ysy_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPress
{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_originalIndexPath];
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = cell.center;
    } completion:^(BOOL finished) {
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
    }];
}

- (void)ysy_changeCell
{
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]){

        if ([self.collectionView indexPathForCell:cell].section == 0) {
            //计算中心距
            CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
            CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
            if (spacingX <= _tempMoveCell.bounds.size.width / 2.0f && spacingY <= _tempMoveCell.bounds.size.height / 2.0f) {
                _moveIndexPath = [self.collectionView indexPathForCell:cell];
                //更新数据源
                
                [self ysy_updateSourseData];
                    
                    //移动
                [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
                    
                    //设置移动后的起始indexPath
                _originalIndexPath = _moveIndexPath;
                
                break;
            }
        }
    }
}

- (void)ysy_updateSourseData
{
    id objc = [self.upperArray objectAtIndex:_originalIndexPath.row];
    [self.upperArray removeObject:objc];
    [self.upperArray insertObject:objc atIndex:_moveIndexPath.row];
}

#pragma mark setter && getter
- (void)setBottomArray:(NSMutableArray *)bottomArray
{
    _bottomArray = bottomArray;
    [self ysy_refreshColumnViewHeight];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[YSYCollectionView alloc] initWithFrame:self.frame collectionViewLayout:layOut];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.ysyDelegate = self;
        [_collectionView registerClass:[YSYColumnCell class] forCellWithReuseIdentifier:cellId];
        //===========mark============
        [_collectionView registerClass:[YSYColumnSectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headId];
        
        [self ysy_addGesture];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.collectionHeadView.mas_bottom);
            make.height.mas_equalTo(300);
        }];
    }
    return _collectionView;
}

- (UIView *)collectionHeadView
{
    if (!_collectionHeadView) {
        _collectionHeadView = [[UIView alloc] init];
        _collectionHeadView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
        [self addSubview:_collectionHeadView];
        [_collectionHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(64);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"栏目管理";
        label.textColor = UIColorFromRGB(0x4a4a4a);
        label.font = [UIFont systemFontOfSize:16];
        [_collectionHeadView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_collectionHeadView);
            make.width.mas_equalTo(80);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_collectionHeadView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_collectionHeadView);
            make.width.mas_equalTo(60);
        }];
        
    }
    return _collectionHeadView;
}



@end
