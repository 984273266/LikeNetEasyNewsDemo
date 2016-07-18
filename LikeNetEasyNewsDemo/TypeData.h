//
//  TypeData.h
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeData : NSObject

@property (nonatomic, assign) int typeId; //类型id
@property (nonatomic, strong) NSString * typeName; //类型名称
@property (nonatomic, assign) float typeWidth;
@property (nonatomic, assign) BOOL isClick; //是否点击
@property (nonatomic, strong) NSString * lastGetDataTime; //记录根据歌曲类型获取歌曲，上一次获取的时间

@end
