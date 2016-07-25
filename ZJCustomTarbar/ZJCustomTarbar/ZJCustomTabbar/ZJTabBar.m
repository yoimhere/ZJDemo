//
//  ZJTabBar.m
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import "ZJTabBar.h"

@interface ZJTabBar ()

@property(strong, nonatomic) NSMutableArray *myItems;

@end

@implementation ZJTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.myItems removeAllObjects];
    NSInteger i = 0;
    for (UITabBarItem *barItem in self.items)
    {
       UIView *view = [barItem valueForKey:@"view"];
        view.hidden = YES;
        
        UIButton *btn = [[UIButton alloc] initWithFrame: view.frame];
        [btn setTitle:barItem.title forState:UIControlStateNormal];
        
        [btn setImage:barItem.image forState:UIControlStateNormal];
        if (self.myItems.count == 1) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-100, 0, 100, 0)];
        }
        [btn setImage:barItem.selectedImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(zj_selectItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [self.myItems addObject:btn];
        [self addSubview:btn];
        i++;
    }
}


- (void)zj_selectItem:(UIView *)item{
    if ([_zj_delegate respondsToSelector:@selector(zj_tabbar:selectIndex:)]) {
        [_zj_delegate zj_tabbar:self selectIndex:item.tag];
    }
}


- (NSMutableArray *)myItems{
    if (_myItems == nil) {
        _myItems = [NSMutableArray array];
    }
    return _myItems;
}

@end
