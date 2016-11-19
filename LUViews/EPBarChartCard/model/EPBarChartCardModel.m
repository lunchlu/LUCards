//
//  EPLineChartCardModel.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPBarChartCardModel.h"
#import <UIKit/UIKit.h>

@interface EPBarChartCardModel ()

@end


@implementation EPBarChartCardModel

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    if (self = [super init])
    {
        
        self.temperatureArray = @[@"22",@"30",@"24",@"55",@"35",];
        self.moistureArray    = @[@"44",@"78",@"90",@"102",@"80",];
        self.XtitleArray = @[@"1h",@"10h",@"20h",@"30h",@"40h"];
        self.titleStr = @"设备型号:GS9 KWGDS120\n实验温度范围:-70℃~150℃\n试验湿度范围:25%~98%R.H\n最大温度变化率:15℃/min\n";
        self.colorArray = @[COLOR_RGBA(248, 205, 59, 1), COLOR_RGBA(57, 198, 199, 1)];
        
//        self.isShowPass = YES;
//        self.isPass = YES;
//        self.passStr = @"通过";
//        self.detailStr = @"高湿度测试";
    }
    
    [self makeDataForView];
    self.cardHeight = 210;
    

    
    return self;
}

- (void)makeDataForView{
    NSArray *tArray = [self setupYvalue:self.temperatureArray];
    self.YvalueForT =  tArray[0];
    self.pointHeightForT =  tArray[1];

    NSArray *mArrty = [self setupYvalue:self.moistureArray];
    self.YvalueForM =  mArrty[0];
    self.pointHeightForM =  mArrty[1];
}


//－－－－－－－－－－－－以左下角为坐标－－－－－－－－－－－－－
- (NSArray *)setupYvalue:(NSArray *)array{
    
    NSArray *_valueArray = array;
    
    CGFloat jiange = 20;
    self.YHeight = [[NSMutableArray alloc] initWithArray:@[@(0*jiange),@(1*jiange),@(2*jiange),@(3*jiange),@(4*jiange),@(5*jiange),@(6*jiange),]];

    NSArray *sortedArray = [_valueArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double obj11 = [obj1 doubleValue];
        double obj22 = [obj2 doubleValue];
        NSComparisonResult result = obj11 - obj22;
        return result;
    }];
    CGFloat max = [sortedArray.lastObject floatValue];
    CGFloat marg = (int)((max / 4) / 10 ) *10;
    
    
    CGFloat start = 0;
    
    NSMutableArray *Yvalue = [NSMutableArray new];//坐标轴的Y值；
    for (int i = 0; i<_YHeight.count; i++) {
        [Yvalue addObject:@(start +i*marg)];
    }
    
    NSMutableArray *pointHeight = [NSMutableArray new];//坐标轴的Y值；
    for (int i = 0; i<_valueArray.count; i++) {
        CGFloat y =  -( (jiange/marg)* [_valueArray[i] floatValue]) + start*(jiange/marg);
        [pointHeight addObject:@(y)];
    }
    
    
    return @[Yvalue, pointHeight];
}

@end













