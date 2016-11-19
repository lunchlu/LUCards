//
//  ShowVC.m
//  LUViews
//
//  Created by lu_ios on 16/11/18.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "ShowVC.h"

#import "EPHorizonProgressCardModel.h"
#import "EPHorizonProgressCard.h"

#import "EPLineChartCardModel.h"
#import "EPLineChartCard.h"

#import "EPFillLineCard.h"
#import "EPFillLineModel.h"

#import "EPBarChartCard.h"
#import "EPBarChartCardModel.h"

#import "EPPieChartCard.h"
#import "EPPieChartCardModel.h"

#import "EPLinePieChart.h"
#import "EPLinePieChartModel.h"

@interface ShowVC ()

@end

@implementation ShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSDictionary *dict = @{@"x":@"x"};
    
    if ([self.showType isEqualToString:@"EPHorizonProgressCard"]) {
        EPHorizonProgressCardModel *model = [EPHorizonProgressCardModel modelWithDic:dict target:self];
        EPHorizonProgressCard *card = [[EPHorizonProgressCard alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
    
    if ([self.showType isEqualToString:@"EPLineChartCard"]) {
        EPLineChartCardModel *model = [EPLineChartCardModel modelWithDic:dict target:self];
        EPLineChartCard *card = [[EPLineChartCard alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
    
    if ([self.showType isEqualToString:@"EPFillLineCard"]) {
        EPFillLineModel *model = [EPFillLineModel modelWithDic:dict target:self];
        EPFillLineCard *card = [[EPFillLineCard alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
    
    if ([self.showType isEqualToString:@"EPBarChartCard"]) {
        EPBarChartCardModel *model = [EPBarChartCardModel modelWithDic:dict target:self];
        EPBarChartCard *card = [[EPBarChartCard alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
    
    if ([self.showType isEqualToString:@"EPPieChartCard"]) {
        EPPieChartCardModel *model = [EPPieChartCardModel modelWithDic:dict target:self];
        EPPieChartCard *card = [[EPPieChartCard alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
    
    if ([self.showType isEqualToString:@"EPLinePieChartCard"]) {
        EPLinePieChartModel *model = [EPLinePieChartModel modelWithDic:dict target:self];
        EPLinePieChart *card = [[EPLinePieChart alloc] init];
        card.model = model;
        [self.view addSubview:card];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
