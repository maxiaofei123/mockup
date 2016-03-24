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

static SystemSoundID shake_sound_male_id = 0;

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
@interface CookingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
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

@property (strong, nonatomic) UITableView *myTableView;

@property (strong ,nonatomic) NSTimer * timer;
@property (nonatomic ,assign) double  countTime;

@property (strong ,nonatomic) NSTimer * timerOnetime;
@property (strong ,nonatomic) NSTimer * doneTimer;
@property (assign ,nonatomic) NSInteger  doneTime;
@property (nonatomic ,assign) NSInteger  timeOne;
@property (nonatomic ,assign) NSInteger  numberTime;

@property (nonatomic ,strong) NSTimer * showCookTimer;
@property (nonatomic ,assign) NSInteger showCookFlag;

@property (nonatomic ,strong) NSTimer * animalLeftTimer;
@property (nonatomic ,assign) BOOL tableViewLeft;
@property (nonatomic ,assign) NSInteger animalFlag;

@property (nonatomic ,strong) NSTimer * outTimer;

@property (nonatomic ,assign) BOOL flagShow;
@property (nonatomic ,assign) NSInteger flagIndex;

@property (nonatomic ,strong)AVSpeechSynthesizer * AV;

@property(nonatomic,strong)UIView  * viewOne;

@property(nonatomic,assign)NSInteger outTimeFlag;


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
    
    [self.animalLeftTimer invalidate];
    self.animalLeftTimer = nil;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.];
    
    [self DrawViewTwo];
    
    [self DrawViewOne];
}

-(void)initData
{

    
}

/*
 *绘制第一个要消失的界面
 */

-(void)DrawViewOne
{
    self.viewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.viewOne.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.viewOne];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOut)];
    [self.viewOne addGestureRecognizer:singleTap];
    
    
    UILabel * lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, Main_Screen_Width, 50)];
    lableTitle.text = @"A.Kitchen";
    lableTitle.textAlignment = NSTextAlignmentCenter;
    lableTitle.textColor = [UIColor colorWithRed:195/255. green:196/255. blue:199/255. alpha:1.];
    lableTitle.font = [UIFont fontWithName:@"EncodeSans-Medium" size:40];
    [self.viewOne addSubview:lableTitle];
    
    UILabel * lableContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, Main_Screen_Width-20, 200)];
    lableContent.textColor = [UIColor colorWithRed:117/255. green:122/255. blue:129/255. alpha:1.];
    lableContent.font = [UIFont fontWithName:@"Lato-Light" size:32];
    lableContent.text = @"Sent when the application is about  move from active to inactive state. This can  for certain types of temporary interruptions such as an incoming phone call or SMS message) or when the user quits the user quits the application and it begins the transition to the background state.";
    
    lableContent.lineBreakMode = NSLineBreakByCharWrapping;
    lableContent.numberOfLines = 0;
    
    [self.viewOne addSubview:lableContent];
}

-(void)viewOut
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:2.0f];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDidStopSelector:@selector(yourChange)];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    
    self.viewOne.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)yourChange

