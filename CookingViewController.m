//
//  CookingViewController.m
//  mockup
//
//  Created by su on 16/3/10.
//  Copyright © 2016年 su. All rights reserved.
//

#import "CookingViewController.h"
#import "Normal_ViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DataDoc.h"
#import "MDRadialProgressView.h"

static SystemSoundID shake_sound_male_id = 0;

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define backGroudColor  [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.];

#define widthNormal 667
#define heightNormal 375

@interface CookingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) DataDoc * dataDoc;
@property (nonatomic ,strong) MDRadialProgressView *radialView;

@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;

@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton  * button2;

@property(nonatomic,strong)UIImageView * imageView;

@property (nonatomic,assign) NSInteger index;

@property(nonatomic,strong)UIView * lableBgView;

@property(nonatomic,assign)BOOL close;

@property (strong, nonatomic) UITableView *myTableView;
@property (strong ,nonatomic) UIView * dishView;

@property (strong ,nonatomic) NSTimer * timer;
@property (nonatomic ,assign) NSInteger  countTime;

@property (strong ,nonatomic) NSTimer * timerOnetime;
@property (strong ,nonatomic) NSTimer * doneTimer;
@property (assign ,nonatomic) NSInteger  doneTime;
@property (nonatomic ,assign) NSInteger  timeOne;
@property (nonatomic ,assign) NSInteger  numberTime;

@property (nonatomic ,strong) NSTimer * outTimer;

@property (nonatomic ,assign) BOOL flagShow;
@property (nonatomic ,assign) NSInteger flagIndex;

@property (nonatomic ,strong)AVSpeechSynthesizer * AV;

@property(nonatomic,strong)UIView  * viewOne;

@property(nonatomic,assign)NSInteger outTimeFlag;
@property(nonatomic,assign)BOOL startBool;


@end

@implementation CookingViewController

@synthesize imageView;
@synthesize label1,label2,button1,button2;


-(void)viewWillDisappear:(BOOL)animated
{
    //取消定时器
    [self.timer invalidate];
    self.timer = nil;
    
    [self.timerOnetime invalidate];
    self.timerOnetime = nil;
    
    [self.outTimer invalidate];
    self.outTimer = nil;
    
    [self.doneTimer invalidate];
    self.doneTimer = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =  [UIColor whiteColor];
    
    [self DrawViewTwo];
    
    [self drawDishView];
    
    [self DrawViewOne];
    
    [self initData];
}

-(void)initData
{
    self.dataDoc = [[DataDoc alloc] init];
    
    self.doneTime = 6 ;
    
    self.countTime = 0;
    
    self.timeOne = 0;
    
    self.numberTime =0;
    
    self.index = 0 ;
    
    self.startBool = NO;
}

/*
 *绘制第一个要消失的界面
 */

-(void)DrawViewOne
{
    self.viewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthNormal, heightNormal)];
    
    self.viewOne.backgroundColor =  backGroudColor;
    [self.view addSubview:self.viewOne];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOut)];
    [self.viewOne addGestureRecognizer:singleTap];
    
    
    UILabel * lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, widthNormal, 50)];
    lableTitle.text = @"A.Kitchen";
    lableTitle.textAlignment = NSTextAlignmentCenter;
    lableTitle.textColor = [UIColor colorWithRed:195/255. green:196/255. blue:199/255. alpha:1.];
    lableTitle.font = [UIFont fontWithName:@"EncodeSans-Medium" size:40];
    [self.viewOne addSubview:lableTitle];
    
    UILabel * lableContent = [[UILabel alloc] initWithFrame:CGRectMake((widthNormal-500)/2, 130, 500,200)];
    
    lableContent.textColor = [UIColor colorWithRed:117/255. green:122/255. blue:129/255. alpha:1.];
    lableContent.font = [UIFont fontWithName:@"Lato-Light" size:32];
    lableContent.text = @"Sent when the application is about  move from active to inactive state. This can  for certain types of temporary interruptions such as an incoming phone call or SMS message) or when the user quits the user quits the application and it begins the transition to the background state.";
    
    lableContent.lineBreakMode = NSLineBreakByCharWrapping;
    lableContent.numberOfLines = 0;
    
    [self.viewOne addSubview:lableContent];
}

-(void)drawDishView
{
    self.dishView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthNormal, heightNormal)];
    self.dishView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dishView];
    
    UILabel * lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 47.5, widthNormal-250, 120)];
    lableTitle.text = @"Seared Salmon";
    lableTitle.textAlignment = NSTextAlignmentCenter;
    lableTitle.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:1.];
    lableTitle.font = [UIFont fontWithName:@"EncodeSans-Medium" size:36];
    
    [self.dishView addSubview:lableTitle];
    
    //文字加描边
    lableTitle.layer.shadowColor = [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.].CGColor;
    lableTitle.layer.shadowOffset = CGSizeMake(3,2);
    lableTitle.layer.shadowOpacity = 0.8;
    
    self.dishView.alpha = 0;

}

