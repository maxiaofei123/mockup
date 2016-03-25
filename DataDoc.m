//
//  DataDoc.m
//  mockup
//
//  Created by su on 16/3/24.
//  Copyright © 2016年 su. All rights reserved.
//

#import "DataDoc.h"

@implementation DataDoc

-(id)init
{
    self  = [super init];
    if (self) {
        self.allStepArr = [NSArray arrayWithObjects:
                           @"cut open the salmon skin, then tumbled into sauces A,then massage salmon, make sauce evenly onto the salmon",
                           @"remove the salmon skin,Add 2 tbs vegetable oil into the pan",
                           
                           @"tumbled the salmon fillet into sauce A ",
                           @"covered salmon evenly with prepared sauce & massage for 1min",
                           @"stand salomn 3 minutes",
                           @"Pour vegetable oil 2soup into pan",
                           @"将3个鸡蛋打入碗内",
                           @"用叉子快速搅拌持续30秒，使蛋白和蛋黄充分融合",
                           @"将搅拌好的鸡蛋放到一边备用",
                           nil];
        self.imageDic = @{
                          @"0":@"1.jpg",
                          @"3":@"2.jpg",
                          @"5":@"3.jpg",
                          @"6":@"6.jpg",
                          @"8":@"4.jpg",
                          @"9":@"5.jpg",
                          @"11":@"3.jpg",
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

        return  self;
    }
    return nil;
    
}

@end
