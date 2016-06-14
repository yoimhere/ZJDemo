//
//  ViewController.m
//  ZJCoreText
//
//  Created by 余志杰 on 16/6/13.
//  Copyright © 2016年 余志杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testMainTheard];
}


//测试Runloop主线程

- (void)testMainTheard{
    // 获得当前thread的Run loop
    CFRunLoopRef cfRunLoop  = CFRunLoopGetCurrent();
    // 设置Run Loop observer的运行环境
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    
    // 创建Run loop observer对象
    // 第一个参数用于分配该observer对象的内存
    // 第二个参数用以设置该observer所要关注的的事件，详见回调函数myRunLoopObserver中注释
    // 第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
    // 第四个参数用于设置该observer的优先级
    // 第五个参数用于设置该observer的回调函数
    // 第六个参数用于设置该observer的运行环境
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    // 将新建的observer加入到当前的thread的run loop
    CFRunLoopAddObserver(cfRunLoop, observer, kCFRunLoopDefaultMode);
}

void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    logRunLoopActivity(activity);
}

void logRunLoopActivity(CFRunLoopActivity activity){
    NSString *text = nil;
    switch (activity) {
        case kCFRunLoopEntry:
            text = @"kCFRunLoopEntry";
            break;
        case kCFRunLoopBeforeTimers:
            text = @"kCFRunLoopBeforeTimers";
            break;
        case kCFRunLoopBeforeSources:
            text = @"kCFRunLoopBeforeSources";
            break;
        case kCFRunLoopBeforeWaiting:
            text = @"kCFRunLoopBeforeWaiting";
            break;
        case kCFRunLoopAfterWaiting:
            text = @"kCFRunLoopAfterWaiting";
            break;
        default:
            text = @"kCFRunLoopAllActivities";
            break;
    }
    NSLog(@"%@",text);
}

@end
