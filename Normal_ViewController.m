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

@property(nonatomic,assign)NSInteger power;

@property(nonatomic,assign)BOOL selectTens;

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

    self.power = 0;
    
    self.selectTens = NO;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteViewMinute)];
    [self.minutesView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* secondeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectViewSecond)];
    [self.secondView addGestureRecognizer:secondeTap];
    
}

-(void)selecteViewMinute
{

    self.selectTens = YES;
}

-(void)selectViewSecond
{
    
    self.selectTens = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reviewLabel
{

    self.powerLabel.text = [NSString stringWithFormat:@"%ld",self.power];
    
    //minutes
    
    if (self.minuteTime < 10) {
        
        self.timeMinuteTensLabel.text = @"0";
        self.timeMinuteLabel.text = [NSString stringWithFormat:@"%ld",self.minuteTime];
    }else
    {
        NSInteger ten = self.minuteTime/10;
        NSInteger unit = self.minuteTime%10;
        
        self.timeMinuteTensLabel.text = [NSString stringWithFormat:@"%ld",ten];
        self.timeMinuteLabel.text = [NSString stringWithFormat:@"%ld",unit];
    }
    
    //second
    if (self.secondTime < 10) {
        
        self.timeSecondTensLabel.text = @"0";
        self.timeSecondLabel.text = [NSString stringWithFormat:@"%ld",self.secondTime];
    }else
    {
        NSInteger ten = self.secondTime/10;
        NSInteger unit = self.secondTime%10;
        
        self.timeSecondTensLabel.text = [NSString stringWithFormat:@"%ld",ten];
        self.timeSecondLabel.text = [NSString stringWithFormat:@"%ld",unit];
    }

}

- (IBAction)backAction:(id)sender {
    
    if (self.power < 9) {
        self.power ++ ;
    }
    [self reviewLabel];
}

- (IBAction)nextAction:(id)sender {
    
    if (self.power > 0) {
        self.power --;
    }
     [self reviewLabel];
}

- (IBAction)subtractAction:(id)sender {
    
    if (self.selectTens) {
        if (self.minuteTime > 0) {
            
            self.minuteTime --;
        }
    }else
    {
        if (self.secondTime > 0) {
            
            self.secondTime --;
        }
    
    }
    
     [self reviewLabel];

}

- (IBAction)addAction:(id)sender {
    
    if (self.selectTens) {
        
        if (self.minuteTime < 59) {
            
            self.minuteTime ++;
        }
    }else
    {
        if (self.secondTime < 59) {
            
            self.secondTime ++;
            
        }else if(self.secondTime == 59)
        {
            if (self.minuteTime < 59) {
               self.minuteTime ++ ;
                self.secondTime = 0;
            }
        }
    }
    
     [self reviewLabel];

}
@end