-(void)viewOut
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:2.0f];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDidStopSelector:@selector(dishViewChange)];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    
    self.viewOne.alpha = 0.0f;
    
    [UIView commitAnimations];
}

-(void)dishViewChange
{
    [self.viewOne removeFromSuperview];
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.dishView.alpha = 1;
    button1.alpha = 1.0;
    button2.alpha = 1.0;
    [UIView commitAnimations];

}

-(void)dishViewOut
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:2.0f];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDidStopSelector:@selector(yourChange)];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    
    self.dishView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)yourChange
{
    [self.dishView removeFromSuperview];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    
    self.myTableView.alpha = 1.0f;
    self.imageView.alpha = 1.0;

    [UIView commitAnimations];
    
}

-(void)labelOutView
{
    if (self.outTimeFlag > 0) {
        
        self.outTimeFlag -- ;
        
    }else{
        [self.outTimer invalidate];
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:3.0f];
        
        [UIView setAnimationDelegate:self];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationDidStopSelector:@selector(shenmewanyi)];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        
        self.myTableView.alpha = 0.0f;
        
        [UIView commitAnimations];
    }
}

-(void)shenmewanyi
{
    
    [self.myTableView removeFromSuperview];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:4.0f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    
    [UIView commitAnimations];
}


/*
 *绘制第二个要消失的界面
 */
-(void)DrawViewTwo
{
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthNormal, heightNormal)];
    imageView.backgroundColor = backGroudColor
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.close = NO;
    
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(widthNormal-140, 47.5, 120, 120)];
    [imageView addSubview:button1];
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont fontWithName:@"Lato-Medium" size:24];
    [button1 setTitle:@"0%" forState:UIControlStateNormal];
    

    button1.userInteractionEnabled = NO;
    
    button2 = [[UIButton alloc] initWithFrame:CGRectMake(widthNormal-140, 120+47.5+40, 120, 120)];
    [button2 addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button2];
    
    [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     button2.titleLabel.font = [UIFont fontWithName:@"Lato-Medium" size:24];
    [button2 setTitle:@"START" forState:UIControlStateNormal];
    button1.alpha = 0;
    button2.alpha = 0;
    
    //创建出CAShapeLayer
    float r = 100 ;
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(10,10, r, r);//设置shapeLayer的尺寸和位置
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 5.0f;
    self.shapeLayer.strokeColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(r / 2.f, r / 2.f)
                                                               radius:r / 2.f
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    self.flagShow = YES;
    self.flagIndex = 0;
    
    //添加并显示
    [button1.layer addSublayer:self.shapeLayer];
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //每隔一秒跟新本次步骤进度
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
    
    
    //本次步骤时间剩余5秒后，进入倒计时，更新按钮2
    self.timerOnetime = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(updateButton)
                                                       userInfo:nil
                                                        repeats:YES];
    self.timerOnetime.fireDate = [NSDate distantFuture];
    
    //结束时设置按钮闪动
    self.doneTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(finish)
                                                    userInfo:nil
                                                     repeats:YES];
    self.doneTimer.fireDate = [NSDate distantFuture];
    
    //步序结束 几秒后 文字消失
    self.outTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(labelOutView)
                                                    userInfo:nil
                                                     repeats:YES];
    self.outTimer.fireDate = [NSDate distantFuture];
    
    self.outTimeFlag = 4 ;
 
    [self initTableview];
    
    self.myTableView.alpha = 0.0;
    
}

-(void)finish
{
    if (self.doneTime > 0) {
        self.doneTime -- ;
        
        if (self.doneTime%2 == 1) {
           
            button2.alpha = 0.1 ;
        }else
        {
            button2.alpha = 0.7 ;
        }
        
    }else
    {
        Normal_ViewController * normal = [[Normal_ViewController alloc] init];
        [self presentViewController:normal animated:YES completion:nil];
    }

}

- (void)circleAnimationTypeOne
{
    if(self.countTime == 5) {
        //启动倒计时
        self.timerOnetime.fireDate = [NSDate distantPast];
    }
   
    if(self.countTime == 0 ) {
        
        //停止定时器 停止写入数据
        self.timer.fireDate = [NSDate distantFuture];
    }else{
    
        self.countTime = self.countTime - 1 ;
        //设置stroke起始点
        float f = 1-(double)self.countTime/(double)self.numberTime;
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = f ;
        
        [button1 setTitle:[NSString stringWithFormat:@"%.f%@",(f*100),@"%"] forState:UIControlStateNormal];
    }
}

/*
 *初始化设置tablieView
 */

-(void)initTableview
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 47.5, Main_Screen_Width-160, 280)style:UITableViewStyleGrouped];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.alpha = 0.0;
    [self.myTableView setTableFooterView:view];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.myTableView];
    self.myTableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, 120 , 0);
}

/*
 *under button action
 */

