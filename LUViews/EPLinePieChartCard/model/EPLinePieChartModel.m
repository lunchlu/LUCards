//
//  EPPieChartModel.m
//  pie
//
//  Created by luchanghao on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "EPLinePieChartModel.h"
#import "cong.h"

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};



@interface EPLinePieChartModel ()
@property (nonatomic, assign) CGFloat startAngle;
@end

@implementation EPLinePieChartModel
+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}
- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    self = [super init];
    if (self && dic && [dic isKindOfClass:[NSDictionary class]]) {
        self.cardTitle = @"LinePieChart";
        self.cardHeight = 310.f;
        
//   self.valueArray = [NSMutableArray arrayWithArray:@[@"1",@"1",@"1",@"1", @"1", @"1",@"1",@"191"]];
        
//   self.valueArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4", @"5", @"6",@"191",@"191"]];
        
//   self.valueArray = [NSMutableArray arrayWithArray:@[@"1",@"1",@"1",@"1", @"1", @"100",@"100",@"191"]];
        
//    self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20",@"10",@"20",@"10",@"10",@"20"]];

        
        
  self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20",@"10",@"20",@"10"]];

        
//  self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20",@"10",@"20"]];

//  self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20",@"10"]];

//  self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20",@"20"]];
        
//  self.valueArray = [NSMutableArray arrayWithArray:@[@"10",@"20"]];
        
//  self.valueArray = [NSMutableArray arrayWithArray:@[@"10"]];



        
        //self.colorArray = [NSMutableArray arrayWithArray:@[COLOR_HEX(0x12F41B), COLOR_HEX(0xC2ADE2), COLOR_HEX(0x67E246),COLOR_HEX(0xABF41B), COLOR_HEX(0xA74fA0),COLOR_HEX(0x39DAD7),COLOR_HEX(0xCCF41B), COLOR_HEX(0xA7ADE2)]];
        
        self.colorArray = [NSMutableArray arrayWithArray:@[COLOR_Random, COLOR_Random, COLOR_Random,COLOR_Random, COLOR_Random,COLOR_Random,COLOR_Random, COLOR_Random]];
        
        
        self.downTitleArray = [NSMutableArray arrayWithArray:@[@"异常>30min",@"异常<30min",@"加班>2h",@"忘记打卡",@"加班<2h", @"加班",@"加班<2h", @"加班"]];
        self.radius = 60;
        if (SCREEN_WIDTH< 375) {
            self.radius = 50;
        }
        self.lineWidth = _radius/1.6;
        self.cardTitle = @"刷卡统计";
        self.dateTitle = @"2016/10/20";
        
        _startAngle = (-90/180.f)*M_PI;
        
        
        [self setForFrame];
        
        
        [self creatTestDatas];
        
    }
    return self;
}

