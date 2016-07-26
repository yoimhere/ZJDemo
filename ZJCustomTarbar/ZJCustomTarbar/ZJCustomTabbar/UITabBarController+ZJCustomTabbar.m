//
//  UITabBarController+ZJCustomTabbar.m
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import "UITabBarController+ZJCustomTabbar.h"
#import <objc/runtime.h>

static void *kCustomTabBarKey;


@interface UITabBarController ()
@end

@implementation UITabBarController (ZJCustomTabbar)

+ (void)initialize
{
    if (self == [self class])
    {
        Method originMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method newMethod = class_getInstanceMethod(self, @selector(zj_viewDidLoad));
        method_exchangeImplementations(originMethod, newMethod);
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder])
    {
        __weak typeof(self) weakSelf = self;
        ZJTabBar * customTabBar = [[ZJTabBar alloc] initWithItemSelected:^(NSInteger selectIndex) {
            weakSelf.selectedIndex = selectIndex;
        }];
        objc_setAssociatedObject(self, &kCustomTabBarKey, customTabBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return self;
}

- (void)zj_viewDidLoad
{
    [self zj_viewDidLoad];
    [self zj_setupTabBar];
}

- (void)zj_setupTabBar
{
    [self setValue:self.zj_customTabBar forKey:@"tabBar"];
}


-(ZJTabBar *)zj_customTabBar{
  return objc_getAssociatedObject(self, &kCustomTabBarKey);
}

@end
