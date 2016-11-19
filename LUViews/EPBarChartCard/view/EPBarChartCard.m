//
//  EPLineChartCard.m
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPBarChartCard.h"
#import "UIView+Frame.h"
#import "EPBarChartDrawView.h"
#import "EPFillLineCard.h"
#import "EPPassView.h"


@interface EPBarChartCard ()
{
    UIColor *_colorLeft;
    UIColor *_colorRight;
    UIView  *_colorLeftIcon;
    UIView  *_colorRightIcon;
    
    NSMutableArray *_YvalueForT;
    NSMutableArray *_YvalueForM;
}
@property (nonatomic, strong) UIScrollView *containView;
@property (nonatomic, strong) EPBarChartDrawView *drawLineView;
@property (nonatomic, strong) UIView *xtitleView;
@property (nonatomic, strong) EPPassView *passView;
@property (nonatomic, strong) UILabel *detailContainView;
@end


@implementation EPBarChartCard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 50, SCREEN_WIDTH, 210);
        
        [self setup];
        [self setupHeadView];
        [self setupContainView];
        [self setupDetailContainView];
        [self setupYvalueView];
        [self setupdrawView];
        [self setupPassView];
        
//        self.backgroundColor = COLOR_RGBA(53, 70, 75, 1);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setupDetailContainView{
    self.detailContainView = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH*0.4-15, SCREEN_WIDTH*0.3))];
    _detailContainView.numberOfLines = 0;
    [self addSubview:_detailContainView];
    _detailContainView.top = 95;
    _detailContainView.right = self.width;
    _detailContainView.text = @"设备型号:GS9 KWGDS120\n实验温度范围:-70℃~150℃\n试验湿度范围:25%~98%R.H\n最大温度变化率:15℃/min\n";
    _detailContainView.font = [UIFont systemFontOfSize:10];
    _detailContainView.textColor = COLOR_RGBA(130, 134, 135, 1);

//    _detailContainView.backgroundColor = COLOR_Random;
}

- (void)setupHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:(CGRectMake(45, 0, 120, 30))];
    [self addSubview:headView];
//    headView.backgroundColor = COLOR_Random;
    
    _colorLeftIcon = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 7, 7))];
    _colorLeftIcon.centerY = headView.height*0.5;
    [headView addSubview:_colorLeftIcon];
    _colorLeftIcon.backgroundColor = COLOR_Random;
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 45, 30))];
    leftLab.left = _colorLeftIcon.right +5;
    [headView addSubview:leftLab];
//    leftLab.backgroundColor = COLOR_Random;
    leftLab.text = @"温度(℃)";
    leftLab.font = [UIFont systemFontOfSize:11];
    leftLab.textColor = COLOR_RGBA(104, 126, 136, 1);
    
    _colorRightIcon = [[UIView alloc] initWithFrame:_colorLeftIcon.frame];
    _colorRightIcon.left = leftLab.right +5;
    [headView addSubview:_colorRightIcon];
    _colorRightIcon.backgroundColor = COLOR_Random;

    
    UILabel *rightLab = [[UILabel alloc] initWithFrame:leftLab.frame];
    rightLab.left = _colorRightIcon.right +5;
    [headView addSubview:rightLab];
//    rightLab.backgroundColor = COLOR_Random;
    rightLab.text = @"湿度(%)";
    rightLab.font = [UIFont systemFontOfSize:11];
    rightLab.textColor = COLOR_RGBA(104, 126, 136, 1);

}



-(void)setup{
    self.pointHeightForT = [NSMutableArray new];
    self.pointHeightForM = [NSMutableArray new];
    self.YHeight = [NSMutableArray new];
    self.YvalueForT = [NSMutableArray new];
    self.YvalueForM = [NSMutableArray new];
    self.XtitleArray = [NSMutableArray new];
    self.titleArray = [NSMutableArray new];
}

-(void)setupPassView{
    self.passView = [[EPPassView alloc] initWithFrame:(CGRectMake(0, 15, 76, 76))];
    _passView.right = SCREEN_WIDTH- 20;
    _passView.hidden = YES;
    [self addSubview:_passView];
}

-(void)setupYvalueView{
    for (int i = 0; i<7; i++) {
        UILabel * lab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 26, 20))];
        lab.centerY = _containView.bottom - i*20 - 30;
