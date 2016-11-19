//
//  EPActivityLineView.h
//  E-Platform
//
//  Created by luchanghao on 16/10/21.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//
#import "cong.h"

#import <UIKit/UIKit.h>
#import "EPFillLineModel.h"

@interface EPFillLineCard : UIView
@property (nonatomic, strong)  EPFillLineModel *model;
@property (nonatomic, strong) NSString *headTitle;
@property (nonatomic, strong) NSString *headDetail;
@property (nonatomic, strong) NSString *fromDataTitle;
@property (nonatomic, strong) NSString *toDataTitle;

@property (nonatomic, strong) NSString *numCount;//133.50
@property (nonatomic, strong) NSArray *XtitleArray;//jan20
@property (nonatomic, strong) NSArray *drawPointValue;
@end





@interface EPProjeActivityLineCell: UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *lineColor;
@end




@interface EPDrawLineView : UIView
@property (nonatomic, strong)NSArray *pointArray;
@end
