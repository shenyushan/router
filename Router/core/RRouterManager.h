//
//  RRouterManager.h
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RRouterManagerProcessTypeContinue,
    RRouterManagerProcessTypeInterrupt,
} RRouterManagerProcessType;

@class RRouterManager,RRouterError;
@protocol RRouterManagerDelegate <NSObject>

@optional
/*
 router want push or present viewcontroller;
 call handler to continue, if result is continue, viewcontroller will be display;
 not call handler or result is interrupt,viewcontroller will not be display
 */
- (void)router:(RRouterManager *)manager willDisplayViewControllerWithUrl:(NSString *)url
       handler:(void(^)(RRouterManagerProcessType result))handler;

/*
 router did finishend display viewcontroller use url
 */
- (void)router:(RRouterManager *)router didfinishedDisplayViewControllerWithUrl:(NSString *)url;

- (void)router:(RRouterManager *)router didFailedDisplayViewControllerWithUrl:(NSString *)url error:(RRouterError *)error;
@end

@class RRouterManagerCenter;
@interface RRouterManager : NSObject

@property(weak, nonatomic) id<RRouterManagerDelegate>delegate;
@property(retain, nonatomic, readonly)RRouterManagerCenter *routerCenter; //default is  [RRouterManagerCenter sharedCenter]
@property(copy, nonatomic, readonly) NSString *url;
@property(retain, nonatomic, readonly) NSDictionary *parametersInUrl;

/**
 display viewcontroller used by routerUrl fromVC
 @param routerUrl      target url
 @param fromVC         the original viewcontroller
 @param routerCenter   use center to manager url and viewcontroller map
 */
- (void)routerPresentWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC routerCenter:(RRouterManagerCenter *)routerCenter;
/*defaultcenter  is self.routerCenter */
- (void)routerPresentUseDefaultCenterWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC ;


- (void)routerPushWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC routerCenter:(RRouterManagerCenter *)routerCenter;
- (void)routerPushUseDefaultCenterWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC ;

@end