- (void)nextAction:(id)sender {
    
    if (!self.startBool) {
        
        self.startBool = YES;
        
        //dishView  out
        
        [self dishViewOut];
    }else {
        if (self.close) {
            
            button2.enabled = NO ;
            self.doneTimer.fireDate = [NSDate distantPast];
      
        }else{
            
            if (self.index < _dataDoc.allStepArr.count-1) {
                self.index ++;
                if (self.flagIndex == 0) {
                    
                    self.flagShow = YES;
                    
                }else
                {
                    self.flagIndex -- ;
                    
                }
            }
            
            [self updatemyTableView];
            
        }
    }
}

-(void)updateButton
{
    self.timeOne --;
   
    if (self.timeOne == 0 ) {
        [self playSound];
        //停止定时器 停止写入数据
        self.timerOnetime.fireDate = [NSDate distantFuture];
        
        self.button2.enabled = YES;
        self.button1.enabled = YES;
        
        if (self.index == _dataDoc.allStepArr.count -1) {
            
            button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
            [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
            
            self.outTimer.fireDate = [NSDate distantPast];
            
        }else{
        
            [button2 setBackgroundImage:[UIImage imageNamed:@"btn-NEXT-240x240-21.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"dbtn-NEXT-240x240-21.png"] forState:UIControlStateSelected];
            [button2 setTitle:@"" forState:UIControlStateNormal];
        }
    }else
    {
        self.button2.enabled = NO;

        [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
        [button2 setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeOne] forState:UIControlStateNormal];
        [self playSound];
    }
}


- (void)updatemyTableView {
    
    if ([[_dataDoc.timeDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)self.index]] && self.flagShow) {
        
        NSInteger time = [[_dataDoc.timeDic objectForKey:[NSString stringWithFormat:@"%ld",(long)self.index]] integerValue];

        if (time > 0 ) {
            if (time > 5) {
                
                self.numberTime = time;
                self.countTime = time;
                
                self.timeOne = 5;
                //启动定时器 写入数据
                self.timer.fireDate = [NSDate distantPast];

                self.button2.enabled = NO;

                if (self.index == _dataDoc.allStepArr.count -1) {
                   
                    self.close = YES;
                    
                    //启动定时器 写入数据
                    self.timerOnetime.fireDate = [NSDate distantPast];
                }
                
                self.shapeLayer.strokeStart = 0;
                self.shapeLayer.strokeEnd = 0;
                [button1 setTitle:@"0%" forState:UIControlStateNormal];
                
            }else
            {
                self.timeOne = time;
                self.shapeLayer.strokeStart = 0;
                self.shapeLayer.strokeEnd = 1;
                [button1 setTitle:@"100%" forState:UIControlStateNormal];
                
                //启动倒计时定时器 写入数据
                self.timerOnetime.fireDate = [NSDate distantPast];
            }
        }else
        {
            if (self.index == _dataDoc.allStepArr.count -1) {
                
                self.close = YES;
                
                button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
                
                [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
                [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
                
                
                self.outTimer.fireDate = [NSDate distantPast];
                
            }
            
            self.shapeLayer.strokeStart = 0;
            self.shapeLayer.strokeEnd = 1;
            
            [button1 setTitle:@"100%" forState:UIControlStateNormal];
        }
    }else
    {
        if (self.index == _dataDoc.allStepArr.count -1) {
            
            self.close = YES;

            button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateNormal];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"btn-blank-240x240-21.png"] forState:UIControlStateSelected];
            
            [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
            
            self.outTimer.fireDate = [NSDate distantPast];
            
        }
    }

    //刷新
    [self.myTableView reloadData];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0    inSection:self.index];
    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionTop animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataDoc.allStepArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LRCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else
    {
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.opaque = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    
    NSString * str = [_dataDoc.allStepArr objectAtIndex:indexPath.section] ;

    UILabel *  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, widthNormal-250, 120)];
    
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    titleLabel.numberOfLines = 0;
    titleLabel.text = str;

    [cell.contentView addSubview:titleLabel];
  
    cell.backgroundColor = [UIColor clearColor];
    
    BOOL bl = [self IsChinese:str];
    
    if (indexPath.section == self.index) {

        if (bl) {
            
           titleLabel.font = [UIFont fontWithName:@"FZLTHK--GBK1-0" size:32];
            
        }else{
            
            titleLabel.font = [UIFont fontWithName:@"Lato-Semibold" size:36];
        }
//        文字加描边
        titleLabel.layer.shadowColor = [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.].CGColor;
        titleLabel.layer.shadowOffset = CGSizeMake(3,2);
        titleLabel.layer.shadowOpacity = 0.8;

        titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:1.];
        
    }else
    {
        if (bl) {
                
            titleLabel.font = [UIFont fontWithName:@"FZLTXHK" size:32];
                
        }else{
                
            titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
        }

        titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:0.5];
    }

    if ([[_dataDoc.imageDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
        
        self.imageView.image = [UIImage imageNamed:[_dataDoc.imageDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]]];
        
    }else
    {
        self.imageView.image = nil;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 39.99;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void) playSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
        AudioServicesPlaySystemSound(shake_sound_male_id);
        // AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }
    
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
}


-(BOOL)IsChinese:(NSString *)str {
    
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];

        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
