//
//  NewsListView.h
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsListViewDelegate <NSObject>

- (void) currentPos:(int) pos;

@end

@interface NewsListView : UIView
@property (nonatomic, strong) NSMutableArray * typeArray;
@property (nonatomic, weak) id<NewsListViewDelegate> delegate;

//滚动到哪个位置
- (void) scrollToItem:(int) pos;

@end
