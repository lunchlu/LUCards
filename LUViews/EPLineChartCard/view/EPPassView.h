//
//  EPPassView.h
//  view11-11
//
//  Created by luchanghao on 16/11/11.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPassView : UIView
@property (nonatomic, assign)BOOL isPass;

@property (nonatomic, strong)NSString *passStr;//不通过
@property (nonatomic, strong)NSString *detailStr;//压力测试
@end