//        lab.backgroundColor = COLOR_Random;
        [self addSubview:lab];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:12];
        lab.tag = 2000+ i;
        lab.textColor = COLOR_RGBA(114, 129, 143, 1);
        lab.text = @"100";
        
        
        UILabel * labRight = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 26, 20))];
        labRight.centerY = _containView.bottom - i*20 - 30;
        labRight.left = _containView.right+4;
        //        lab.backgroundColor = COLOR_Random;
        [self addSubview:labRight];
        labRight.textColor = [UIColor whiteColor];
        labRight.textAlignment = NSTextAlignmentLeft;
        labRight.font = [UIFont systemFontOfSize:12];
        labRight.tag = 3000+ i;
        labRight.textColor = COLOR_RGBA(114, 129, 143, 1);
        labRight.text = @"50";
        
        if (i == 0) continue;
        
        EPProjeActivityLineCell *line = [[EPProjeActivityLineCell alloc] initWithFrame:lab.frame];
        line.width = 1000;
        line.left-=100;
        line.top -= _containView.top;
        line.lineColor = COLOR_RGBA(67, 81, 94, 1);
        [_containView addSubview:line];
    }
}
//
-(void)setupContainView{
    CGFloat marg = 20;
    self.containView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 32, SCREEN_WIDTH*0.52-15, marg*6+30+10)];
//    _containView.backgroundColor = COLOR_Random;
    [self addSubview:_containView];
    _containView.showsHorizontalScrollIndicator = NO;
    _containView.bounces = NO;
    
    for (int i = 0; i<7; i++) {
        UIView *Xline = [[UIView alloc] initWithFrame:(CGRectMake(0, 10 +i*marg, 1500, 0.5))];
        Xline.backgroundColor = COLOR_RGBA(115, 115, 115, 1);

        if (i == 6) {
            Xline.backgroundColor = COLOR_RGBA(62, 76, 89, 1);
            [self.containView addSubview:Xline];

        }
    }
    
    UIView *Yline = [[UIView alloc] initWithFrame:(CGRectMake(_containView.left-0.5, _containView.top, 1, _containView.height - 30+1))];
    Yline.backgroundColor = COLOR_RGBA(67, 81, 94, 1);
    [self addSubview:Yline];
    
    UIView *YlineRight = [[UIView alloc] initWithFrame:Yline.frame];
    YlineRight.left = _containView.right+0.5;
    YlineRight.backgroundColor = COLOR_RGBA(67, 81, 94, 1);
    [self addSubview:YlineRight];

    
}

-(void)setModel:(EPBarChartCardModel *)model{
    _model = model;
    
    _colorLeftIcon.backgroundColor = model.colorArray[0];
    _colorRightIcon.backgroundColor = model.colorArray[1];
    
    _detailContainView.text = model.titleStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.titleStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6 -(SCREEN_WIDTH<414 ? 2 :0)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.titleStr length])];
    _detailContainView.attributedText = attributedString;
    
    [_detailContainView sizeToFit];
    
    
    _YvalueForM = model.YvalueForM;
    _YvalueForT = model.YvalueForT;
    
    _XtitleArray = model.XtitleArray;

    [self setforYvalue];
    
    _drawLineView.width = 35 * _XtitleArray.count + 30;
    _drawLineView.colorArray = model.colorArray;
    _drawLineView.pointHeightForM = model.pointHeightForM;
    _drawLineView.pointHeightForT = model.pointHeightForT;
    _containView.contentSize = CGSizeMake(_drawLineView.width, _drawLineView.height);

    
    [self setupXlabels];
    
    if(model.isShowPass){
        _passView.hidden = NO;
        _passView.isPass = model.isPass;
        _passView.passStr = model.passStr;
        _passView.detailStr = model.detailStr;
    }
    
}

-(void)setforYvalue{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            if (view.tag >= 3000) {
                int f = (int)view.tag-3000;
                NSString *str = [NSString stringWithFormat:@"%.f",[_YvalueForM[f] floatValue]];
                [(UILabel *)view setText:str];
                
            }
            else if (view.tag >= 2000) {
                int f = (int)view.tag-2000;
                NSString *str = [NSString stringWithFormat:@"%.f",[_YvalueForT[f] floatValue]];
                [(UILabel *)view setText:str];

            }

        }
    }
}
//
-(void)setupdrawView{
    self.drawLineView = [[EPBarChartDrawView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _containView.height - 30)];
    _drawLineView.backgroundColor = [UIColor clearColor];
//    _drawLineView.alpha = 0.6;
    [self.containView addSubview:_drawLineView];
   
    self.xtitleView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, _containView.width, 25))];
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
    
    for (int i = 0; i<_XtitleArray.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 30, _xtitleView.height))];
        lab.centerX = 30 + i*35;
//        lab.backgroundColor = COLOR_Random;
        [_xtitleView addSubview:lab];
        lab.text = _XtitleArray[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = COLOR_RGBA(114, 129, 143, 1);
    }
}

@end























