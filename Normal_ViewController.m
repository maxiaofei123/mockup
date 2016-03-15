//
//  Normal_ViewController.m
//  mockup
//
//  Created by susu on 16/3/15.
//  Copyright © 2016年 su. All rights reserved.
//

#import "Normal_ViewController.h"

@interface Normal_ViewController ()

@property(nonatomic,assign)NSInteger  secondTime;
@property(nonatomic,assign)NSInteger minuteTime;

@end

@implementation Normal_ViewController

@synthesize back,add,subtract,next;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [back setBackgroundImage:[UIImage imageNamed:@"powerBack.png"] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage imageNamed:@"powerNext.png"] forState:UIControlStateNormal];
    [add setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [subtract setBackgroundImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
    _secondTime = 0;
    _minuteTime = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeTextColor
{
    NSString * minuteStr ;
    
    if (self.minuteTime < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld",self.minuteTime];
    }else
    {
        minuteStr =[NSString stringWithFormat:@"%ld",self.minuteTime];
    }
    
  
    
}

- (IBAction)backAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}

- (IBAction)subtractAction:(id)sender {
    
    if (self.minuteTime > 0) {
        
        self.minuteTime --;
    }
    
    [self changeTextColor];
}

- (IBAction)addAction:(id)sender {
    
    if (self.minuteTime < 59) {
        
        self.minuteTime ++;
    }
    
    [self changeTextColor];
}
@end
