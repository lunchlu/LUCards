//
//  EPActivityLineView.m
//  E-Platform
//
//  Created by luchanghao on 16/10/21.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPFillLineCard.h"
#import "EPCardSelectView.h"
#import "UIView+Frame.h"

@interface EPFillLineCard ()<EPCardSelectViewDelegate>
@property (nonatomic, strong) UIView *headview;
@property (nonatomic, strong) UILabel *headTitleLabel;
@property (nonatomic, strong) UILabel *headDetaillabel;

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) EPCardSelectView *monthBtn;
@property (nonatomic, strong) EPCardSelectView *rangeBtn;
@property (nonatomic, strong) UIButton *fromDataBtn;
@property (nonatomic, strong) UIButton *toDataBtn;

@property (nonatomic, strong) UIView *picView;
@property (nonatomic, strong) UIView *picCoordinateView;
@property (nonatomic, strong) UIView *xtitleView;
@property (nonatomic, strong) UIScrollView *picScrollView;
@property (nonatomic, strong) EPDrawLineView *drawLineView;
@property (nonatomic, strong) UIView *drawlineNumCover;

@property (nonatomic, strong) UIView *numView;
@property (nonatomic, strong) UIImageView *numBGview;
@property (nonatomic, strong) UILabel *numCountLabel;



@property (nonatomic, assign) double maxY;
@property (nonatomic, assign) double minY;


@end

@implementation EPFillLineCard
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupHeadView];
        [self setupDateView];
        [self setupPicView];
        
        [self setupPicScrollView];
        [self setupDrawLineView];
        [self setupXtitleView];
        
        [self setupNumView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, _picView.bottom);
        
        //self.epview = [[EPProjeActivityView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width *0.67)];
    }
    return  self;
}



#pragma mark - 初始化UI
-(void)setupHeadView{
    
    self.headview = [[UIView alloc] initWithFrame:(CGRectMake(0, 20, SCREEN_WIDTH, 30))];
    [self addSubview:self.headview];
    
    self.headTitleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(20, 0, SCREEN_WIDTH*0.5- 20, _headview.height))];
    [self.headview addSubview:_headTitleLabel];
    _headTitleLabel.font = [UIFont systemFontOfSize:16];
    _headTitleLabel.textAlignment = NSTextAlignmentLeft;
    _headTitleLabel.textColor = [UIColor colorWithRed:65/255.0 green:75/255.0 blue:105/255.0 alpha:1];
    
    self.headDetaillabel = [[UILabel alloc] initWithFrame:_headTitleLabel.frame];
    [self.headview addSubview:_headDetaillabel];
    _headDetaillabel.right = SCREEN_WIDTH-20;
    _headDetaillabel.font = [UIFont systemFontOfSize:13];
    _headDetaillabel.textAlignment = NSTextAlignmentRight;
    _headDetaillabel.textColor = [UIColor grayColor];
    
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(20, 0, SCREEN_WIDTH - 20, 0.8))];
    line.bottom = 30;
    [self.headview addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
}

