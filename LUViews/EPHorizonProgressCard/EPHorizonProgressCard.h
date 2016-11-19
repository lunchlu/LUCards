//
//  EPProgressCard.h
//  view11-1
//
//  Created by luchanghao on 16/11/1.
//  Copyright © 2016年 macBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPHorizonProgressCardModel.h"

@interface EPHorizonProgressCard : UIView
@property (nonatomic, strong) EPHorizonProgressCardModel *model;
@end

@interface EPProgressCardDrawLneView: UIView
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, assign) NSInteger nowProgress;
@end
