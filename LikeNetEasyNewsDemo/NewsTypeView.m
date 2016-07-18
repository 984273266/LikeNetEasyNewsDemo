//
//  NewsTypeView.m
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//  

#import "NewsTypeView.h"
#import "TypeData.h"

#define typeBtnWidth    80 //每个按钮的宽度
#define typeBtnHeight   40 //每个按钮的高度
#define totalSingSongLabelHeight   40 //显示唱歌次数高度
#define typeNormalColor  [UIColor blackColor]  //按钮未点击状态
#define typeSelectColor  [UIColor redColor]  //按钮点击状态

static NSString * const kCellReuseIdentifier = @"CollectionTypeViewCell";

@protocol CollectionTypeCellDelegate <NSObject>

- (void) refreshView:(int) typeId;

@end

@interface CollectionTypeCell : UICollectionViewCell

@property (nonatomic, strong) UIButton * typeButton;

@property (nonatomic, strong) TypeData * typeData;
@property (nonatomic, weak) id<CollectionTypeCellDelegate> delegate;

@end

@implementation CollectionTypeCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.typeButton];
    }
    return self;
}

- (void) setTypeData:(TypeData *)typeData
{
    _typeData = typeData;
    self.typeButton.tag = typeData.typeId;
    [self.typeButton setTitle:typeData.typeName forState:UIControlStateNormal];
    
    self.typeButton.frame = CGRectMake(0, 0, typeData.typeWidth, typeBtnHeight);
    
    if (typeData.isClick) {
        [_typeButton setTitleColor:typeSelectColor forState:UIControlStateNormal];
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:20];
    } else {
        [_typeButton setTitleColor:typeNormalColor forState:UIControlStateNormal];
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
}

- (void) clickChangeNewsType:(UIButton *) sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshView:)]) {
        [self.delegate refreshView:(int)sender.tag];
    }
}

- (UIButton *) typeButton
{
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_typeButton setTitleColor:typeNormalColor forState:UIControlStateNormal];
        
        [_typeButton addTarget:self action:@selector(clickChangeNewsType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeButton;
}

@end

@interface NewsTypeView()<UICollectionViewDelegate,UICollectionViewDataSource,CollectionTypeCellDelegate>

@property (nonatomic, strong) UICollectionView * myTypeCollectionView;

@end

@implementation NewsTypeView

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self addSubview:self.myTypeCollectionView];
    }
    return self;
}

- (void) typeScrollToItem:(int) currentPos
{
    if (currentPos < 0 || currentPos >= self.typeNameArray.count) {
        return;
    }
    
    for (int i=0; i<self.typeNameArray.count; i++) {
        TypeData * typeData = [self.typeNameArray objectAtIndex:i];
        if (typeData) {
            if (currentPos == i) {
                typeData.isClick = YES;
                currentPos = i;
            } else {
                typeData.isClick = NO;
            }
        }
    }
    
    [self.myTypeCollectionView reloadData];
    
    [self scrollToPos:currentPos];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.typeNameArray)
        return self.typeNameArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionTypeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row >= 0 && indexPath.row < self.typeNameArray.count) {
        cell.typeData = [self.typeNameArray objectAtIndex:indexPath.row];
    }
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < self.typeNameArray.count) {
        TypeData * typeData = [self.typeNameArray objectAtIndex:indexPath.row];
        return CGSizeMake(typeData.typeWidth, typeBtnHeight);
    }
    
    return CGSizeMake(0, typeBtnHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark CollectionTypeCellDelegate
- (void) refreshView:(int)typeId
{
    int currentPos = -1;
    for (int i=0; i<self.typeNameArray.count; i++) {
        TypeData * typeData = [self.typeNameArray objectAtIndex:i];
        if (typeData) {
            if (typeData.typeId == typeId) {
                typeData.isClick = YES;
                currentPos = i;
            } else {
                typeData.isClick = NO;
            }
        }
    }
    
    [self.myTypeCollectionView reloadData];
    [self scrollToPos:currentPos];
}

- (void) scrollToPos:(int) pos
{
    if (pos > -1 && pos < self.typeNameArray.count) {
        [self.myTypeCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:pos inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollToItem:)]) {
            [self.delegate scrollToItem:pos];
        }
    }
}

- (UICollectionView *) myTypeCollectionView
{
    if (!_myTypeCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, typeBtnHeight);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _myTypeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , typeBtnHeight) collectionViewLayout:flowLayout];
        _myTypeCollectionView.dataSource = self;
        _myTypeCollectionView.delegate = self;
        _myTypeCollectionView.pagingEnabled = YES;
        _myTypeCollectionView.showsVerticalScrollIndicator = NO;
        _myTypeCollectionView.showsHorizontalScrollIndicator = NO;
        _myTypeCollectionView.backgroundColor = [UIColor whiteColor];
        [_myTypeCollectionView registerClass:[CollectionTypeCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
        
        
    }
    return _myTypeCollectionView;
}
@end