-(void)setupDateView{
    self.dateView = [[UIView alloc] initWithFrame:(CGRectMake(0, _headview.bottom+10, SCREEN_WIDTH, 30))];
    [self addSubview:_dateView];
 
    ///////////////////////////看这里
    self.monthBtn = [[EPCardSelectView alloc] initWithFrame:(CGRectMake(20, 10, 75, 22))title:@"Month" titleSize:12];
    _monthBtn.titleColor = [UIColor grayColor];
//    _monthBtn.titleBackGroundColor = COLOR_Random;//可以设置
    _monthBtn.dataArray = [NSMutableArray arrayWithArray:@[@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",]];
    _monthBtn.delegate = self;
    [self.dateView addSubview:_monthBtn];
    ////////////////////////////
    
    
    self.rangeBtn = [[EPCardSelectView alloc] initWithFrame:_monthBtn.frame title:@"Range" titleSize:12];
    _rangeBtn.left = _monthBtn.right + 8;
    _rangeBtn.titleColor = [UIColor grayColor];
    _rangeBtn.dataArray = [NSMutableArray arrayWithArray:@[@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",@"January",@"February",@"March",@"April",]];
    _rangeBtn.delegate = self;
    [self.dateView addSubview:_rangeBtn];
    
    
    
    self.toDataBtn = [[UIButton alloc] initWithFrame:_monthBtn.frame];
    //    _toDataBtn.backgroundColor = [UIColor redColor];
    [self.dateView addSubview:_toDataBtn];
    _toDataBtn.width += 10;
    _toDataBtn.right = SCREEN_WIDTH - 10;
    [_toDataBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _toDataBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_toDataBtn setImage:[UIImage imageNamed:@"EPActivityLineBlueArrow"] forState:(UIControlStateNormal)];
    _toDataBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _toDataBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 65, 0.0, 0.0);
    _toDataBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -35, 0.0, 0.0);
    
    UILabel *to = [[UILabel alloc] initWithFrame:_monthBtn.frame];
    to.textAlignment = NSTextAlignmentCenter;
    to.width = 20;
    to.right = _toDataBtn.left ;
    to.text = @"to";
    to.font = [UIFont systemFontOfSize:12];
    to.textColor = [UIColor colorWithRed:170/255.0 green:180/255.0 blue:200/255.0 alpha:1];
    [self.dateView addSubview:to];

    self.fromDataBtn = [[UIButton alloc] initWithFrame:_monthBtn.frame];
    //    _fromDataBtn.backgroundColor = [UIColor redColor];
    [self.dateView addSubview:_fromDataBtn];
    _fromDataBtn.width +=10;
    _fromDataBtn.right = to.left;
    [_fromDataBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _fromDataBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_fromDataBtn setImage:[UIImage imageNamed:@"EPActivityLineBlueArrow"] forState:(UIControlStateNormal)];
    _fromDataBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _fromDataBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 65, 0.0, 0.0);
    _fromDataBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -35, 0.0, 0.0);

}

-(void)setupPicView{
    
//    self.maxY = 150;
//    self.minY = 110;
    
    self.picView = [[UIView alloc] initWithFrame:(CGRectMake(0, _dateView.bottom +10, SCREEN_WIDTH, 0.43*SCREEN_WIDTH))];
    [self addSubview:_picView];
    //    _picView.backgroundColor = [UIColor redColor];
    
    self.picCoordinateView = [[UIView alloc] initWithFrame:(CGRectMake(0, 20, SCREEN_WIDTH, 5*16))];
    [self.picView addSubview:_picCoordinateView];
    //    self.picCoordinateView.backgroundColor = [UIColor grayColor];
    
    EPProjeActivityLineCell *line1 = [[EPProjeActivityLineCell alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 16))];
    [self.picCoordinateView addSubview:line1];
//    line1.title = [NSString stringWithFormat:@"%.f",_maxY];
//    line1.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.1];
    
    EPProjeActivityLineCell *line2 = [[EPProjeActivityLineCell alloc] initWithFrame:line1.frame];
    line2.top = line1.bottom;
    [self.picCoordinateView addSubview:line2];
//    line2.title = @"140";
    //line2.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.2];
    
    EPProjeActivityLineCell *line3 = [[EPProjeActivityLineCell alloc] initWithFrame:line2.frame];
    line3.top = line2.bottom;
    [self.picCoordinateView addSubview:line3];
//    line3.title = @"130";
    //line3.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.3];
    
    EPProjeActivityLineCell *line4 = [[EPProjeActivityLineCell alloc] initWithFrame:line3.frame];
    line4.top = line3.bottom;
    [self.picCoordinateView addSubview:line4];
//    line4.title = @"120";
//    line4.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.2];
    
    EPProjeActivityLineCell *line5 = [[EPProjeActivityLineCell alloc] initWithFrame:line4.frame];
    line5.top = line4.bottom;
    [self.picCoordinateView addSubview:line5];
//    line5.title = [NSString stringWithFormat:@"%.f",_minY];
//    line5.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.1];
    
    
}



-(void)setupPicScrollView{
    self.picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH +10, _picCoordinateView.top, SCREEN_WIDTH- (0.1*SCREEN_WIDTH +10) - 20 , _picCoordinateView.height + 10 +30 +20)];
    _picScrollView.bounces = NO;
    _picScrollView.top -= 20;
    _picScrollView.showsHorizontalScrollIndicator = NO;
    _picScrollView.showsVerticalScrollIndicator = NO;
    [self. picView addSubview:_picScrollView];
