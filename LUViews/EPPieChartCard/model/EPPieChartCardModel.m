//
//  EPPieChartModel.m
//  pie
//
//  Created by luchanghao on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "EPPieChartCardModel.h"
#import "cong.h"

@interface EPPieChartCardModel ()
@property (nonatomic, assign) CGFloat startAngle;
@end

@implementation EPPieChartCardModel
+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    self = [super init];
    if (self && dic && [dic isKindOfClass:[NSDictionary class]]) {
        self.cardHeight = 310.f;

        
        if (dic[@"vc"]
            &&[dic[@"vc"] isEqualToString:@"EPPODetailVC"]) {
            
            self.valueArray = [NSMutableArray arrayWithArray:@[@"1156",@"242",@"332"]];
            
            self.detailArray = [NSMutableArray arrayWithArray:@[@"有效人天",@"待补卡",@"无效",]];
            
            self.centerTitle = @"人天总数";
            
            
            self.colorArray = [NSMutableArray arrayWithArray:@[  COLOR_Random,COLOR_Random,COLOR_Random,COLOR_Random, COLOR_Random]];
            
            self.BgColor = COLOR_RGB(27, 33, 50);
            self.headBG  = COLOR_RGB(30, 50, 65);
        }
        else{
        
            self.valueArray = [NSMutableArray arrayWithArray:@[@"6",@"5",@"4",@"1",@"2"]];
            
            self.detailArray = [NSMutableArray arrayWithArray:@[@"ES3 series",@"GS9 series",@"NX7 series",@"DZ9 series",@"LX9 series",]];
            
            self.centerTitle = @"产品总数";
            
            self.colorArray = [NSMutableArray arrayWithArray:@[COLOR_Random, COLOR_Random, COLOR_Random,COLOR_Random, COLOR_Random,COLOR_Random,COLOR_Random, COLOR_Random]];
            
            self.BgColor = COLOR_RGBA(32, 32, 32, 1);
            self.headBG = COLOR_RGBA(37, 38, 41, 1);
        }
        
//    self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20",@"10",@"20",@"10",@"10",@"20"]];
        
        self.radius = 70;
        if (SCREEN_WIDTH< 375) {
            self.radius = 55;
        }
        self.lineWidth = _radius/2.2;

        _startAngle = (-90/180.f)*M_PI;
        
        [self getAngleForView];
        
    }
    return self;
}

-(void)getAngleForView{
    
    self.angleArray = [NSMutableArray new];
    self.startAngleArray = [NSMutableArray new];
    _totalValue = 0;
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        _totalValue += [_valueArray[i] floatValue];
    }
    
    //设置全部角度
    [_startAngleArray addObject:@(_startAngle)];
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        
        CGFloat angle = [self countAngle:[_valueArray[i] floatValue]];
        
        [_angleArray addObject:@(angle)];
        
        [_startAngleArray addObject:@([_startAngleArray[i] floatValue] + angle)];
    }
}

- (CGFloat)countAngle:(CGFloat)value{
    //计算百分比
    CGFloat percent = value / _totalValue;
    //需要多少度的圆弧
    CGFloat angle = M_PI * 2 * percent;
    return angle;
}




@end
