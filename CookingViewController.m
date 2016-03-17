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

@property (nonatomic ,strong) NSTimer * outTimer;

@property (nonatomic ,assign) BOOL flagShow;
@property (nonatomic ,assign) NSInteger flagIndex;

@property (nonatomic ,strong)AVSpeechSynthesizer * AV;

@property(nonatomic,strong)UIImageView  * viewOne;

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
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:50/255. green:58/255. blue:69/255. alpha:1.];
    
    [self viewTwo];
    
    self.viewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.viewOne.image = [UIImage imageNamed:@"5.jpg"];
    self.viewOne.userInteractionEnabled = YES;
    [self.view addSubview:self.viewOne];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOut)];
    [self.viewOne addGestureRecognizer:singleTap];

    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width-180, 150)];
    view.backgroundColor =[UIColor colorWithRed:(52/255.0)green:(48/255.0)  blue:(48/255.0) alpha:.5];
    [self.viewOne addSubview:view];
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Main_Screen_Width-200, 150)];
    lable.text = @"Seared Salmon";
    lable.font = [UIFont fontWithName:@"Lato-Semibold" size:36];
    lable.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:1.];
    [view addSubview:lable];
    
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
    
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1.0f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];

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

-(void)viewTwo
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
    
    self.doneTime = 6 ;
    
    self.countTime = 0;
    self.timeOne = 0;
    self.numberTime =0;
    
    self.allStepArr = [NSArray arrayWithObjects:@"cut open the salmon skin, then tumbled into sauces A,then massage salmon, make sauce evenly onto the salmon",
                       @"remove the salmon skin,Add 2 tbs vegetable oil into the pan",
                       
                       @"tumbled the salmon fillet into sauce A ",
                       @"covered salmon evenly with prepared sauce & massage for 1min",
                       @"stand salomn 3 minutes",
                       @"Pour vegetable oil 2soup into pan",
                       @"将3个鸡蛋打入碗内",
                       @"用叉子快速搅拌持续30秒，使蛋白和蛋黄充分融合",
                       @"将搅拌好的鸡蛋放到一边备用",
                       nil];
    
    
    //    @"Add 2 tbs vegetable oil into the pan",
    //    @"Under the salmon skin into the pan, then press the salomn middle",
    //    @"place the salmon into the pan skin-side-down",
    //    @"then press the salmon in the middle",
    self.imageDic = @{
                      @"0":@"1.jpg",
                      @"3":@"2.jpg",
                      @"5":@"3.jpg",
                      @"6":@"6.jpg",
                      @"8":@"4.jpg",
                      @"10":@"5.jpg",
                      };
    
    self.timeDic = @{
                     @"0":@"0",
                     @"1":@"6",
                     @"2":@"0",
                     @"3":@"7",
                     @"4":@"0",
                     @"5":@"3",
                     @"6":@"5",
                     @"7":@"0",
                     @"8":@"0",
                     @"9":@"6",
                     @"10":@"0",
                     @"11":@"7",
                     @"12":@"0",
                     };
    
    self.index = 0 ;
    
    
    [self initTableview];

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
        //启动定时器 写入数据
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

-(void)initTableview
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width-150, 300)];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.userInteractionEnabled = NO;
    
    [self.myTableView setTableFooterView:view];
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.myTableView];
}

- (void)leftAction:(id)sender {
    
    if (self.index >0) {
        self.index --;
        self.flagIndex ++;
    }
    self.flagShow = NO;
    
    [self updatemyTableView];
}


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
        
        [self updatemyTableView];
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
 
    CGSize size = CGSizeMake(Main_Screen_Width-175,2000);
    
    CGSize labelsize = [str sizeWithFont:[UIFont fontWithName:@"Lato-Semibold" size:32] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

    UILabel *  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, Main_Screen_Width-180, labelsize.height >145?145:labelsize.height)];
    
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    titleLabel.numberOfLines = 0;
    titleLabel.text = str;
    
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
//    
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    
//    [paragraphStyle1 setLineSpacing:1.0];
//    
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
//    
//    [titleLabel setAttributedText:attributedString1];
//    //设置行间距后适配高度显示
//    [titleLabel sizeToFit];
//
    [cell.contentView addSubview:titleLabel];
  
    
    BOOL bl = [self IsChinese:str];
    
    if (indexPath.row == self.index) {
        
        if (bl) {
            
           titleLabel.font = [UIFont fontWithName:@"FZLTHK--GBK1-0" size:32];
          
            CGSize size = CGSizeMake(Main_Screen_Width-180,2000);
            CGSize labelsize = [str sizeWithFont:[UIFont fontWithName:@"FZLTHK--GBK1-0" size:32] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            titleLabel.frame =CGRectMake(15, 5, Main_Screen_Width-180, labelsize.height >145?145:labelsize.height);
            
        }else{
            
            titleLabel.font = [UIFont fontWithName:@"Lato-Semibold" size:36];

            CGSize size = CGSizeMake(Main_Screen_Width-180,2000);
            CGSize labelsize = [str sizeWithFont:[UIFont fontWithName:@"Lato-Semibold" size:36] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            titleLabel.frame =CGRectMake(15, 5, Main_Screen_Width-180, labelsize.height >145?145:labelsize.height);
        }
        
        titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:1.];
        
    }else
    {
    
        if (bl) {
            
            titleLabel.font = [UIFont fontWithName:@"FZLTXHK" size:32];
            CGSize size = CGSizeMake(Main_Screen_Width-180,2000);
            CGSize labelsize = [str sizeWithFont:[UIFont fontWithName:@"FZLTXHK" size:32] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            titleLabel.frame =CGRectMake(15, 5, Main_Screen_Width-180, labelsize.height >145?145:labelsize.height);
            
        }else{
            
            titleLabel.font = [UIFont fontWithName:@"Lato-Light" size:32];
            CGSize size = CGSizeMake(Main_Screen_Width-180,2000);
            CGSize labelsize = [str sizeWithFont:[UIFont fontWithName:@"Lato-Light" size:32] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            
            titleLabel.frame =CGRectMake(15, 5, Main_Screen_Width-180, labelsize.height >145?145:labelsize.height);
        }
        
        titleLabel.textColor = [UIColor colorWithRed:229/255. green:229/255. blue:230/255. alpha:0.5];
        
    }
    
    if ([[self.imageDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
        
        cell.backgroundColor = [UIColor colorWithRed:(52/255.0)green:(48/255.0)  blue:(48/255.0) alpha:.5];
        
        self.imageView.image = [UIImage imageNamed:[self.imageDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]]];
        
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

-(void) playSound

{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
        AudioServicesPlaySystemSound(shake_sound_male_id);
        //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }
    
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
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
