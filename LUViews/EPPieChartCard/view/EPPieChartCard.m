//
//  EPPieChartCard.m
//  view11-10
//
//  Created by luchanghao on 16/11/10.
//  Copyright © 2016年 luchanghao. All rights reserved.
//
#import "cong.h"
#import "EPPieChartCard.h"
#import "UIView+Frame.h"
#import "EPLinePie.h"
//#import "EPDateView.h"

#define COLOR_Random \
[UIColor clearColor]

@interface EPPieChartCard ()
{
    CGFloat  _radius;
    CGFloat _lineWidth;
    NSMutableArray *_valueArray;
    NSMutableArray *_detailArray;
    NSMutableArray *_colorArray;
    NSMutableArray *_startAngleArray;
    
    CGPoint _centerPoint;
}

@property (nonatomic, strong) UIView *headView;
//@property (nonatomic, strong) EPDateView *dataView;

@property (nonatomic, strong) UILabel *totleLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *dataListView;
@property (nonatomic, strong) UIView *containView;

//data

@end


@implementation EPPieChartCard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
        [self setupHeadView];
        [self setupContainView];
        self.backgroundColor = COLOR_RGBA(32, 32, 32, 1);
    }
    return self;
}

- (void)setupHeadView{
    self.headView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 40))];
    _headView.backgroundColor = COLOR_RGBA(37, 38, 41, 1);
;
    [self addSubview:_headView];
    
//    self.dataView = [[EPDateView alloc] initWithFrame:(CGRectMake(0, 0, 140, 36))];
//    _dataView.centerX = _headView.width*0.5;
//    _dataView.centerY = _headView.height*0.5;
//    [_headView addSubview:_dataView];
//    
//    _dataView.backgroundColor = COLOR_Random;
}

- (void)setupContainView{
    self.containView = [[UIView alloc] initWithFrame:(CGRectMake(0, _headView.bottom, SCREEN_WIDTH, self.height- _headView.height))];
    _containView.backgroundColor = COLOR_Random;
    [self addSubview:_containView];
    
    ///////////////
    _centerPoint = CGPointMake(SCREEN_WIDTH*0.28, _containView.height*0.5);
    
    self.totleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 90, 27))];
    [_containView addSubview:_totleLab];
    _totleLab.backgroundColor = COLOR_Random;
    _totleLab.textColor = [UIColor whiteColor];
    _totleLab.font = [UIFont systemFontOfSize:30 - (SCREEN_WIDTH<375 ? 2:0)];
    _totleLab.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:_totleLab];
    _totleLab.text = @"18";
    _totleLab.center = _centerPoint;
    _totleLab.top -= _totleLab.height*0.5;
    
    
    self.titleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 90, 20))];
    [_containView addSubview:_titleLab];
    _titleLab.backgroundColor = COLOR_Random;
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = [UIFont systemFontOfSize:16 - (SCREEN_WIDTH<375 ? 2:0)];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:_titleLab];
    _titleLab.text = @"产品总数";
    _titleLab.center = _centerPoint;
    _titleLab.top += _titleLab.height*0.5;
    
}

-(void)setModel:(EPPieChartCardModel *)model{
    _model = model;
    _detailArray = model.detailArray;
    _valueArray = model.valueArray;
    _colorArray = model.colorArray;
    _radius = model.radius;
    _lineWidth = model.lineWidth;
    _startAngleArray = model.startAngleArray;
    [self setupLoop];
    [self setupDataListView];
    self.backgroundColor = model.BgColor;
    self.headView.backgroundColor = model.headBG;
    _totleLab.text = [NSString stringWithFormat:@"%.f",model.totalValue];
    _titleLab.text = model.centerTitle;
}

-(void)setupLoop{
    
    
    for (int i = 0; i<_valueArray.count; i++) {
        
        CGFloat startAngle = [_startAngleArray[i] floatValue];
        CGFloat endAngle   = [_startAngleArray[i+1] floatValue];
        
        EPLinePie *pie = [self pieShapeLayerWithCenter:_centerPoint startAngle:startAngle endAngle: endAngle color:_colorArray[i] duration:0.0 piePatternType:0];
        
        [self.containView.layer addSublayer:pie];
        
    }
    
    CGFloat insideLineWidth = 10;
    CGFloat insideRadius = _radius - _lineWidth*0.5 + insideLineWidth*0.5;

    UIColor *color = COLOR_RGBA(40, 40, 40, 0.2);
    
    EPLinePie * pie = [EPLinePie pieWithCenter:_centerPoint radius:insideRadius startAngle:0 endAngle:2*M_PI color:color duration:0 piePatternType:0 isAnimated:NO];
    pie.lineWidth = insideLineWidth;
    [self.containView.layer addSublayer:pie];
}

- (EPLinePie *)pieShapeLayerWithCenter:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color duration:(CFTimeInterval)duration piePatternType:(kPiePatternType)piePatternType{
    
    EPLinePie * pie = [EPLinePie pieWithCenter:center radius:_radius startAngle:startAngle endAngle:endAngle color:color duration:duration piePatternType:piePatternType isAnimated:NO];
    pie.lineWidth = _lineWidth;
    return pie;
}

-(void)setupDataListView{
    for (UIView *view in _containView.subviews) {
        if ([view isKindOfClass:[EPPieChartDetailView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat bucong = ((5 - (int)_valueArray.count) ) * 28 *0.5;
    
    for (int i = 0; i<_valueArray.count; i++) {
        
        CGRect frame = CGRectMake(0, 40 + i*28 +bucong, 150, 28);
        
        EPPieChartDetailView *view = [[EPPieChartDetailView alloc] initWithFrame:frame];
        view.title = _detailArray[i];
        view.detail = _valueArray[i];
        view.color  = _colorArray[i];
        
        view.right = _containView.width-3;
        
        [self.containView addSubview:view];
    }
    
}

@end







@interface EPPieChartDetailView ()
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@end

@implementation EPPieChartDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = COLOR_Random;
        _titleLab.backgroundColor = COLOR_Random;
        _detailLab.backgroundColor = COLOR_Random;
    }
    return  self;
}

-(void)setup{
    self.detailLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 110- (SCREEN_WIDTH<375 ? 10:0), self.height))];
    _detailLab.textAlignment = NSTextAlignmentRight;
    _detailLab.right = self.width - 20;
    _detailLab.textColor = COLOR_RGBA(125, 149, 160, 1);
    [self addSubview:_detailLab];
    _detailLab.font = [UIFont systemFontOfSize:14 - (SCREEN_WIDTH<375 ? 2:0)];
    
    self.titleLab  = [[UILabel alloc] initWithFrame:_detailLab.frame];
    _titleLab.font = [UIFont systemFontOfSize:15 - (SCREEN_WIDTH<375 ? 2:0)];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = COLOR_RGBA(125, 149, 160, 1);
    [self addSubview:_titleLab];
    
    self.colorView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 8, 8))];
    [self addSubview:_colorView];
    _colorView.centerY = self.height*0.5;
    _colorView.right = _titleLab.left - 5;

}


-(void)setupSubView{
    
//    CGFloat titieWidth = [_titleLab sizeToFit]
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLab.text = title;
    [self setupSubView];
}

-(void)setDetail:(NSString *)detail{
    _detail = detail;
    _detailLab.text = detail;
    [self setupSubView];

}

-(void)setColor:(UIColor *)color{
    _color = color;
    _colorView.backgroundColor = color;
}

@end






















