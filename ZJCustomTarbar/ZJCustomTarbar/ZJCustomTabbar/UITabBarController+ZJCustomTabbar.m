//
//  UITabBarController+ZJCustomTabbar.m
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import "UITabBarController+ZJCustomTabbar.h"

#import <objc/runtime.h>


@implementation UITabBarController (ZJCustomTabbar)

+ (void)initialize
{
    if (self == [self class]) {
        Method originMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method newMethod = class_getInstanceMethod(self, @selector(zj_viewDidLoad));
        method_exchangeImplementations(originMethod, newMethod);
    }
}

- (void)zj_viewDidLoad{
    [self zj_viewDidLoad];
    ZJTabBar *tabbar = [ZJTabBar new];
    tabbar.zj_delegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
}

- (void)zj_tabbar:(ZJTabBar *)tabbar selectIndex:(NSInteger)selectIndex{
    self.selectedIndex = selectIndex;
}



@end
