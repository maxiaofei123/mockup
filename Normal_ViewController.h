//
//  Normal_ViewController.h
//  mockup
//
//  Created by susu on 16/3/15.
//  Copyright © 2016年 su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Normal_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *subtract;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

- (IBAction)backAction:(id)sender;

- (IBAction)nextAction:(id)sender;
- (IBAction)subtractAction:(id)sender;
- (IBAction)addAction:(id)sender;
@end
