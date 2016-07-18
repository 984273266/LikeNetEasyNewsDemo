//
//  ViewController.m
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//  仿网易新闻

#import "ViewController.h"
#import "NewsTypeView.h"
#import "TypeData.h"
#import "NewsListView.h"

#define typeBtnWidth    80 //每个按钮的宽度
#define typeBtnHeight   40 //每个按钮的高度

@interface ViewController ()<NewsTypeViewDelegate, NewsListViewDelegate>
@property (nonatomic, strong) NewsTypeView * newsTypeView;
@property (nonatomic, strong) NewsListView * newsListView;

@property (nonatomic, strong) NSMutableArray * typeNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self.view addSubview:self.newsTypeView];
    [self.view addSubview:self.newsListView];
}

- (void) initData
{
    TypeData * type1 = [[TypeData alloc] init];
    type1.typeId = 1;
    type1.typeName = @"头条";
    type1.isClick = YES;
    [self.typeNameArray addObject:type1];
    
    TypeData * type2 = [[TypeData alloc] init];
    type2.typeId = 2;
    type2.typeName = @"财经";
    [self.typeNameArray addObject:type2];
    
    TypeData * type3 = [[TypeData alloc] init];
    type3.typeId = 3;
    type3.typeName = @"娱乐";
    [self.typeNameArray addObject:type3];
    
    TypeData * type4 = [[TypeData alloc] init];
    type4.typeId = 4;
    type4.typeName = @"体育";
    [self.typeNameArray addObject:type4];
    
    TypeData * type5 = [[TypeData alloc] init];
    type5.typeId = 5;
    type5.typeName = @"科技";
    [self.typeNameArray addObject:type5];
    
    TypeData * type6 = [[TypeData alloc] init];
    type6.typeId = 6;
    type6.typeName = @"网易号";
    [self.typeNameArray addObject:type6];
    
    TypeData * type7 = [[TypeData alloc] init];
    type7.typeId = 7;
    type7.typeName = @"移动互联";
    [self.typeNameArray addObject:type7];
    
    TypeData * type8 = [[TypeData alloc] init];
    type8.typeId = 8;
    type8.typeName = @"杭州";
    [self.typeNameArray addObject:type8];
    
    TypeData * type9 = [[TypeData alloc] init];
    type9.typeId = 9;
    type9.typeName = @"直播";
    [self.typeNameArray addObject:type9];
    
    self.newsListView.typeArray = self.typeNameArray;
    self.newsTypeView.typeNameArray = self.typeNameArray;
}

#pragma mark NewsTypeViewDelegate
- (void) scrollToItem:(int) pos
{
    [self.newsListView scrollToItem:pos];
}

#pragma mark NewsListViewDelegate
- (void) currentPos:(int) pos
{
    [self.newsTypeView typeScrollToItem:pos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *) typeNameArray
{
    if (!_typeNameArray) {
        _typeNameArray = [[NSMutableArray alloc] init];
    }
    return _typeNameArray;
}

- (NewsTypeView *) newsTypeView
{
    if (!_newsTypeView) {
        _newsTypeView = [[NewsTypeView alloc] init];
        _newsTypeView.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, typeBtnHeight);
        _newsTypeView.delegate = self;
    }
    return _newsTypeView;
}

- (NewsListView *) newsListView
{
    if (!_newsListView) {
        _newsListView = [[NewsListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.newsTypeView.frame), [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.newsTypeView.frame))];
        _newsListView.delegate = self;
    }
    return _newsListView;
}
@end
