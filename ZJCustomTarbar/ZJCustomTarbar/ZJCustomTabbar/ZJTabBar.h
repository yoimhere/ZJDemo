//
//  ZJTabBar.h
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZJItemTypeOrigin,// Not Work For customItems
    ZJItemTypeInsert,
    ZJItemTypeReplace
}ZJItemType;

@interface ZJItem : NSObject

@property(strong, nonatomic) UIButton *buttonView;
@property(copy  , nonatomic) CGRect(^customViewFrameBlock)(CGRect originFrame);

@property(assign, nonatomic) NSInteger index;
@property(assign, nonatomic) ZJItemType type;
@property(copy  , nonatomic) void(^itemClicked)();


@end



@interface ZJTabBar : UITabBar

@property(nonatomic, copy) NSArray *customItems;
- (instancetype)initWithItemSelected:(void(^)(NSInteger selectIndex))itemSelected;

@end
