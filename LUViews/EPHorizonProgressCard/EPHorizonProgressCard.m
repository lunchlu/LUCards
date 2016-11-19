//
//  EPProgressCard.m
//  view11-1
//
//  Created by luchanghao on 16/11/1.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import "EPHorizonProgressCard.h"
#import "UIView+Frame.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface EPHorizonProgressCard ()
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *dateImg;

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) EPProgressCardDrawLneView *drawLineView;
@property (nonatomic, strong) UIView *progressLabelsView;
@end

@implementation EPHorizonProgressCard

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setupHeadView];
        [self setupProgressView];
        
        self.frame = CGRectMake(0, 100, SCREEN_WIDTH, 100);
        
        
        self.backgroundColor = [UIColor colorWithRed:27/255.0 green:33/255.0 blue:50/255.0 alpha:1];
    }
    return  self;
}

-(void)setupHeadView{
    self.headView = [[UIView alloc] initWithFrame:(CGRectMake(0, 20, SCREEN_WIDTH, 40))];
    [self addSubview:_headView];
    self.titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(15, 0, 100, _headView.height))];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [_headView addSubview:_titleLabel];
    
    self.dateView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 120, _headView.height))];
    [_headView addSubview:_dateView];
    _dateView.right = SCREEN_WIDTH - 15;
    self.dateLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 65, _headView.height))];
    _dateLabel.textColor = [UIColor colorWithRed:126/255.0 green:142/255.0 blue:158/255.0 alpha:1];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    [_dateView addSubview:_dateLabel];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.right = _dateView.width;
    self.dateImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 22, _headView.height-8))];
    _dateImg.image = [UIImage imageNamed:@"EPHorizonCalendar"];
    _dateImg.contentMode = UIViewContentModeScaleAspectFit;
    _dateImg.right = _dateLabel.left;
    _dateImg.centerY = _dateLabel.centerY;
    [self.dateView addSubview:_dateImg];
}

-(void)setupProgressView{
    self.progressView = [[UIView alloc] initWithFrame:(CGRectMake(0, _headView.bottom, SCREEN_WIDTH, 120))];
    [self addSubview:_progressView];
    
    self.drawLineView = [[EPProgressCardDrawLneView alloc] init];
    [_progressView addSubview:_drawLineView];
    _drawLineView.top = 35;
    
    self.progressLabelsView = [[UIView alloc] initWithFrame:(CGRectMake(0, _drawLineView.bottom, SCREEN_WIDTH, 40))];
    [_progressView addSubview: _progressLabelsView];
}

-(void)setupProgressLabelsView{
    for (UIView *view in _progressLabelsView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i<_model.progressArray.count; i++) {
        NSString *title = _model.progressArray[i];
        NSNumber *value = _model.drawPointsArray[i];
        CGFloat x = [value floatValue];
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, (SCREEN_WIDTH- 30)/6, 30))];
        [_progressLabelsView addSubview:label];
        label.text = title;
        label.numberOfLines = 0;
        label.centerX = x;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        
        if (i == _model.nowProgress) {
            label.textColor = [UIColor colorWithRed:252/255.0 green:151/255.0 blue:83/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
        }
        if (i > _model.nowProgress) {
            label.textColor = [UIColor colorWithRed:96/255.0 green:98/255.0 blue:107/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:11];

        }
        
        
        CGRect rect = [title boundingRectWithSize:(CGSizeMake(label.width, MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:nil];
        label.height = rect.size.height;
        
        if (_progressLabelsView.height < label.bottom ) {
            _progressLabelsView.height = label.bottom;
            self.height = _progressLabelsView.bottom +20;
        }
        
    }
}


-(void)setModel:(EPHorizonProgressCardModel *)model{
    _model = model;
    self.height = model.cellHeight;
    _drawLineView.pointsArray = model.drawPointsArray;
    _drawLineView.nowProgress = model.nowProgress;
    _titleLabel.text = model.title;
    _dateLabel.text = model.dateTitle;
    [self setupProgressLabelsView];
    
}
@end


@implementation EPProgressCardDrawLneView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    }

    return self;
}


-(void)setPointsArray:(NSMutableArray *)pointsArray{
    _pointsArray = pointsArray;
    [self setupSubViews];
}

-(void)setupSubViews{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:(CGRectMake([_pointsArray[0] floatValue], 6.5, SCREEN_WIDTH - 75, 2))];
    [self addSubview: line];
    line.backgroundColor = [UIColor colorWithRed:57/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    
    for (NSNumber *value in _pointsArray) {
        CGFloat x = [value floatValue];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 15, 15))];
        imgView.centerX = x;
        [self addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"EPHorizonPointGreen"];
        imgView.contentMode = 1;
    }
}

-(void)setNowProgress:(NSInteger)nowProgress{
    _nowProgress = nowProgress;
    UIImageView *imgView = self.subviews[nowProgress + 1];
    imgView.image = [UIImage imageNamed:@"EPHorizonPointOrange"];
}



@end






















