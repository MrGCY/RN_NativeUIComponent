//
//  TestView.h
//  NativeUIComponentProject
//
//  Created by Mr.GCY on 2018/3/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
@interface TestView : UIView
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) BOOL  isEdit;
@property (nonatomic, copy) RCTBubblingEventBlock onClickEvent;
//没有返回值
-(void)notCallBackValueMethod;
//有返回值的函数
-(NSString *)haveCallBackValueMethod;
@end
