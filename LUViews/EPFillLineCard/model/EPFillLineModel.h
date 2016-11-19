//
//  EPActivityLineModel.h
//  E-Platform
//
//  Created by luchanghao on 16/10/21.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//
#import "cong.h"

#import <UIKit/UIKit.h>

@interface EPFillLineModel : UIView
@property (nonatomic, strong) NSString *headTitle;
@property (nonatomic, strong) NSString *headDetail;
@property (nonatomic, strong) NSString *fromDataTitle;
@property (nonatomic, strong) NSString *toDataTitle;
@property (nonatomic, strong) NSString *numCount;
@property (nonatomic, strong) NSArray  *XtitleArray;
@property (nonatomic, strong) NSArray  *drawPointValue;

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;
@property (nonatomic, assign) CGSize picSize;
@property (nonatomic, assign) double maxY;
@property (nonatomic, assign) double minY;

@end
