//
//  ViewController.m
//  Simulation
//
//  Created by su on 16/2/25.
//  Copyright © 2016年 su. All rights reserved.
//

#import "ViewController.h"
#import "SJAvatarBrowser.h"

static CGRect oldframe;

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *II;
@property (weak, nonatomic) IBOutlet UIButton *left;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *X;

@property(nonatomic,assign) BOOL showSection;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign)NSInteger allCount;
- (IBAction)nextAction:(id)sender;

- (IBAction)leftAction:(id)sender;

- (IBAction)pause:(id)sender;
- (IBAction)choseAction:(id)sender;

@property(nonatomic,strong) NSArray * allStepArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.myTableView setTableFooterView:view];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor clearColor];
    
//    self.myTableView.contentInset = UIEdgeInsetsMake(self.myTableView.bounds.size.height * 0.5-50, 0, self.myTableView.bounds.size.height * 0.5+50, 0);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionMiddle animated:YES];

    
    self.II.layer.cornerRadius = 52.5;
    [self.II setTitle:@"continue" forState:UIControlStateSelected];
    [self.left setTitleColor:[UIColor colorWithRed:74/255. green:83/255. blue:95/255. alpha:1.] forState:UIControlStateDisabled];
    [self.next setTitleColor:[UIColor colorWithRed:74/255. green:83/255. blue:95/255. alpha:1.] forState:UIControlStateDisabled];
    self.left.layer.cornerRadius = 52.5;
    self.next.layer.cornerRadius = 52.5;
    self.X.layer.cornerRadius = 15;
    self.showSection = NO;
    self.index = 0 ;
    self.allCount = 7;

    self.allStepArr = [NSArray arrayWithObjects:@"白蘑菇切片，香菇切片",@"50g土豆丝切丝,翻入盘中",@"30g青椒切丝",@"白蘑菇切片，香菇切片", @"利用手边的食材，丰丰盛盛的一起熬煮就很好", @"白蘑菇切片，香菇切片,30g青椒切丝", @"而我今天做的这道腊八粥比较特别，现将米类都放在锅中中小火炒制，将米里的淀粉分解",nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((section ==5 || section == 2) && self.showSection && section == self.index ) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 7;
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSString * str = [self.allStepArr objectAtIndex:indexPath.section] ;
    
    CGSize size = CGSizeMake( Main_Screen_Width-180,2000);
    CGSize labelsize = [[str substringFromIndex:2] sizeWithFont:[UIFont systemFontOfSize:40] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Main_Screen_Width-180, labelsize.height>40?labelsize.height:40)];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 0;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:40];
    [cell.contentView addSubview:titleLabel];
    
    if (indexPath.row ==0) {
        
        titleLabel.text = str;
        
    }else
    {
        //图片
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 200, 150)];
        image.image = [UIImage imageNamed:@"image3.jpg"];
        [cell.contentView addSubview:image];
    }
    
    if (indexPath.section == self.index) {
        
         titleLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:75/255. green:83/255. blue:94/255. alpha:1.];
   
    }else
    {
         titleLabel.textColor = [UIColor grayColor];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeMake( Main_Screen_Width-180,2000);
    
    NSString * str = [self.allStepArr objectAtIndex:indexPath.section] ;
    
    CGSize labelsize = [[str substringFromIndex:2] sizeWithFont:[UIFont systemFontOfSize:40] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                        
    if (indexPath.row ==1) {
        return 160;
    }
    return labelsize.height > 40? labelsize.height:40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    if (indexPath.row ==1) {
        //图片
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        
        CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, 200, 150)];
        image.image = [UIImage imageNamed:@"image3.jpg"];
        

        [self showImage:image];
    }
}

- (void)updatemyTableView {

    //刷新
    [self.myTableView beginUpdates];
    
    if (self.index > 0) {
        NSIndexSet *indexSetNext=[[NSIndexSet alloc]initWithIndex:(self.index-1)];
        [self.myTableView reloadSections:indexSetNext withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (self.index < (self.allCount-1)) {
        NSIndexSet *indexSetLast=[[NSIndexSet alloc]initWithIndex:(self.index+1)];
        [self.myTableView reloadSections:indexSetLast withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:self.index];
    [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.myTableView endUpdates];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.index];
    [self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionMiddle animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(id)sender {
    self.showSection = NO;
    
    if (self.index < 6) {
        self.index ++;
    }
    if (self.index == 2|| self.index == 5) {
        self.showSection = YES;
    }
    [self updatemyTableView];
}

- (IBAction)leftAction:(id)sender {
    
    self.showSection = NO;
    
    if (self.index >0) {
        self.index --;
    }
    if (self.index == 2 || self.index == 5) {
        self.showSection = YES;
    }
    [self updatemyTableView];
}

- (IBAction)pause:(id)sender {
    
    self.II.selected = ! self.II.selected;
    self.next.enabled = !self.next.enabled;
    self.left.enabled = !self.left.enabled;
}

- (IBAction)choseAction:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出当前烹饪菜单" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"取消", nil];
    [alert show];
}


-(void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image=avatarImageView.image;
    
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:self.view];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    
    [backgroundView addSubview:imageView];
    
    [self.view addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake((Main_Screen_Width - Main_Screen_Height*image.size.width/image.size.height)/2,0,  Main_Screen_Height*image.size.width/image.size.height,Main_Screen_Height);
        
        backgroundView.alpha=1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [self.view bringSubviewToFront:self.left];
    [self.view bringSubviewToFront:self.II];
    
}

-(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=oldframe;
        backgroundView.alpha=0;
        
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
@end
