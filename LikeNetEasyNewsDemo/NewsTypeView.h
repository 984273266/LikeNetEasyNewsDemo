//
//  NewsTypeView.h
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//  新闻类型

#import <UIKit/UIKit.h>

@protocol NewsTypeViewDelegate <NSObject>

- (void) scrollToItem:(int) pos; //滚动哪个位置

@end

@interface NewsTypeView : UIView

@property (nonatomic, strong) NSMutableArray * typeNameArray;
@property (nonatomic, weak) id<NewsTypeViewDelegate> delegate;

- (void) typeScrollToItem:(int) currentPos;

@end