-(void)setForFrame{
    //处理value数据
    [self setDataForValue];

    //设置默认八种frame
    self.infoViewFrame = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    for (NSInteger i = 0; i < 8; i++) {
        
        CGFloat width = 60;
        CGFloat height = 50;
        CGRect frame = CGRectMake(0, 0, width, height);
        
        if (i<4) {
            frame.origin.x = 20;
            frame.origin.y = (3-i%4)* 60 + 5;

        }
        else{
            frame.origin.x = SCREEN_WIDTH - 80;
            frame.origin.y = (i%4) * 60 + 5;
        }
        
        if (i==0 || i== 3) {
            frame.origin.x +=35;
        }
        if (i==4 || i== 7) {
            frame.origin.x -= 35;
        }
        
        if (i== 3) {
            frame.origin.x +=10;
            frame.origin.y += 5;
        }
        if (i==4) {
            frame.origin.x -= 10;
            frame.origin.y += 5;
        }
        
        if (i== 1 || i==2) {
            frame.origin.x +=10;
        }
        if (i==5 || i== 6) {
            frame.origin.x -= 10;
        }
        
        
        
        NSValue *frameValue = [NSValue valueWithCGRect:frame];
        _infoViewFrame[i] = frameValue;
    }

    NSMutableArray *aaArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    //确定left对应frame位置
    int count1 = 3;
    int jiange1 = (int)(4- _leftArray.count);
    for (int i = (int)_leftArray.count-1; i>-1; i--) {
        CGFloat value =  [_leftArray[i] floatValue];
        if (value/_totalValue >= 0.25
            && jiange1 >0) {
            jiange1 -= 1;
            aaArray[i] = @(count1 -1);
            count1 -=1;
        }
        else{
            aaArray[i] = @(count1);
        }
        count1 -=1;
        
        if (i==0
            && jiange1 >0
            && _leftArray.count >2
            ) {
            jiange1 -= 1;
            aaArray[i] = @(0);
        }
    }
    
    //确定right对应frame位置
    int count2 = 4;
    int jainge2 =(int)( 4 - _rightArray.count);
    for (int i = (int)_leftArray.count; i<_valueArray.count; i++) {
        CGFloat value =  [_valueArray[i] floatValue];
        if (value/_totalValue >= 0.25
            && jainge2 > 0) {
            jainge2 -=1;
            aaArray[i] = @(count2 +1);
            count2 +=1;
        }
        else{
            aaArray[i] = @(count2);
        }
        count2 +=1;
        if (i == _valueArray.count-1
            && jainge2 > 0
            && _rightArray.count>2) {
            jainge2 -=1;
            aaArray[i] = @(7);
            count2 +=1;
        }
    }
    
    //重新分配对应的frame
    NSMutableArray *bbArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    for (int i = 0; i<_valueArray.count; i++) {
        bbArray[i] = _infoViewFrame[  [aaArray[i] intValue] ];
    }
    _infoViewFrame = bbArray;
    

    //设置连线点位置
    [self getBestPointForLine];
}

-(CGRect)frameWithRad:(CGFloat)rad{
    
    CGFloat r = _radius *1.8;
    CGFloat cenX = r * cos(rad);
    CGFloat cenY = - r * sin(rad);
    
    CGFloat x;
    CGFloat y;
    if (rad>=(-90 / 180.f * M_PI)
        && rad < (90 / 180.f * M_PI)
        )
    {
        x = cenX - 10;
        y = -( cenY + 25);
    }
    else{
        x = cenX - 60;
        y = -( cenY + 25);
    }
    
    CGFloat width = 75;
    CGFloat height = 50;
    
    return CGRectMake(x, y, width, height);
}

-(void)setDataForValue{
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        _totalValue += [_valueArray[i] floatValue];
    }
    
    NSArray *sortedArray = [_valueArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double obj11 = [obj1 doubleValue];
        double obj22 = [obj2 doubleValue];
        NSComparisonResult result = obj11 - obj22;
        return result;
    }];
    //从大到小
    _valueArray = [NSMutableArray arrayWithArray:sortedArray];
    //拆分数组
    self.leftArray = [NSMutableArray new];
    self.rightArray  = [NSMutableArray new];
    for (int i = 0; i<_valueArray.count; i++) {
        if (i%2) {
            [_leftArray addObject:_valueArray[i]];
        }
        else{
            [_rightArray addObject:_valueArray[i]];
        }
    }
    _leftArray = [NSMutableArray arrayWithArray :[[_leftArray reverseObjectEnumerator] allObjects]];
    _valueArray = [NSMutableArray arrayWithArray:_leftArray];
    [_valueArray addObjectsFromArray:_rightArray];
   
}

