//
//  NewsListView.m
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//  新闻列表

#import "NewsListView.h"
#import "TypeData.h"

#define SpaceSecond   60 //根据类型获取歌曲，间隔秒数

static NSString * const kCellReuseIdentifier = @"UserWorkCollectionViewCell";

@interface CollectionCell : UICollectionViewCell<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) TypeData * typeData;
@property (nonatomic, strong) NSMutableArray * newsArray;
@end

@implementation CollectionCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.myTableView];
    }
    return self;
}

- (void) setTypeData:(TypeData *)typeData
{
    _typeData = typeData;
    [self.newsArray removeAllObjects];
    if (typeData.typeId == 1) {
        [self.newsArray addObject:@"头条1"];
        [self.newsArray addObject:@"头条2"];
        [self.newsArray addObject:@"头条3"];
        [self.newsArray addObject:@"头条4"];
        [self.newsArray addObject:@"头条5"];
        [self.newsArray addObject:@"头条6"];
    } else if (typeData.typeId == 2) {
        [self.newsArray addObject:@"财经1"];
        [self.newsArray addObject:@"财经2"];
        [self.newsArray addObject:@"财经3"];
        [self.newsArray addObject:@"财经4"];
    } else if (typeData.typeId == 3) {
        [self.newsArray addObject:@"娱乐1"];
        [self.newsArray addObject:@"娱乐2"];
        [self.newsArray addObject:@"娱乐3"];
    } else if (typeData.typeId == 4) {
        [self.newsArray addObject:@"体育1"];
        [self.newsArray addObject:@"体育2"];
        [self.newsArray addObject:@"体育3"];
    } else if (typeData.typeId == 5) {
        [self.newsArray addObject:@"科技1"];
        [self.newsArray addObject:@"科技2"];
        [self.newsArray addObject:@"科技3"];
    } else if (typeData.typeId == 6) {
        [self.newsArray addObject:@"网易号1"];
        [self.newsArray addObject:@"网易号2"];
        [self.newsArray addObject:@"网易号3"];
    } else if (typeData.typeId == 7) {
        [self.newsArray addObject:@"移动互联1"];
        [self.newsArray addObject:@"移动互联2"];
        [self.newsArray addObject:@"移动互联3"];
    } else if (typeData.typeId == 8) {
        [self.newsArray addObject:@"杭州1"];
        [self.newsArray addObject:@"杭州2"];
        [self.newsArray addObject:@"杭州3"];
    } else if (typeData.typeId == 9) {
        [self.newsArray addObject:@"直播1"];
        [self.newsArray addObject:@"直播2"];
        [self.newsArray addObject:@"直播3"];
    }
    
    [self.myTableView reloadData];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsList"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsList"];
    }
    
    if (indexPath.row >= 0 && indexPath.row < self.newsArray.count) {
        cell.textLabel.text = [self.newsArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (UITableView *) myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [[UIView alloc] init];
    }
    return _myTableView;
}

- (NSMutableArray *) newsArray
{
    if (!_newsArray) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    return _newsArray;
}
@end

@interface NewsListView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * myCollectionView;
@property (nonatomic, assign) int currentPos;
@end
@implementation NewsListView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.myCollectionView];
    }
    return self;
}

//滚动到哪个位置
- (void) scrollToItem:(int) pos
{
    [self refreshCell:pos];
    
    [self.myCollectionView setContentOffset:CGPointMake(pos*([UIScreen mainScreen].bounds.size.width), 0) animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.typeArray)
        return self.typeArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row >= 0 && indexPath.row < self.typeArray.count) {
        TypeData * myTypeData = [self.typeArray objectAtIndex:indexPath.row];
        cell.typeData = myTypeData;
    }
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.frame));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.myCollectionView) {
        int currentPageNum = (int)(scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width));
        [self refreshCell:currentPageNum];
        if (self.delegate && [self.delegate respondsToSelector:@selector(currentPos:)]) {
            [self.delegate currentPos:currentPageNum];
        }
    }
}

- (void) refreshCell:(int) pos
{
    if (pos < 0) {
        pos = 0;
    }
    
    if (pos >= self.typeArray.count) {
        pos = (int)self.typeArray.count-1;
    }
    
    TypeData * tempData = [self.typeArray objectAtIndex:pos];
    if (tempData && ![self canGetData:tempData withPos:pos]) {
        return ;
    }
    //刷新
    [self.myCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:pos inSection:0]]];
}

//访问数据之间不能间隔时间太短
- (BOOL) canGetData:(TypeData *) typeData withPos:(int) pos
{
    if (typeData.lastGetDataTime) {
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date1 = [formatter dateFromString:typeData.lastGetDataTime];
        
        NSDate *date2 = [NSDate date];
        
        NSTimeInterval aTime = [date2 timeIntervalSinceDate:date1];
        
        int hour =(int)(aTime/3600);
        
        int minute = (int)(aTime-hour*3600)/60;
        
        float second =  aTime - hour*3600 - minute*60;
        NSLog(@"相隔：%f秒",second);
        if (second > SpaceSecond) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            typeData.lastGetDataTime = [formatter stringFromDate:[NSDate date]];
        } else {
            NSLog(@"间隔太短了");
            if (self.currentPos == pos) {
                return YES;
            }
            self.currentPos = pos;
            return NO;
        }
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        typeData.lastGetDataTime = [formatter stringFromDate:[NSDate date]];
        
    }
    return YES;
}

- (UICollectionView *) myCollectionView
{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.frame));
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.pagingEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.backgroundColor = [UIColor clearColor];
        [_myCollectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
        
        
    }
    return _myCollectionView;
}


@end
