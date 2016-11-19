//
//  EPActivityLineModel.m
//  E-Platform
//
//  Created by luchanghao on 16/10/21.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPFillLineModel.h"

@implementation EPFillLineModel

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    self = [super init];
    if (self
        && dic
        && [dic isKindOfClass:[NSDictionary class]])
    {
        self.headTitle = @"Project Activity";
        self.headDetail = @"Unit:USD";
        self.fromDataTitle = @"30/12/2015";
        self.toDataTitle = @"20/02/2016";
        self.XtitleArray = @[@"Jan20",@"Jan21",@"Jan22",@"Jan23",@"Jan24",@"Jan25",@"Jan26"];
        self.numCount = @"133.50";
        self.drawPointValue = @[@(123), @(127), @(139), @(141), @(133), @(141), @(139), @(145), @(144)];
        
        self.picSize = CGSizeMake(600, 0);
        self.maxY = 150;
        self.minY = 110;
        
    }
    
    
    return self;
}

@end