-(void)getBestPointForLine{
    
    self.angleArray = [NSMutableArray new];
    self.centerPointRadArray = [NSMutableArray new];
    self.centerPointArray = [NSMutableArray new];
    self.startAngleArray = [NSMutableArray new];
    
    //设置全部角度
    [_startAngleArray addObject:@(_startAngle)];
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        
        CGFloat angle = [self countAngle:[_valueArray[i] floatValue]];
        
        [_angleArray addObject:@(angle)];
        
        [_startAngleArray addObject:@([_startAngleArray[i] floatValue] + angle)];
    }
    int count = (int)_startAngleArray.count;
    int halfCount;
    if (count%2) {
        halfCount = (count+ 1)*0.5;
    }
    else{
        halfCount = count *0.5;
    }
    CGFloat aa = [_startAngleArray[halfCount-1] floatValue];
    CGFloat cc = -90/180.0 * M_PI;
    CGFloat bb = aa - cc;
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i< _startAngleArray.count; i++) {
        NSNumber *value = _startAngleArray[i];
        value = @([value floatValue]-bb);
        [array addObject:value];
    }
    _startAngleArray = array;
    
    
    //找最佳连线找点
    for (int i = 0; i<_valueArray.count; i++) {
        //中点
        NSArray *array1 = [self getBezierPathCenterPointWithStartAngle:[_startAngleArray[i] floatValue] endAngle:[_startAngleArray[i+1] floatValue]];
        CGPoint middlePoint = [array1[0] CGPointValue];
        CGFloat middleRad = [array1[1] floatValue];
        //up点
        NSArray *array2 = [self getBezierPathCenterPointWithStartAngle:[_startAngleArray[i] floatValue] endAngle:middleRad];
        CGPoint upPoint = [array2[0] CGPointValue];
        //down点
        NSArray *array3 = [self getBezierPathCenterPointWithStartAngle:middleRad endAngle:[_startAngleArray[i+1] floatValue]];
        CGPoint downPoint = [array3[0] CGPointValue];
        
        CGRect infoFrame = [_infoViewFrame[i] CGRectValue];
        CGPoint linkpoint;
        if (_valueArray.count%2) {
            if (i<(_valueArray.count-1) *0.5) {
                linkpoint = CGPointMake(infoFrame.origin.x+infoFrame.size.width, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
            else{
                linkpoint = CGPointMake(infoFrame.origin.x, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
        }
        else {
            if (i<(_valueArray.count) *0.5) {
                linkpoint = CGPointMake(infoFrame.origin.x+infoFrame.size.width, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
            else{
                linkpoint = CGPointMake(infoFrame.origin.x, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
        }
   
        linkpoint.x -= SCREEN_WIDTH*0.5;
        linkpoint.y -= (310-40) * 0.5;
        double linkTomid =   distanceBetweenPoints(linkpoint, middlePoint);
        double linkToup =   distanceBetweenPoints(linkpoint, upPoint);
        double linkTodown =   distanceBetweenPoints(linkpoint, downPoint);
        CGFloat gg = 20;
        double pointDistance =  MIN( MIN(fabs(linkTomid-gg) , fabs(linkToup-gg) ) , fabs(linkTodown-gg) );
        
        if (pointDistance == fabs(linkToup-gg) ) {
            [self.centerPointRadArray addObject:array2[1]];
            [self.centerPointArray addObject:array2[0]];
        }
        if (pointDistance == fabs(linkTomid-gg) ) {
            [self.centerPointRadArray addObject:array1[1]];
            [self.centerPointArray addObject:array1[0]];
        }
        if (pointDistance == fabs(linkTodown-gg) ) {
            [self.centerPointRadArray addObject:array3[1]];
            [self.centerPointArray addObject:array3[0]];
        }
    }

    //只有一个数据的特殊情况
    if (_valueArray.count == 1) {
        NSArray *array = [self getBezierPathCenterPointWithStartAngle:-90/180.0*M_PI endAngle:90/180.0*M_PI];
        self.centerPointRadArray = [NSMutableArray arrayWithObject:array[1]] ;
        self.centerPointArray = [NSMutableArray arrayWithObject:array[0]] ;
    }
}

- (CGFloat)countAngle:(CGFloat)value{
    //计算百分比
    CGFloat percent = value / _totalValue;
    //需要多少度的圆弧
    CGFloat angle = M_PI * 2 * percent;
    return angle;
}
//计算中点值工具
- (NSArray *)getBezierPathCenterPointWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    //一半角度(弧度)
    CGFloat halfAngle = (endAngle - startAngle) / 2;
    //中心角度(弧度)
    CGFloat centerAngle = halfAngle + startAngle;
    //中心角度(角度)
    CGFloat realAngle = (centerAngle / M_PI * 180.f);
    
    CGFloat center_xPos = cos(realAngle / 180.f * M_PI) * (_radius+_lineWidth*0.5 +5) ;
    CGFloat center_yPos = sin(realAngle / 180.f * M_PI) * (_radius+_lineWidth*0.5 +5) ;
    
    CGPoint centerPoint = CGPointMake(center_xPos, center_yPos);
    
    NSValue *centerPointValue = [NSValue valueWithCGPoint:centerPoint];
    
    return  @[ centerPointValue ,@(centerAngle)];
}

- (void)creatTestDatas
{
    self.cardHeight = 310.f;

}



@end
