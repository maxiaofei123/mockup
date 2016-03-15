//
//  Normal_ViewController.m
//  mockup
//
//  Created by susu on 16/3/15.
//  Copyright © 2016年 su. All rights reserved.
//

#import "Normal_ViewController.h"

@interface Normal_ViewController ()

@end

@implementation Normal_ViewController

@synthesize back,add,subtract,next;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    back.layer.cornerRadius = 50 ;
    next.layer.cornerRadius = 50 ;
    add.layer.cornerRadius = 50 ;
    subtract.layer.cornerRadius = 50 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}

- (IBAction)subtractAction:(id)sender {
}

- (IBAction)addAction:(id)sender {
}
@end
