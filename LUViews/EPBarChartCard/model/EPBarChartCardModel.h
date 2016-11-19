//
//  EPLineChartCardModel.h
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//
#import "cong.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EPBarChartCardModel : NSObject

@property (nonatomic, assign) CGFloat cardHeight;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSArray *temperatureArray;
@property (nonatomic, strong) NSArray *moistureArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *XtitleArray;

@property (nonatomic, strong) NSArray *temperatureY;
@property (nonatomic, strong) NSArray *moistureY;


@property (nonatomic, strong) NSMutableArray *pointHeightForT;
@property (nonatomic, strong) NSMutableArray *pointHeightForM;
@property (nonatomic, strong) NSMutableArray *YHeight;
@property (nonatomic, strong) NSMutableArray *YvalueForT;
@property (nonatomic, strong) NSMutableArray *YvalueForM;

@property (nonatomic, strong) NSMutableArray *Xwidth;


//通过，不通过
@property (nonatomic, assign)BOOL isShowPass;
@property (nonatomic, assign)BOOL isPass;
@property (nonatomic, strong)NSString *passStr;//不通过
@property (nonatomic, strong)NSString *detailStr;//压力测试


+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;

@end
