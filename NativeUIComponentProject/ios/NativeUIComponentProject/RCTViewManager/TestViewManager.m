//
//  TestViewManager.m
//  NativeUIComponentProject
//
//  Created by Mr.GCY on 2018/3/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "TestViewManager.h"
#import "TestView.h"
//#import <MapKit/MKMapView.h>


//主要实现调用原生组件暴露的方法
#import <React/RCTBridge.h>//进行通信的头文件
#import <React/RCTEventDispatcher.h>  //事件派发，不导入会引起Xcode警告
#import <React/RCTUIManager.h>


@implementation TestViewManager
RCT_EXPORT_MODULE()


#pragma mark- 注册原生组件的属性 供js传参
//暴露属性  私有属性也可以设置
RCT_EXPORT_VIEW_PROPERTY(dataArray, NSArray);
RCT_EXPORT_VIEW_PROPERTY(isEdit, BOOL);
//可以回调数据  注：RCTBubblingEventBlock 定义的属性必须以onClick开头
RCT_EXPORT_VIEW_PROPERTY(onClickEvent, RCTBubblingEventBlock);

//地图显示
//-(UIView *)view{
//
//  return [[MKMapView alloc] init];
//}

//自定义组件显示
-(TestView *)view{
  return [[TestView alloc] init];
}

//设置当前线程是在主线程
//RCTViewManager提供了一个函数，用来指定当前manger中的方法在哪个线程执行。实现如下方法，则代表当前manager中的所有方法都会在主线程执行。
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

#pragma mark- 调用原生模块方法
//点击cell 通过js传过来的数据
RCT_EXPORT_METHOD(clickCellEventData: (NSDictionary *)detailDic){
  [TestViewManager alertMsg:[NSString stringWithFormat:@"%@",detailDic]];
}

#pragma mark- 调用原生组件的方法
/// 拿到当前View
- (TestView *) getViewWithTag:(NSNumber *)tag {
  NSLog(@"%@", [NSThread currentThread]);
  //官方建议需要放到主线程中，因为原生和js之间的调用都是在子线程中完成的
  UIView *view = [self.bridge.uiManager viewForReactTag:tag];
  return [view isKindOfClass:[TestView class]] ? (TestView *)view : nil;
}
//没有返回值的
RCT_EXPORT_METHOD(notCallBackValueMethod:(nonnull NSNumber *)reactTag){
  TestView * testView = [self getViewWithTag:reactTag];
  [testView notCallBackValueMethod];
}
//有返回值的
RCT_EXPORT_METHOD(haveCallBackValueMethod:(nonnull NSNumber *)reactTag
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
  TestView * testView = [self getViewWithTag:reactTag];
  NSString * value = [testView haveCallBackValueMethod];
  if (value) {
    resolve(value);
  }else {
    reject(@"1002", @"调用方法haveCallBackValueMethod出错", [NSError errorWithDomain:@"调用方法haveCallBackValueMethod出错" code:1002 userInfo:nil]);
  }
}


//弹框
+(void)alertMsg:(NSString *)msg{
  dispatch_async(dispatch_get_main_queue(), ^{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"接受reactnative数据" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了！", nil];
    [window addSubview:alertView];
    [alertView show];
  });
}
@end