//    [_picScrollView setContentOffset:(CGPointMake(25, 0))];

    self.height = _picScrollView.bottom;
    
    
    EPProjeActivityLineCell *line1 = [[EPProjeActivityLineCell alloc] initWithFrame:(CGRectMake(-0.1*SCREEN_WIDTH-20, 20, 1000, 16))];
    [self.picScrollView addSubview:line1];
    //    line1.title = [NSString stringWithFormat:@"%.f",_maxY];
    line1.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.2];
    
    EPProjeActivityLineCell *line2 = [[EPProjeActivityLineCell alloc] initWithFrame:line1.frame];
    line2.top = line1.bottom;
    [self.picScrollView addSubview:line2];
    //    line2.title = @"140";
    line2.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.3];
    
    EPProjeActivityLineCell *line3 = [[EPProjeActivityLineCell alloc] initWithFrame:line2.frame];
    line3.top = line2.bottom;
    [self.picScrollView addSubview:line3];
    //    line3.title = @"130";
    line3.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.4];
    
    EPProjeActivityLineCell *line4 = [[EPProjeActivityLineCell alloc] initWithFrame:line3.frame];
    line4.top = line3.bottom;
    [self.picScrollView addSubview:line4];
    //    line4.title = @"120";
    line4.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.3];
    
    EPProjeActivityLineCell *line5 = [[EPProjeActivityLineCell alloc] initWithFrame:line4.frame];
    line5.top = line4.bottom;
    [self.picScrollView addSubview:line5];
    //    line5.title = [NSString stringWithFormat:@"%.f",_minY];
    line5.lineColor = [UIColor colorWithRed:66/255.0 green:188/255.0 blue:236/255.0 alpha:0.2];
}

-(void)setupDrawLineView{
    
    self.drawLineView = [[EPDrawLineView alloc] initWithFrame:(CGRectMake(0, 22, SCREEN_WIDTH- (0.1*SCREEN_WIDTH +10) - 20 , 30))];
    _drawLineView.height = _picCoordinateView.height;
    //    [self.picScrollView insertSubview:_drawLineView belowSubview:_picCoordinateView];
    [self.picScrollView addSubview:_drawLineView];
    
    
    
    self.drawlineNumCover = [[UIView alloc] initWithFrame:_drawLineView.frame];
    [self.picScrollView addSubview:_drawlineNumCover];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawLineViewTap:)];
    [self.drawlineNumCover addGestureRecognizer:tap];
    
}

-(void)setupXtitleView{
    self.xtitleView = [[UIView alloc] initWithFrame:(CGRectMake(0, _drawLineView.bottom +10, SCREEN_WIDTH- (0.1*SCREEN_WIDTH +10) - 20 , 30))];
    [self.picScrollView addSubview:_xtitleView];
    _xtitleView.left = _drawLineView.left;

}

-(void)setupNumView{
    self.numView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 45, 30))];
    [self.drawlineNumCover addSubview:_numView];
    _numView.hidden = YES;
    
    self.numBGview = [[UIImageView alloc] initWithFrame:_numView.bounds];
    _numBGview.image = [UIImage imageNamed:@"EPActivityLineNumBG"];
    _numBGview.contentMode = UIViewContentModeScaleAspectFit;
    [self.numView addSubview:_numBGview];
    
    self.numCountLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, _numBGview.width, 22))];
    _numCountLabel.font = [UIFont systemFontOfSize:10];
    _numCountLabel.textColor = [UIColor whiteColor];
    [_numBGview addSubview: _numCountLabel];
    _numCountLabel.textAlignment = NSTextAlignmentCenter;

}

