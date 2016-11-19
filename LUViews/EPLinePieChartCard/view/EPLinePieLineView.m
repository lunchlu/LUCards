//
//  EPLinePieLineView.m
//  view11-4
//
//  Created by luchanghao on 16/11/4.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import "EPLinePieLineView.h"
#import "UIView+Frame.h"

@interface EPLinePieLineView ()
@property (nonatomic, assign) CGPoint sPoint;//相对于self
@property (nonatomic, assign) CGPoint ePoint;//相对于self
@property (nonatomic, strong) UIColor *lineColor;
@end


@implementation EPLinePieLineView

-(instancetype)initWithStartPoint:(CGPoint)sPoint EndPoint:(CGPoint)ePoint LineColor:(UIColor *)lineColor{
    if ([super init]) {
        
        self.lineColor = lineColor;
        
        CGFloat width;
        CGFloat height;
        CGFloat x;
        CGFloat y;
        if (sPoint.x <= ePoint.x
            && sPoint.y >= ePoint.y)
        {
            width  = ePoint.x - sPoint.x  + 4 +4;
            height = sPoint.y - ePoint.y + 4 +4;
            x      = sPoint.x - 4;
            y      = ePoint.y - 4 ;
            
            self.sPoint = CGPointMake(4, height-4);
            self.ePoint = CGPointMake(width-4, 4);
        }
        else if(sPoint.x <= ePoint.x
                && sPoint.y <= ePoint.y)
        {
            width  = ePoint.x - sPoint.x  + 4 +4;
            height = ePoint.y - sPoint.y + 4 +4;
            x      = sPoint.x - 4;
            y      = sPoint.y - 4;
            
            self.sPoint = CGPointMake(4, 4);
            self.ePoint = CGPointMake(width-4, height-4);
        }
        else if(sPoint.x >= ePoint.x
                && sPoint.y <= ePoint.y)
        {
            width  = sPoint.x - ePoint.x  + 4 +4;
            height = ePoint.y - sPoint.y + 4 +4;
            x      = ePoint.x - 4;
            y      = sPoint.y - 4;
            
            self.sPoint = CGPointMake(width - 4, 4);
            self.ePoint = CGPointMake(4, height-4);
        }
        else if(sPoint.x >= ePoint.x
                && sPoint.y >= ePoint.y)
        {
            width  = sPoint.x - ePoint.x  + 4 + 4;
            height = sPoint.y - ePoint.y + 4 +4;
            x      = ePoint.x - 4;
            y      = ePoint.y - 4;
            
            self.sPoint = CGPointMake(width - 4, height - 4);
            self.ePoint = CGPointMake(4, 4);
        }
        
        self.frame = CGRectMake(x, y, width, height);
    }
    return  self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:(CGRectMake(_sPoint.x-1.5, _sPoint.y-1.5, 3, 3))];
    [_lineColor setFill];
    [bezier closePath];
    [bezier fill];
    [bezier moveToPoint:_sPoint];
    [bezier addLineToPoint:_ePoint];
    bezier.lineWidth = 1;
    [_lineColor setStroke];
    [bezier stroke];
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
}


@end








