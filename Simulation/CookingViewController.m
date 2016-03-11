//
//  CookingViewController.m
//  mockup
//
//  Created by su on 16/3/10.
//  Copyright © 2016年 su. All rights reserved.
//

#import "CookingViewController.h"
#import "AppDelegate.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
@interface CookingViewController ()


@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;

@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton  * button2;

@property(nonatomic,strong)UIImageView * imageView;

@property(nonatomic,strong) NSArray * allStepArr;
@property (nonatomic,assign) NSInteger index;

@property(nonatomic,strong)NSDictionary * imageDic;
@property(nonatomic,strong)NSDictionary * timeDic;

@property(nonatomic,strong)UIView * lableBgView;

@property(nonatomic,assign)BOOL close;
@end

@implementation CookingViewController

@synthesize imageView;
@synthesize label1,label2,button1,button2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    imageView.backgroundColor = [UIColor colorWithRed:39/255. green:44/255. blue:54/255. alpha:1.];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    int h = (Main_Screen_Height - 240)/3;
    self.close = NO;
    
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-150, h, 120, 120)];
    [button1 addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    button1.alpha = 0.7;
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"upNormal.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"upSelcted.png"] forState:UIControlStateSelected];

    
    button2 = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-150, 120+h+h, 120, 120)];
    [button2 addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.alpha = 0.7;
    [self.view addSubview:button2];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:40];
    
    
     self.allStepArr = [NSArray arrayWithObjects:@"cut open the salmon skin, then tumbled into sauces A, then massage salmon, make sauce evenly onto the salmon",
                        @"remove the salmon skin",
                        @"Add 2 tbs vegetable oil into the pan",
                        @"tumbled the salmon fillet into sauce A ",
                        @"covered salmon evenly with prepared sauce & massage for 1min",
                        @"stand salomn 3 minutes",
                        @"set aside for 3 minutes",
                        @"Pour vegetable oil 2soup into pan",
                        @"Add 2 tbs vegetable oil into the pan",
                        @"Under the salmon skin into the pan, then press the salomn middle",
                        @"place the salmon into the pan skin-side-down",
                        @"then press the salmon in the middle",
                        nil];
    
    self.imageDic = @{
                      @"0":@"1.jpg",
                      @"3":@"2.jpg",
                      @"5":@"3.jpg",
                      @"8":@"4.jpg",
                      @"10":@"5.jpg",
                      };
    
    self.timeDic = @{
                      @"0":@"0",
                      @"1":@"5",
                      @"2":@"9",
                      @"3":@"4",
                      @"4":@"7",
                      @"5":@"2",
                      @"6":@"7",
                      @"7":@"3",
                      @"8":@"8",
                      @"9":@"6",
                      @"10":@"0",
                      @"11":@"0",
                      @"12":@"0",
                      };
    
    self.index = 0 ;
    
    
    self.lableBgView  = [[UIView alloc] initWithFrame:CGRectMake(0, 20, Main_Screen_Width-160, 100)];
    self.lableBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.lableBgView];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Main_Screen_Width-200, 100)];
    label1.lineBreakMode = UILineBreakModeWordWrap;
    label1.numberOfLines = 0;
    label1.font = [UIFont fontWithName:@"EncodeSans-Medium" size:40];
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, Main_Screen_Width-200, 100)];
    label2.lineBreakMode = UILineBreakModeWordWrap;
    label2.numberOfLines = 0;
    label2.font = [UIFont fontWithName:@"EncodeSans-Regular" size:36];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor =[UIColor colorWithRed:117/255. green:122/255. blue:129/255. alpha:1.];;
    [self.view addSubview:label2];
  
    [self getNewFrame];
}

-(void)getNewFrame
{
    CGSize size = CGSizeMake( Main_Screen_Width-200,2000);
    
    NSString * str1 = [self.allStepArr objectAtIndex:self.index];
    
    CGSize labelsize = [str1 sizeWithFont:[UIFont systemFontOfSize:40] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    label1.frame = CGRectMake(20, 50, Main_Screen_Width-180, labelsize.height);
    label1.text = str1;
    
    if (self.index == self.allStepArr.count-1) {
        label2.text = @"";
        label2.frame = CGRectMake(20, labelsize.height + 100, 0, 0);
    }else
    {
        NSString * str2 = [self.allStepArr objectAtIndex:self.index+1];
        
        CGSize labelsize2 = [str2 sizeWithFont:[UIFont systemFontOfSize:40] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        label2.text = str2;
        label2.frame = CGRectMake(20, labelsize.height + 80, Main_Screen_Width-180, labelsize2.height);
    }
    
    NSLog(@"self.index =%ld",self.index);
    
    if ([[self.imageDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
        self.imageView.image = [UIImage imageNamed:[self.imageDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]]];
        
        self.lableBgView.frame = CGRectMake(0, 45, Main_Screen_Width-160, labelsize.height+10);
        
        self.lableBgView.backgroundColor = [UIColor blackColor];
        self.lableBgView.alpha=  0.5;
        
    }else
    {
        self.imageView.image = nil;
        self.lableBgView.backgroundColor = [UIColor clearColor];
    }
    
    if (self.close) {
        button1.hidden = YES ;
        [button2 setTitle:@"Done" forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
    }else{
                //button
        if ([[self.timeDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
            
            int time = [[self.timeDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]] intValue];
            if (time ==0 ) {
                [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
                [button2 setTitle:@"" forState:UIControlStateNormal];
            }else
            {
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
                [button2 setTitle:[NSString stringWithFormat:@"%d",time] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)leftAction:(id)sender {
    
    if (self.index >0) {
        self.index --;
    }

    [self getNewFrame];
}

- (void)nextAction:(id)sender {
    
    if (self.close) {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        UIWindow *window = app.window;
        
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0;
            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        } completion:^(BOOL finished) {
            exit(0);
        }];
    }else{
        
        if (self.index < self.allStepArr.count-1) {
            self.index ++;
        }

        if (self.index == self.allStepArr.count -1) {
            self.close = YES;
            
        }
        
        [self getNewFrame];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
