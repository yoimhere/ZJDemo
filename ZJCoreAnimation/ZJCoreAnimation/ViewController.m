//
//  ViewController.m
//  ZJCoreText
//
//  Created by 余志杰 on 16/6/13.
//  Copyright © 2016年 余志杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //set up data
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        //add name
        [array addObject:@{@"name": [self randomName], @"image": [self randomAvatar]}];
    }
    self.items = array;
}

- (NSString *)randomName
{
    NSArray *first = @[@"Alice", @"Bob", @"Bill", @"Charles", @"Dan", @"Dave", @"Ethan", @"Frank"];
    NSArray *last = @[@"Appleseed", @"Bandicoot", @"Caravan", @"Dabble", @"Ernest", @"Fortune"];
    NSUInteger index1 = (rand()/(double)INT_MAX) * [first count];
    NSUInteger index2 = (rand()/(double)INT_MAX) * [last count];
    return [NSString stringWithFormat:@"%@ %@", first[index1], last[index2]];
}

- (NSString *)randomAvatar
{
    NSArray *images = @[@"Snowman", @"Igloo", @"Cone", @"Spaceship", @"Anchor", @"Key"];
    NSUInteger index = (rand()/(double)INT_MAX) * [images count];
    return images[index];
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellFlg = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlg];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlg];
    }

    NSDictionary *item = self.items[indexPath.row];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:item[@"image"] ofType:@"png"];
    //set image and text
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    cell.textLabel.text = item[@"name"];
    //set image shadow
    cell.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    cell.imageView.layer.shadowOpacity = 0.75;
    cell.clipsToBounds = YES;
    //set text shadow
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0, 2);
    cell.textLabel.layer.shadowOpacity = 0.5;
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
    
    return cell;
}


@end
