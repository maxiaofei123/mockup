//
//  FirstViewController.m
//  mockup
//
//  Created by su on 16/3/10.
//  Copyright © 2016年 su. All rights reserved.
//

#import "FirstViewController.h"
#import "CookingViewController.h"
#import "Normal_ViewController.h"

#define Main_Screen_Height   [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width    [[UIScreen mainScreen] bounds].size.width
@interface FirstViewController ()
@property(nonatomic,strong) NSTimer * responsTimer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:39/255. green:44/255. blue:54/255. alpha:1.];
    
    UILabel * lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, Main_Screen_Width, 50)];
    lableTitle.text = @"A.Kitchen";
    lableTitle.textAlignment = NSTextAlignmentCenter;
    lableTitle.textColor = [UIColor colorWithRed:195/255. green:196/255. blue:199/255. alpha:1.];
    lableTitle.font = [UIFont fontWithName:@"EncodeSans-Medium" size:40];
    [self.view addSubview:lableTitle];
    
    UILabel * lableContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, Main_Screen_Width-20, 200)];
//    lableContent.textAlignment = NSTextAlignmentCenter;
    lableContent.textColor = [UIColor colorWithRed:117/255. green:122/255. blue:129/255. alpha:1.];
    lableContent.font = [UIFont fontWithName:@"EncodeSans-Regular" size:34];
    lableContent.text = @"Sent when the application is about  move from active to inactive state. This can  for certain types of temporary interruptions such as an incoming phone call or SMS message) or when the user quits the user quits the application and it begins the transition to the background state.";
    lableContent.lineBreakMode = UILineBreakModeWordWrap;
    lableContent.numberOfLines = 0;

    [self.view addSubview:lableContent];
//    
//    //初始化定时器
//    self.responsTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(goToNextView) userInfo:nil repeats:NO];
//    self.responsTimer.fireDate = [NSDate distantFuture];
//    self.responsTimer.fireDate = [NSDate distantPast];
//    
//    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToNextView)];
    [self.view addGestureRecognizer:singleTap];
}

-(void)goToNextView
{

//    //取消定时器
//    [self.responsTimer invalidate];
//    self.responsTimer = nil;
    
//    Normal_ViewController *view = [[Normal_ViewController alloc] init];
//    [self presentViewController:view animated:YES completion:nil];
    
    CookingViewController *view = [[CookingViewController alloc] init];
    [self presentViewController:view animated:YES completion:nil];
//    [self.navigationController pushViewController:view
//                                         animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