-(void)drawLineViewTap:(UITapGestureRecognizer *)tapGesture{
    CGPoint drawPoint = [tapGesture locationInView:self.drawlineNumCover];
    
    
    long count = _drawPointValue.count -1;
    CGFloat width = _drawLineView.width/ count;
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < _drawPointValue.count; i++) {
        
        CGFloat height =  (_maxY - [_drawPointValue[i] doubleValue] )  / (_maxY - _minY) * _drawLineView.height;
        CGPoint point = CGPointMake(i*width, height);
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    
    
    for (int i = 0; i<points.count; i++) {
        CGPoint rightPoint = [points[i] CGPointValue];
        if (rightPoint.x  > drawPoint.x) {
            
            CGPoint leftPoint = [points[i-1] CGPointValue];
            if ((rightPoint.x - drawPoint.x) > (drawPoint.x - leftPoint.x) ) {
                _numView.left = leftPoint.x - _numView.width*0.5 +2;
                _numView.top  = leftPoint.y - _numView.height + 3;
                self.numCount = [NSString stringWithFormat:@"%.0f",[_drawPointValue[i-1] floatValue]];
                if ((i-1) == 0) {
                    _numView.left = 0;
                }
                
            }
            else{
                _numView.left = rightPoint.x - _numView.width*0.5 +2;
                _numView.top  = rightPoint.y - _numView.height + 3;
                self.numCount = [NSString stringWithFormat:@"%.0f",[_drawPointValue[i] floatValue]];
                if ((i) == points.count - 1) {
                    _numView.right = _drawLineView.width;
                }
            }
            _numView.hidden = NO;
            
            break;
        }
        
    }

}



#pragma mark - get/set
-(void)setModel:(EPFillLineModel *)model{
    _model = model;
    
    self.picScrollView.contentSize = CGSizeMake(model.picSize.width, _picScrollView.height);
    self.drawLineView.width = model.picSize.width;
    self.drawlineNumCover.width = _drawLineView.width;
    self.xtitleView.width = _drawLineView.width;

    
    self.maxY = model.maxY;
    self.minY = model.minY;
    for (int i = 0; i<5; i++) {
        UIView *view = _picCoordinateView.subviews[i];
        if ([view isKindOfClass:[EPProjeActivityLineCell class]]) {
            [(EPProjeActivityLineCell *)view setTitle:[NSString stringWithFormat:@"%.f",_maxY-(i*(_maxY - _minY)/4)]];
        }
    }
    
    
    self.headTitle  = model.headTitle;
    self.headDetail = model.headDetail;
    self.fromDataTitle  = model.fromDataTitle;
    self.toDataTitle    = model.toDataTitle;
    self.numCount       = model.numCount;
    self.XtitleArray    = model.XtitleArray;
    self.drawPointValue = model.drawPointValue;

}

-(void)setDrawPointValue:(NSArray *)drawPointValue{
    _drawPointValue = drawPointValue;
    
   
    long count = _drawPointValue.count -1;
    CGFloat width = _drawLineView.width/ count;
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < _drawPointValue.count; i++) {
        
        CGFloat height =  (_maxY - [_drawPointValue[i] doubleValue] )  / (_maxY - _minY) * _drawLineView.height;
        CGPoint point = CGPointMake(i*width, height);
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    _drawLineView.pointArray = points;

}

-(void)setXtitleArray:(NSArray *)XtitleArray{
    _XtitleArray = XtitleArray;
    for (UIView *label in _xtitleView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            [label removeFromSuperview];
        }
    }
    long count = _XtitleArray.count;
    CGFloat width = _drawLineView.width/ count;
    for (int i = 0 ; i < count; i++ ) {
        UILabel *xlabel = [[UILabel alloc] initWithFrame:(CGRectMake(i*width, 0, width, 30))];
        xlabel.text = _XtitleArray[i];
        xlabel.textAlignment = NSTextAlignmentCenter;
        xlabel.font = [UIFont systemFontOfSize:10];
        xlabel.textColor = [UIColor colorWithRed:84/255.0 green:106/255.0 blue:121/255.0 alpha:1];
        [_xtitleView addSubview:xlabel];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, _xtitleView.width, 0.5))];
    line.tag = 10;
    for (UIView *view in _xtitleView.subviews) {
        if (view.tag == 10) {
            [view removeFromSuperview];
        }
    }
    [_xtitleView addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    
}

-(void)setNumCount:(NSString *)numCount{
    _numCount = numCount;
    _numCountLabel.text = _numCount;
}

-(void)setHeadTitle:(NSString *)headTitle{
    _headTitle = headTitle;
    _headTitleLabel.text = _headTitle;
}

-(void)setHeadDetail:(NSString *)headDetail{
    _headDetail = headDetail;
    _headDetaillabel.text = _headDetail;
}

-(void)setFromDataTitle:(NSString *)fromDataTitle{
    _fromDataTitle = fromDataTitle;
    [_fromDataBtn setTitle:fromDataTitle forState:(UIControlStateNormal)];
}

