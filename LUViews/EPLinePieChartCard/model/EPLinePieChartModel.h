//
//  EPPieChartModel.h
//  pie
//
//  Created by luchanghao on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EPLinePieChartModel : NSObject

@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *upTitleArray;
@property (nonatomic, strong) NSMutableArray *downTitleArray;
@property (nonatomic, copy) NSString *cardTitle;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) NSString *dateTitle;

@property (nonatomic, assign) CGFloat cardHeight;

//data
@property (nonatomic, assign) CGFloat totalValue;
@property (nonatomic, strong) NSMutableArray *angleArray;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) NSMutableArray *centerPointRadArray;
@property (nonatomic, strong) NSMutableArray *centerPointArray;
@property (nonatomic, strong) NSMutableArray *startAngleArray;
@property (nonatomic, strong) NSMutableArray *infoViewFrame;
@property (nonatomic, strong) NSMutableArray *startPointArray;
@property (nonatomic, strong) NSMutableArray *endPointArray;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableArray *rightArray;

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;
@end
