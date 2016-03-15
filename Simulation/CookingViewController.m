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
@property (nonatomic ,assign) NSInteger  timeOne;
@property (nonatomic ,assign) NSInteger  numberTime;

@property (nonatomic ,assign) BOOL flagShow;
@property (nonatomic ,assign) NSInteger flagIndex;

@property (nonatomic ,strong)AVSpeechSynthesizer * AV;

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
    
    
}

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

    [button1 setBackgroundImage:[UIImage imageNamed:@"upNormal.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"upSelcted.png"] forState:UIControlStateSelected];

    
    button2 = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-150, 120+h+h, 120, 120)];
    [button2 addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:40];
    
    
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(33,33, 54, 54);//设置shapeLayer的尺寸和位置
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 54.0f;
    self.shapeLayer.strokeColor = [UIColor colorWithRed:89/255. green:94/255. blue:100/255. alpha:0.5].CGColor;
    
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
    
    self.countTime = 0;
    self.timeOne = 0;
    self.numberTime =0;
    
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
                      @"1":@"10",
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

    [self initTableview];
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
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, Main_Screen_Width-160, 300)];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
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

        Normal_ViewController * normal = [[Normal_ViewController alloc] init];
       [self presentViewController:normal animated:YES completion:nil];
        
    //[self dismissViewControllerAnimated:YES completion:nil];
        
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

        if (self.index == self.allStepArr.count -1) {
            self.close = YES;
            
        }
        
        [self updatemyTableView];
    }
}

-(void)updateButton
{
    self.timeOne --;
   
    if (self.timeOne ==0 ) {
        
        //停止定时器 停止写入数据
        self.timerOnetime.fireDate = [NSDate distantFuture];
        self.button2.enabled = YES;
        self.button1.enabled = YES;
        
        [button2 setBackgroundImage:[UIImage imageNamed:@"downNormal.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"downSelcted.png"] forState:UIControlStateSelected];
        [button2 setTitle:@"" forState:UIControlStateNormal];
    }else
    {
        self.button2.enabled = NO;
        self.button1.enabled = NO;
        
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
        [button2 setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeOne] forState:UIControlStateNormal];
        
        
        _AV = [[AVSpeechSynthesizer alloc]init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:[NSString stringWithFormat:@"%ld",(long)self.timeOne]];  //需要转换的文本
        [_AV speakUtterance:utterance];
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
                
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
                [button2 setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateSelected];
                
            }else
            {
                self.timeOne = time;
                //启动定时器 写入数据
                self.timerOnetime.fireDate = [NSDate distantPast];
            }
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
    
    CGSize size = CGSizeMake( Main_Screen_Width-180,2000);
    CGSize labelsize = [[str substringFromIndex:2] sizeWithFont:[UIFont systemFontOfSize:40] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
//   10, 0, Main_Screen_Width-180, labelsize.height< 150?labelsize.height:150
    
    UILabel *  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Main_Screen_Width-180, 145)];
    
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont fontWithName:@"EncodeSans-Medium" size:40];
    [cell.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont fontWithName:@"EncodeSans-Regular" size:34];

    titleLabel.text = str;
    titleLabel.textColor = [UIColor colorWithRed:117/255. green:122/255. blue:129/255. alpha:1.];
//    cell.backgroundColor = cell.backgroundColor = [UIColor colorWithRed:(0.0/255.0)green:(0.0/255.0)  blue:(0.0/255.0) alpha:.5];
//    cell.backgroundColor = [UIColor grayColor];
    if (indexPath.row == self.index) {
        
        titleLabel.font = [UIFont fontWithName:@"EncodeSans-Medium" size:38];
        titleLabel.textColor = [UIColor whiteColor];
        
        if ([[self.imageDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",self.index]]) {
            self.imageView.image = [UIImage imageNamed:[self.imageDic objectForKey:[NSString stringWithFormat:@"%ld",self.index]]];
            
            cell.backgroundColor = cell.backgroundColor = [UIColor colorWithRed:(0.0/255.0)green:(0.0/255.0)  blue:(0.0/255.0) alpha:.5];
            
        }else
        {
            self.imageView.image = nil;
            cell.backgroundColor = [UIColor clearColor];
        }
    }
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
