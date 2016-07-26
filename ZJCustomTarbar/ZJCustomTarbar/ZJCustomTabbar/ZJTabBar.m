//
//  ZJTabBar.m
//  ZJCustomTarbar
//
//  Created by yuzhijie on 16/7/25.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import "ZJTabBar.h"

@implementation ZJItem
@end

@interface ZJTabBar ()

@property(nonatomic, strong) UIButton *selectedButton;
@property(nonatomic, strong) NSMutableArray *myItems;
@property(nonatomic, copy) void(^itemSelected)(NSInteger index);

@end

@implementation ZJTabBar

#pragma mark -
#pragma mark - Init

- (instancetype)initWithItemSelected:(void(^)(NSInteger selectIndex))itemSelected
{
    if (self = [super init])
    {
        self.itemSelected = itemSelected;
    }
    return self;
}

- (instancetype)init
{
    NSAssert(false, @"init invalided");
    return nil;
}

#pragma mark -
#pragma mark - Main

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self removeOldItems];
    [self generateOriginItems];
    [self sortCustomsItems];
    [self generateCustomItems];
    
    [self setupViews];
}

- (void)removeOldItems
{
    for (ZJItem *oldItem in self.myItems) {
        [oldItem.buttonView removeFromSuperview];
    }
    [self.myItems removeAllObjects];
}

- (void)generateOriginItems
{
    for (NSInteger i = 0; i < self.items.count; i++)
    {
        UITabBarItem *barItem = self.items[i];
        UIView *view = [barItem valueForKey:@"view"];
        view.hidden = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:barItem.title forState:UIControlStateNormal];
        [btn setImage:barItem.image forState:UIControlStateNormal];
        [btn setImage:barItem.selectedImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        
        ZJItem *item = [ZJItem new];
        item.index = i;
        item.buttonView = btn;
        item.type = ZJItemTypeOrigin;
        
        [self.myItems addObject:item];
    }
}


- (void)sortCustomsItems
{
    NSSortDescriptor *typeSorter = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:NO comparator:^NSComparisonResult(NSNumber *item1, NSNumber *item2)
                                    {
        if(item2 > item1)
        {
            return NSOrderedDescending;
        }
        else if(item1 > item2)
        {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
                                    
    NSSortDescriptor *indexSorter = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];

    self.customItems = [self.customItems sortedArrayUsingDescriptors:@[typeSorter,indexSorter]];
}


- (void)generateCustomItems
{
    for (ZJItem *customItem in self.customItems)
    {
        ZJItemType type = customItem.type;
        switch (type)
        {
            case ZJItemTypeInsert:
            {
                [self.myItems insertObject:customItem atIndex:customItem.index];
                break;
            }
                
            case ZJItemTypeReplace:
            {
                [customItem.buttonView addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
                [self.myItems replaceObjectAtIndex:customItem.index withObject:customItem];
                break;
            }
                
            default:
                break;
        }
    }
}

- (void)setupViews
{
    CGSize size = self.frame.size;
    NSInteger itemCount = self.myItems.count;
    CGFloat itemW = size.width / self.myItems.count;
    
    for (NSInteger i = 0; i < itemCount; i++)
    {
        ZJItem *customItem = self.myItems[i];
        UIView *itemView = customItem.buttonView;
        itemView.tag = i;
        [self addSubview:itemView];
        
        itemView.frame = CGRectMake(itemW * i, 0, itemW, size.height);
        if (customItem.customViewFrameBlock)
        {
            itemView.frame = customItem.customViewFrameBlock(itemView.frame);
        }
    }
}

- (void)selectItem:(UIButton *)btn
{
    self.selectedButton = btn;

    ZJItem *item = self.myItems[btn.tag];
    ZJItemType type = item.type;

    switch (type)
    {
        case ZJItemTypeInsert:
        {

            break;
        }
            
        case ZJItemTypeOrigin:
        case ZJItemTypeReplace:
        {
            self.itemSelected(item.index);
        }
            
        default:
            break;
    }
    
    if (item.itemClicked) {
        item.itemClicked();
    }
}


#pragma mark -
#pragma mark - Setter / Getter

- (NSMutableArray *)myItems
{
    if (_myItems == nil) {
        _myItems = [NSMutableArray array];
    }
    return _myItems;
}

- (void)setSelectedButton:(UIButton *)selectedButton
{
    if (_selectedButton != selectedButton) {
        _selectedButton.selected = NO;
        selectedButton.selected = YES;
        _selectedButton = selectedButton;
    }
}


@end
