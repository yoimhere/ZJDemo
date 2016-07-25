//
//  ViewController.m
//  ZJOpenGL_ES
//
//  Created by yuzhijie on 16/7/18.
//  Copyright © 2016年 yuzhijie. All rights reserved.
//

#import "ViewController.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ViewController ()

@property(strong, nonatomic) CAEAGLLayer *eaglLayer;
@property(strong, nonatomic) EAGLContext *context;
@property(assign, nonatomic) GLuint colorRenderBuffer;
@property(assign, nonatomic) GLuint frameBuffer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
