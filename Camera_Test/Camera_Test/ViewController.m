//
//  ViewController.m
//  Camera_Test
//
//  Created by aaron on 2018/11/8.
//  Copyright © 2018年 aaron. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)push:(UIButton *)sender {
    [self.navigationController pushViewController:[NSClassFromString(@"CameraViewController") new] animated:YES];
}


@end
