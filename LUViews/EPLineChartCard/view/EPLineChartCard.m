//
//  EPLineChartCard.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPLineChartCard.h"
#import "EPFillLineCard.h"
#import "UIView+Frame.h"
#import "EPLineChartDrawView.h"
#import "EPPassView.h"
#import "cong.h"

@interface EPLineChartCard ()
@property (nonatomic, strong) UIScrollView *containView;
@property (nonatomic, strong) EPLineChartDrawView *drawLineView;
@property (nonatomic, strong) UIView *xtitleView;
@property (nonatomic, strong) NSString *degressStr;

//@property (nonatomic, strong) EPPassView *passView;

@end


@implementation EPLineChartCard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 50, SCREEN_WIDTH, 310);
        
        self.pointArray = [NSMutableArray new];
        self.YHeight = [NSMutableArray new];
        self.Yvalue = [NSMutableArray new];//15%
        self.Xwidth = [NSMutableArray new];
        self.Xvalue = [NSMutableArray new];
        
        [self setupContainView];
        [self setupYvalueView];
        [self setupdrawView];
//        [self setupPassView];
        
//        self.backgroundColor = COLOR_RGBA(10, 11, 12, 1);
         self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

//-(void)setupPassView{
//    self.passView = [[EPPassView alloc] initWithFrame:(CGRectMake(0, 40, 76, 76))];
//    _passView.right = SCREEN_WIDTH- 20;
//    _passView.hidden = YES;
//    _passView.alpha = 0.8;
//    [self addSubview:_passView];
//}

-(void)setupYvalueView{
    for (int i = 0; i<5; i++) {
        UILabel * lab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 40, 20))];
        lab.centerY = _containView.bottom - i*50 - 30 -8;
//        lab.backgroundColor = COLOR_Random;
        [self addSubview:lab];
        lab.textColor = [UIColor grayColor];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:11];
        lab.tag = 1000+ i;
    }
}

-(void)setupContainView{
    self.containView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 40, SCREEN_WIDTH - 50 -15, 250)];
//    _containView.backgroundColor = COLOR_Random;
    [self addSubview:_containView];
    _containView.showsHorizontalScrollIndicator = NO;
    _containView.bounces = NO;
    
    for (int i = 0; i<5; i++) {
        UIView *Xline = [[UIView alloc] initWithFrame:(CGRectMake(0, 20 +i*50 -8, 1500, 0.5))];
        Xline.backgroundColor = COLOR_RGBA(115, 115, 115, 1);

        if (i == 4) {
            Xline = [[UIView alloc] initWithFrame:(CGRectMake(0, 20 +i*50, 1500, 0.5))];
            Xline.height +=1.5;
            Xline.top -=1.5;
            Xline.backgroundColor = COLOR_RGBA(130, 130, 130, 1);
        }
        [self.containView addSubview:Xline];
    }
    
    UIView *Yline = [[UIView alloc] initWithFrame:(CGRectMake(_containView.left-2, _containView.top, 2, _containView.height - 30))];
    Yline.backgroundColor = COLOR_RGBA(130, 130, 130, 1);
    [self addSubview:Yline];
    
}

-(void)setModel:(EPLineChartCardModel *)model{
    _model = model;
    
    self.pointArray = model.pointArray;
    self.YHeight = model.YHeight;
    self.Yvalue = model.Yvalue;//15%
    self.Xwidth = model.Xwidth;
    self.degressStr = model.degressStr;
    self.Xvalue = model.titleArray;
    
    [self setforYvalue];
    
    
    _drawLineView.width = 60 * _Xwidth.count;
    _containView.contentSize = CGSizeMake(_drawLineView.width, _drawLineView.height);
    
    NSMutableArray *newArray = [NSMutableArray new];
    for (NSValue *value in _pointArray) {
        CGPoint point = [value CGPointValue];
        point.y += _drawLineView.height;
        [newArray addObject:[NSValue valueWithCGPoint:point]];
    }
    _drawLineView.pointArray = newArray;
    
    [self setupXlabels];
    
//    if(model.isShowPass){
//        _passView.hidden = NO;
//        _passView.isPass = model.isPass;
//        _passView.passStr = model.passStr;
//        _passView.detailStr = model.detailStr;
//    }
    
}

-(void)setforYvalue{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            if (view.tag >= 1000) {
                int f = (int)view.tag-1000;
                NSString *str = [NSString stringWithFormat:@"%.f%@",[_Yvalue[f] floatValue],_degressStr];
                [(UILabel *)view setText:str];

            }
        }
    }
    
    
}

-(void)setupdrawView{
    self.drawLineView = [[EPLineChartDrawView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
//    _drawLineView.backgroundColor = COLOR_Random;
//    _drawLineView.alpha = 0.6;
    
    [self.containView addSubview:_drawLineView];
    
    
    self.xtitleView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, _containView.width, 30))];
    _xtitleView.top =_drawLineView.bottom;
    [self.containView addSubview:_xtitleView];
//    _xtitleView.backgroundColor = COLOR_Random;

}

-(void)setupXlabels{
    for (UIView *view in _xtitleView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i<_pointArray.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 30))];
        lab.centerX = [_pointArray[i] CGPointValue].x;
        [_xtitleView addSubview:lab];
        lab.text = _Xvalue[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor grayColor];
    }
}

@end