{
    [self.viewOne removeFromSuperview];
    button2.hidden = NO;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.myTableView.alpha = 1.0f;
    self.imageView.alpha = 1.0;
    button1.alpha = 1.0;
    button2.alpha = 1.0;
    [UIView commitAnimations];
    
    //启动定时器
    self.showCookTimer.fireDate = [NSDate distantPast];
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
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    imageView.backgroundColor = [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    int h = (Main_Screen_Height - 240)/3;
    self.close = NO;
    
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-140, h, 120, 120)];
    [button1 addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"upNormal.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"upSelcted.png"] forState:UIControlStateSelected];
    
    button1.alpha = 0.7;
    button2.alpha = 0.7;
    button2 = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-140, 120+h+h, 120, 120)];
    [button2 addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     button2.titleLabel.font = [UIFont fontWithName:@"Lato-Semibold" size:50];
    
    
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(33,33, 54, 54);//设置shapeLayer的尺寸和位置
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 54.0f;
    self.shapeLayer.strokeColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.5].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(54 / 2.f, 54 / 2.f)
                                                               radius:54 / 2.f
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    self.flagShow = YES;
    self.flagIndex = 0;
    
    //添加并显示
    [button2.layer addSublayer:self.shapeLayer];
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
    
    
    //用定时器模拟数值输入的情况
    self.timerOnetime = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(updateButton)
                                                       userInfo:nil
                                                        repeats:YES];
    self.timerOnetime.fireDate = [NSDate distantFuture];
    
    self.doneTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(finish)
                                                    userInfo:nil
                                                     repeats:YES];
    self.doneTimer.fireDate = [NSDate distantFuture];
    
    
    self.outTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(labelOutView)
                                                    userInfo:nil
                                                     repeats:YES];
    self.outTimer.fireDate = [NSDate distantFuture];
    
    self.outTimeFlag = 4 ;
    
    //cook
    
    self.showCookTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(reloatTableview)
                                                   userInfo:nil
                                                    repeats:YES];
    self.showCookTimer.fireDate = [NSDate distantFuture];
    self.showCookFlag = 3;
    
    //amimal
    
    self.animalLeftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(animalLeftTableview)
                                                        userInfo:nil
                                                         repeats:YES];
    self.animalLeftTimer.fireDate = [NSDate distantFuture];
    
    self.tableViewLeft = NO;
    self.animalFlag = 3;
    

    
    self.doneTime = 6 ;
    
    self.countTime = 0;
    self.timeOne = 0;
    self.numberTime =0;
    
       
    self.index = 0 ;
    
    [self initTableview];
    
    self.myTableView.alpha = 0.0;
    self.imageView.alpha = 0.0;
    button1.alpha = 0.0;
    button2.alpha = 0.0;
    button1.hidden = YES;
    button2.hidden = YES;
}


-(void)animalLeftTableview
{
    if (self.animalFlag >0) {
        self.animalFlag -- ;
    }else{
        self.animalLeftTimer.fireDate = [NSDate distantFuture];
            //左移
        [UIView animateWithDuration:0.5 animations:^{
        self.myTableView.center = CGPointMake(self.myTableView.center.x-400,self.myTableView.center.y);
        }];
        self.tableViewLeft = YES;
        self.animalFlag = 3;
    }
}


-(void)animalRightTableView
{
    if (self.tableViewLeft) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.myTableView.center = CGPointMake(self.myTableView.center.x+400,self.myTableView.center.y);
        }];
        
        self.tableViewLeft = NO;
    }
}


-(void)reloatTableview
{
    if (self.showCookFlag > 0) {
        self.showCookFlag --;
    }else
    {
        [self.showCookTimer invalidate];
        self.showCookTimer = nil;
        
        [self updatemyTableView];
    }

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
    if (self.countTime < 0.001) {
        
        self.numberTime = 0;
        
        //停止定时器 停止写入数据
        self.timer.fireDate = [NSDate distantFuture];
//        self.shapeLayer.hidden = YES;
        //启动定时器
        self.timerOnetime.fireDate = [NSDate distantPast];
        
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = 0 ;
        
    }else
    {
        self.countTime = self.countTime - 0.1 ;
        
        //设置stroke起始点
        float f = 1-(double)self.countTime/(double)self.numberTime;
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = f ;
    }
}

/*
 *初始化设置tablieView
 */

-(void)initTableview
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width-150, 300)];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.alpha = 0.0;
    [self.myTableView setTableFooterView:view];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.myTableView];
    self.myTableView.scrollEnabled =NO; //设置tableview 不能滚动
}

/* 
 *top button action
 */

- (void)leftAction:(id)sender {
    
    if (self.index >0) {
        self.index --;
        self.flagIndex ++;
    }
    self.flagShow = NO;
    
    if (self.tableViewLeft) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.myTableView.center = CGPointMake(self.myTableView.center.x+400,self.myTableView.center.y);
        } completion:^(BOOL finished) {
            
            [self updatemyTableView];
            
        }];
        
        self.tableViewLeft = NO;
    }else
    {
        [self updatemyTableView];
    }
}

/*
 *under button action
 */

- (void)nextAction:(id)sender {
    
    if (self.close) {
        
        button2.enabled = NO ;
        self.doneTimer.fireDate = [NSDate distantPast];
  
    }else{
        
        if (self.index < self.allStepArr.count-1) {
            self.index ++;
            if (self.flagIndex == 0) {
                
                self.flagShow = YES;
                
            }else
            {
                self.flagIndex -- ;
            }
        }
        self.animalLeftTimer.fireDate = [NSDate distantFuture];
        self.animalFlag = 3;
        if (self.tableViewLeft) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.myTableView.center = CGPointMake(self.myTableView.center.x+400,self.myTableView.center.y);
            } completion:^(BOOL finished) {
              [self updatemyTableView];
                
            }];
            
            self.tableViewLeft = NO;
        }else
        {
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
        
        if (self.index == self.allStepArr.count -1) {
            
            button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
            [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
            
            self.outTimer.fireDate = [NSDate distantPast];
            
        }else{
        
            [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
            [button2 setTitle:@"" forState:UIControlStateNormal];
        }
    }else
    {
        self.button2.enabled = NO;
        self.button1.enabled = NO;
        
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
        [button2 setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeOne] forState:UIControlStateNormal];
        [self playSound];
    }
}


