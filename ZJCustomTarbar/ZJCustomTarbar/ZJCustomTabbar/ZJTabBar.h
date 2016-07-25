//
//  ZJTabBar.h
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTabBar;
@protocol ZJTabBarDelegate  <NSObject>

- (void)zj_tabbar:(ZJTabBar *)tabbar selectIndex:(NSInteger)selectIndex;

@end

@interface ZJTabBar : UITabBar

@property(weak, nonatomic) id<ZJTabBarDelegate> zj_delegate;
@property(copy, nonatomic) UIView* (^customItemBlock)(NSInteger index);

@end
