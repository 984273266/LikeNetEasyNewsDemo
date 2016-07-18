//
//  TypeData.m
//  LikeNetEasyNewsDemo
//
//  Created by xpp on 16/7/15.
//  Copyright © 2016年 xpp. All rights reserved.
//

#import "TypeData.h"
#import <UIKit/UIKit.h>

@implementation TypeData

- (void) setTypeName:(NSString *)typeName
{
    _typeName = typeName;
    
    UIFont * font = [UIFont systemFontOfSize:15];
    NSDictionary *attributes2 = @{NSFontAttributeName:font};
    self.typeWidth = [typeName sizeWithAttributes:attributes2].width + 30;
    
}

@end
