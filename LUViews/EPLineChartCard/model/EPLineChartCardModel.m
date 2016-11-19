//
//  EPLineChartCardModel.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPLineChartCardModel.h"
#import <UIKit/UIKit.h>

@interface EPLineChartCardModel ()
@property (nonatomic, strong) NSArray  *valueArray;

@property (nonatomic, assign) CGFloat totalValue;

@end


@implementation EPLineChartCardModel

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    if (self = [super init])
    {
//        self.valueArray = @[@"0",@"18",@"7",@"23",@"73",@"60",@"60",@"32",@"47",@"24",@"13",@"14",];
        
        if (dic) {
            
            if (dic[@"isPass"]
                &&[dic[@"isPass"] isEqualToString:@"1"]) {
                self.valueArray = @[@"0",@"25",@"30",@"23",@"34",@"22",@"33",@"32",@"44",@"23",@"34",@"22",];
                
                self.isShowPass = YES;
                self.isPass = YES;
                self.passStr = @"通过";
                self.detailStr = @"高温测试";
                self.degressStr = @"º";
                
            }
            else{
                self.valueArray = @[@"0",@"3",@"2",@"3",@"14",@"3",@"2",@"7",@"4",@"13",@"4",@"2",];
                self.isShowPass = YES;
                self.isPass = NO;
                self.passStr = @"不通过";
                self.detailStr = @"压力测试";
                self.degressStr = @"%";
            }
        }
        
        self.titleArray = @[@"01:11",@"03:55",@"05:44",@"07:30",@"09:31",@"11:05",@"05:44",@"07:30",@"09:31",@"11:05",@"01:11",@"03:55"];


    }
    
    [self setupPointS];
    
    self.cardHeight = 300;
    
    
    return self;
}

//－－－－－－－－－－－－以左下角为坐标－－－－－－－－－－－－－
- (void)setupPointS{
    
    self.Yvalue = [NSMutableArray new];
    self.Xwidth = [NSMutableArray new];
    self.pointArray = [NSMutableArray new];
    
    CGFloat jiange = 50;
    self.YHeight = [[NSMutableArray alloc] initWithArray:@[@(0*jiange +6),@(1*jiange+6),@(2*jiange+6),@(3*jiange+6),@(4*jiange+6),]];
    self.drawHeight = 4 *jiange + 25;

    for (NSInteger i = 0; i < _valueArray.count; i++) {
        _totalValue += [_valueArray[i] floatValue];
    }
    NSArray *sortedArray = [_valueArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double obj11 = [obj1 doubleValue];
        double obj22 = [obj2 doubleValue];
        NSComparisonResult result = obj11 - obj22;
        return result;
    }];
    CGFloat min = [sortedArray[0] floatValue];
    CGFloat max = [sortedArray.lastObject floatValue];
    CGFloat Maxmarg =  max- min;
    CGFloat marg = (int)((Maxmarg / 2) / 5 ) *5;
    
    
    CGFloat start;
    if ((min - 5) < 5 ) {
        start = 0;
    }
    else{
        start = ((int)((min-5)/5) + 1)*5;
    }
    
    for (int i = 0; i<_YHeight.count; i++) {
        [_Yvalue addObject:@(start +i*marg)];
    }
    
    for (int i = 0; i<_valueArray.count; i++) {
        [self.Xwidth addObject:@(i*60)];
    }
    

    for (int i = 0; i<_valueArray.count; i++) {
        CGPoint point = CGPointMake(i*60+4+15, -( (jiange/marg)* [_valueArray[i] floatValue]) + start*(jiange/marg) -6);
        [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    }
    
}

@end













