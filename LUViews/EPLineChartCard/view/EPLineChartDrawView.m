//
//  EPLineChartDrawView.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPLineChartDrawView.h"
#import "UIView+Frame.h"
#import "cong.h"

@interface EPLineChartDrawView()
@property (nonatomic, strong) CAShapeLayer *arc;
@end


@implementation EPLineChartDrawView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.arc = [CAShapeLayer layer];
    }
    return self;
}

-(void)setPointArray:(NSArray *)pointArray{
    _pointArray = pointArray;
    [self setNeedsDisplay];
    self.backgroundColor = [UIColor clearColor];
    
    for (NSValue *value in pointArray) {
        CGPoint point = [value CGPointValue];
        [self drawRingAtPoint:point];
    }
    
}

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //获得处理的上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //开始一个起始路径
    CGContextBeginPath(context);

    CGPoint point = [_pointArray[0] CGPointValue];
    CGContextMoveToPoint(context,point.x, point.y);
    [path moveToPoint:point];
    
    [COLOR_RGBA(248, 205, 58, 1) setStroke];
    [path setLineWidth:2];
    [path setLineJoinStyle:(kCGLineJoinRound)];
    for (int i = 1; i < _pointArray.count; i++) {
        CGPoint point = [_pointArray[i] CGPointValue];
        CGContextAddLineToPoint(context,point.x, point.y);
        [path addLineToPoint:point];
    }
    [path stroke];
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
}

-(void)drawRingAtPoint:(CGPoint)point{
    UIImageView *imgRing = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 8, 8))];
    imgRing.image = [UIImage imageNamed:@"EPLineChartRing"];
    imgRing.center = point;
    imgRing.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imgBG = [[UIImageView alloc] initWithFrame:imgRing.frame];
    imgBG.backgroundColor = COLOR_RGBA(41, 55, 58, 1);
    imgBG.layer.cornerRadius = imgBG.height*0.5;
    imgBG.contentMode = 1;
    
    [self addSubview:imgBG];
    [self addSubview:imgRing];
}


@end


































