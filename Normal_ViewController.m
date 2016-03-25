//
//  Normal_ViewController.m
//  mockup
//
//  Created by susu on 16/3/15.
//  Copyright © 2016年 su. All rights reserved.
//

#import "Normal_ViewController.h"
#import "CLDashboardProgressView.h"
#define widthNormal 667
#define heightNormal 375
@interface Normal_ViewController ()

// 刻度
@property (nonatomic, strong) CLDashboardProgressView *timeProgress;
@property (nonatomic, strong) CLDashboardProgressView *powerProgress;

@property(nonatomic,assign)NSInteger  secondTime;
@property(nonatomic,assign)NSInteger minuteTime;

@property(nonatomic,assign)NSInteger power;

@property(nonatomic,assign)BOOL selectTens;

@end

@implementation Normal_ViewController

@synthesize back,add,subtract,next;
@synthesize timeProgress,powerProgress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _secondTime = 0;
    _minuteTime = 0;

    self.power = 0;
    
    self.selectTens = NO;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteViewMinute)];
    [self.minutesView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* secondeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectViewSecond)];
    [self.secondView addGestureRecognizer:secondeTap];
    
    [self drawDailView];

    
}

-(void)drawDailView
{
    timeProgress = [[CLDashboardProgressView alloc] initWithFrame:CGRectMake(25, 70, 300, 300)];
    
    timeProgress.center =  CGPointMake(170, 215);
    timeProgress.userInteractionEnabled = YES;
    
    timeProgress.backgroundColor = [UIColor clearColor];
    timeProgress.outerRadius = 145; // 外圈半径
    timeProgress.innerRadius = 125;  // 内圈半径
    timeProgress.beginAngle = 90;    // 起始角度
    
    timeProgress.progressColor = [UIColor whiteColor]; // 进度条填充色
    timeProgress.trackColor    = [UIColor colorWithRed:59/255. green:67/255. blue:77/255. alpha:1.];   // 进度条痕迹填充色
    timeProgress.outlineColor  = [UIColor clearColor];  // 进度条边框颜色
    timeProgress.outlineWidth  = 2;                    // 进度条边框线宽
    
    timeProgress.blockCount = 60;   // 进度块的数量
    timeProgress.minValue = 0;      // 进度条最小数值
    timeProgress.maxValue = 60;    // 进度条最大数值
    timeProgress.currentValue = self.minuteTime; // 进度条当前数值
    timeProgress.blockAngle = 3.5;   // 每个进度块的角度
    timeProgress.gapAngle = 1;     // 两个进度块的间隙的角度
    
    
    timeProgress.autoAdjustAngle = YES;  // 自动调整角度
    [self.backgroundView addSubview:timeProgress];
    
    /*
     *power
     */
    
    powerProgress = [[CLDashboardProgressView alloc] initWithFrame:CGRectMake(widthNormal-325, 70, 300, 300)];
    
    powerProgress.center =  CGPointMake(widthNormal-170, 215);
    
    powerProgress.backgroundColor = [UIColor clearColor];
    powerProgress.outerRadius = 145; // 外圈半径
    powerProgress.innerRadius = 125;  // 内圈半径
    powerProgress.beginAngle = 90;    // 起始角度
    
    powerProgress.progressColor = [UIColor whiteColor]; // 进度条填充色
    powerProgress.trackColor    = [UIColor colorWithRed:59/255. green:67/255. blue:77/255. alpha:1.];   // 进度条痕迹填充色
    powerProgress.outlineColor  = [UIColor clearColor];  // 进度条边框颜色
    powerProgress.outlineWidth  = 2;                    // 进度条边框线宽
    
    powerProgress.blockCount = 9;   // 进度块的数量
    powerProgress.minValue = 0;      // 进度条最小数值
    powerProgress.maxValue = 9;    // 进度条最大数值
    powerProgress.currentValue = self.power; // 进度条当前数值
    powerProgress.blockAngle = 28;   // 每个进度块的角度
    powerProgress.gapAngle = 2;     // 两个进度块的间隙的角度
    
    
    powerProgress.autoAdjustAngle = YES;  // 自动调整角度
    [self.backgroundView addSubview:powerProgress];
    
    
    [self.backgroundView bringSubviewToFront:back];
    [self.backgroundView bringSubviewToFront:next];
    [self.backgroundView bringSubviewToFront:add];
    [self.backgroundView bringSubviewToFront:subtract];
    [self.backgroundView bringSubviewToFront:self.timeView];
}

/*
 * 设置时间的刻度
 */

-(void)setSecondDail
{
    timeProgress.blockCount = 60;   // 进度块的数量
    timeProgress.minValue = 0;      // 进度条最小数值
    timeProgress.maxValue = 60;    // 进度条最大数值
    timeProgress.currentValue = self.secondTime; // 进度条当前数值
    timeProgress.blockAngle = 3.5;   // 每个进度块的角度
    timeProgress.gapAngle = 1;     // 两个进度块的间隙的角度
}

-(void)setMinutesDail
{
    timeProgress.blockCount = 12;   // 进度块的数量
    timeProgress.minValue = 0;      // 进度条最小数值
    timeProgress.maxValue = 12;    // 进度条最大数值
    timeProgress.currentValue = self.minuteTime; // 进度条当前数值
    timeProgress.blockAngle = 20;   // 每个进度块的角度
    timeProgress.gapAngle = 2.2;     // 两个进度块的间隙的角度
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
    powerProgress.currentValue = self.power;
    [self reviewLabel];
}

- (IBAction)nextAction:(id)sender {
    
    if (self.power > 0) {
        self.power --;
    }
    powerProgress.currentValue = self.power;
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
