//
//  EPPieChart.m
//  pie
//
//  Created by luchanghao on 16/10/19.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "EPLinePieChart.h"
#import "UIView+Frame.h"
#import "EPLinePieInfoView.h"
#import "EPLinePieLineView.h"
#import "cong.h"

@interface EPLinePieChart ()
//－－－－－－－－－UI
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *drawPieView;

//－－－－－－－－－－赋值数据
/** 存储value的数组 */
@property (nonatomic, strong) NSMutableArray * valueArray;
/** 存储颜色的数组 */
@property (nonatomic, strong) NSMutableArray * colorArray;
/** 存储类型的数组 */
@property (nonatomic, strong) NSMutableArray * typeArray;
/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 记录bezier线宽 */
@property (nonatomic, assign) CGFloat lineWidth;

//－－－－－－－－－－－逻辑数据
/** 存储开始角度的数组 */
@property (nonatomic, strong) NSMutableArray * startAngleArray;
/** 存储结束角度的数组 */
@property (nonatomic, strong) NSMutableArray * endAngleArray;
/** 存储每个圆弧动画开始的时间 */
@property (nonatomic, strong) NSMutableArray * startTimeArray;

/** 总数 */
@property (nonatomic, assign) CGFloat totalValue;
/** 记录每个圆弧开始的角度 */
@property (nonatomic, assign) CGFloat startAngle;
/** 记录当前path的中心点 */
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat centerPointRad;
/** 记录圆环中心 */
@property (nonatomic, assign) CGPoint pieCenter;

@end
@implementation EPLinePieChart

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

//        
        self.frame = CGRectMake(0, 50, SCREEN_WIDTH, 310);
        [self setupHeadView];
        [self setupDrawPieView];
        [self setUp];
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = COLOR_Random;

    }
    return self;
}

-(void)setupDrawPieView{
    self.drawPieView = [[UIView alloc] initWithFrame:(CGRectMake(0, _headView.bottom, SCREEN_WIDTH, self.height - _headView.height))];
    [self addSubview:_drawPieView];
    _drawPieView.backgroundColor = [UIColor whiteColor];
}

-(void)setupHeadView{
    self.headView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 40))];
    
    [self addSubview:_headView];
    self.textLabel = [[UILabel alloc] initWithFrame:(CGRectMake(15, 0, 100, _headView.height))];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.textColor = COLOR_RGB(65, 71, 98);
    _textLabel.font = [UIFont systemFontOfSize:16];
    [_headView addSubview:_textLabel];
    
    
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0.5))];
    line.backgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1];
    line.bottom = _headView.height;
    [_headView addSubview:line];
}

//初始化数据
- (void)setUp
{
    _pieCenter = CGPointMake(_drawPieView.width*0.5, _drawPieView.height* 0.5);
    _startAngleArray = [NSMutableArray new];
    _piePatternType = kPieChartPatternTypeForCirque;
    
}

//画弧线
- (EPLinePie *)pieShapeLayerWithCenter:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType{
    
    EPLinePie * pie = [EPLinePie pieWithCenter:center radius:_radius startAngle:startAngle endAngle:endAngle color:color duration:duration piePatternType:piePatternType isAnimated:NO];
    pie.lineWidth = _lineWidth;
    
    return pie;
}

-(void)setModel:(EPLinePieChartModel *)model{
    _model = model;
    _textLabel.text = _model.cardTitle;
    [self strokePath];
}

- (void)strokePath{
    
    [self setUp];
    
    self.valueArray = _model.valueArray;
    self.colorArray = _model.colorArray;
    self.typeArray  = _model.downTitleArray;
    self.totalValue = _model.totalValue;
    self.startAngleArray = _model.startAngleArray;
    
    _radius = _model.radius;
    _lineWidth = _model.lineWidth;

    for (UIView *view in self.drawPieView.subviews) {
        if ([view isKindOfClass:[EPLinePieLineView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        [self showEachPieShapeLayer:i];
    }
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        [self setupLine:i];
    }
}


- (void)showEachPieShapeLayer:(NSInteger)i{
    EPLinePie *pie = [self pieShapeLayerWithCenter:_pieCenter startAngle:[_startAngleArray[i] floatValue] endAngle:[_startAngleArray[i+1] floatValue]  color:_colorArray[i] duration:0.5 piePatternType:_piePatternType];
    
    [self.drawPieView.layer addSublayer:pie];
}



-(void)setupLine:(NSInteger)i{
    //infoview部分
    CGRect frame = [_model.infoViewFrame[i] CGRectValue];
    EPLinePieInfoView *infoView = [[EPLinePieInfoView alloc] initWithFrame:frame];
    if (SCREEN_WIDTH < 375) {
        infoView.width = 60;
    }
    CGPoint endPoint;
    self.centerPointRad = [_model.centerPointRadArray[i] floatValue];
    if (_centerPointRad >= (-90 / 180.f * M_PI)
        &&_centerPointRad <= (90/180.f *M_PI))
    {
        endPoint = CGPointMake(infoView.left, infoView.top+ infoView.height*0.6);
        infoView.LineType = EPpieDrawLineType_up_right;
    }
    else{
        endPoint = CGPointMake(infoView.left +infoView.width, infoView.top+ infoView.height*0.6);
        infoView.LineType = EPpieDrawLineType_down_left;
    }
    NSInteger count = i;
    infoView.upTitle = _valueArray[count];
    infoView.downTitle = _typeArray[count];
    infoView.lineColor = _colorArray[count];
    infoView.backgroundColor = [UIColor clearColor];//////////////////////
    [self.drawPieView addSubview:infoView];
    
    
    //折线部分
    CGPoint point = [_model.centerPointArray[i] CGPointValue];
    point.x += _pieCenter.x;
    point.y += _pieCenter.y;
    EPLinePieLineView *line = [[EPLinePieLineView alloc] initWithStartPoint:point EndPoint:endPoint LineColor:_colorArray[i]];
    [self.drawPieView addSubview:line];
    line.backgroundColor = [UIColor clearColor];
}

-(void)selectedWithButton:(UIButton*)datebtn andDate:(NSString*)date{
    
    
}



@end