- (void)updatemyTableView {

    if (self.showCookFlag ==0) {
        self.showCookFlag = -1;
    }
    if ([[self.timeDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)self.index]] && self.flagShow) {
        
        NSInteger time = [[self.timeDic objectForKey:[NSString stringWithFormat:@"%ld",(long)self.index]] integerValue];

        if (time > 0 ) {
            if (time > 5) {
                
                self.numberTime = time - 5;
                self.countTime = time - 5;
                
                self.timeOne = 5;
                //启动定时器 写入数据
                self.timer.fireDate = [NSDate distantPast];
//                self.shapeLayer.hidden = NO;
                self.button2.enabled = NO;
                self.button1.enabled = NO;
              
                
                if (self.index == self.allStepArr.count -1) {
                    self.close = YES;
                    button1.hidden = YES;
                }else if(self.index ==0)
                {
                    button1.hidden = YES;
                }else
                {
                    button1.hidden = NO;
                }
                
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
                
            }else
            {
                self.timeOne = time;
                //启动定时器 写入数据
                self.timerOnetime.fireDate = [NSDate distantPast];
            }
        }else
        {
        
            if (self.index == self.allStepArr.count -1) {
                
                self.close = YES;
                
                button1.hidden = YES;
                
                button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
                
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
                [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
                self.outTimer.fireDate = [NSDate distantPast];
                
            }else if(self.index ==0)
            {
                button1.hidden = YES;
            }else
            {
                button1.hidden = NO;
            }
        }
    }else
    {
        
        
        if (self.index == self.allStepArr.count -1) {
            
            self.close = YES;
            
            button1.hidden = YES;
            
            button2.titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
            
            [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
            
            [button2 setTitle:[NSString stringWithFormat:@"FINISH"] forState:UIControlStateNormal];
            
            self.outTimer.fireDate = [NSDate distantPast];
            
        }else if(self.index ==0)
        {
            button1.hidden = YES;
        }else
        {
            button1.hidden = NO;
        }
    }

    //刷新
    [self.myTableView reloadData];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index    inSection:0];
    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionTop animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allStepArr.count;
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
    
    
    NSString * str = [self.allStepArr objectAtIndex:indexPath.row] ;

    UILabel *  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, Main_Screen_Width-180, 145)];
    
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    titleLabel.numberOfLines = 0;
    titleLabel.text = str;

    [cell.contentView addSubview:titleLabel];
  
    cell.backgroundColor = [UIColor colorWithRed:(52/255.0)green:(48/255.0)  blue:(48/255.0) alpha:.5];
    
    BOOL bl = [self IsChinese:str];
    
    if (indexPath.row == self.index) {

        if (bl) {
            
           titleLabel.font = [UIFont fontWithName:@"FZLTHK--GBK1-0" size:32];
            
        }else{
            
            titleLabel.font = [UIFont fontWithName:@"Lato-Semibold" size:36];
        }
        
        titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:1.];
        
    }else
    {
        if (self.showCookFlag !=-1 && self.showCookFlag !=5) {
            
            titleLabel.text = @"";
            cell.backgroundColor = [UIColor clearColor];
            
        }else{
            
            self.showCookFlag = 5;
           
            if (bl) {
                
                titleLabel.font = [UIFont fontWithName:@"FZLTXHK" size:32];
                
            }else{
                
                titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            }

            titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:0.5];
        }
        
    }

    if ([[self.imageDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
        
        self.imageView.image = [UIImage imageNamed:[self.imageDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]]];
        
        if (self.showCookFlag ==5){
            
            self.animalLeftTimer.fireDate = [NSDate distantPast];
            self.animalFlag = 3;
        }
        
    }else
    {
        self.imageView.image = nil;
        cell.backgroundColor = [UIColor clearColor];
    }

    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self animalRightTableView];
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