-(void)setToDataTitle:(NSString *)toDataTitle{
    _toDataTitle = toDataTitle;
    [_toDataBtn setTitle:toDataTitle forState:(UIControlStateNormal)];
}


#pragma delegate
-(CGSize)sizeForSelectView:(EPCardSelectView *)SelectView{
    return self.frame.size;
}

-(void)EPCardSelectView:(EPCardSelectView *)SelectView didSelectedWith:(NSString *)string{
    
}
@end






@interface EPProjeActivityLineCell()
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) CALayer *line;
@end

@implementation EPProjeActivityLineCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.titlelabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 0.1*SCREEN_WIDTH, 16))];
        self.titlelabel.textAlignment = NSTextAlignmentRight;
        self.titlelabel.font = [UIFont systemFontOfSize:11];
        self.titlelabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        //        self.titlelabel.backgroundColor = [UIColor redColor];
        [self addSubview:_titlelabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titlelabel.text = title;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //获得处理的上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //开始一个起始路径
    CGContextBeginPath(context);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1);
    //设置线条的颜色
    
    
    if (_lineColor) {
        CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    }
    else{
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    }

    //lengths说明虚线如何交替绘制,lengths的值{4，4}表示先绘制4个点，再跳过4个点，如此反复
    CGFloat lengths[] = {2,1};
    //画虚线
    CGContextSetLineDash(context, 0, lengths,2);
    //设置开始点的位置
    CGContextMoveToPoint(context, _titlelabel.width +10, self.frame.size.height/2);
    //设置终点的位置
    CGContextAddLineToPoint(context,self.frame.size.width - 20 ,self.frame.size.height/2);
    //开始绘制虚线
    CGContextStrokePath(context);
    //封闭当前线路
    CGContextClosePath(context);
    
}
@end





@interface EPDrawLineView()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *arc;
@end

@implementation EPDrawLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.arc = [CAShapeLayer layer];
        _gradientLayer       = [CAGradientLayer layer];
        [self.layer addSublayer:_gradientLayer];
    }
    return self;
}

-(void)setPointArray:(NSArray *)pointArray{
    _pointArray = pointArray;
    [self setNeedsDisplay];
    self.backgroundColor = [UIColor clearColor];
}

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //获得处理的上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //开始一个起始路径
    CGContextBeginPath(context);
    //设置线条粗细宽度
    //    CGContextSetLineWidth(context, 3);
    //设置线条的颜色
    //CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:54/255.0 green:184/255.0 blue:235/255.0 alpha:0.8].CGColor);
    //CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //设置开始点的位置
    CGPoint point = [_pointArray[0] CGPointValue];
    CGContextMoveToPoint(context,point.x, point.y);
    [path moveToPoint:point];
    //设置终点的位置
    
    [[UIColor colorWithRed:54/255.0 green:184/255.0 blue:235/255.0 alpha:1] setStroke];
    [path setLineWidth:3];
    [path setLineJoinStyle:(kCGLineJoinRound)];
    for (int i = 1; i < _pointArray.count; i++) {
        CGPoint point = [_pointArray[i] CGPointValue];
        CGContextAddLineToPoint(context,point.x, point.y);
        
        [path addLineToPoint:point];
    }
    [path stroke];
    
    [[UIColor clearColor] setStroke];
    [path addLineToPoint:(CGPointMake(self.width, self.height))];
    [path addLineToPoint:(CGPointMake(0, self.height))];
    [path addLineToPoint:point];
    [path closePath];
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    
    self.arc.path = path.CGPath;
    [self.layer setMask:_arc];
    
    
    _gradientLayer.frame = self.bounds;
    // 设置颜色渐变方向
    _gradientLayer.startPoint = CGPointMake(0.5, 0);
    _gradientLayer.endPoint   = CGPointMake(0.5, 1);
    
    // 设定颜色组
    _gradientLayer.colors = @[
                              (__bridge id)[UIColor colorWithRed:146/255.0 green:216/255.0 blue:244/255.0 alpha:0.9].CGColor,
                              (__bridge id)[UIColor colorWithRed:238/255.0 green:249/255.0 blue:253/255.0 alpha:0.6].CGColor
                              ];
    
    // 设定颜色分割点
    _gradientLayer.locations = @[@(0.5f), @(1.f)];
    
}
@end
