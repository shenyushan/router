//
//  UIViewController+Router.m
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

@implementation UIViewController (Router)

//static char kAssociatedParamsObjectKey;

//-(void)setRouterParameters:(NSDictionary *)routerParameters{
//    objc_setAssociatedObject(self, &kAssociatedParamsObjectKey, routerParameters,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//-(NSDictionary *)routerParameters{
//    return  objc_getAssociatedObject(self, &kAssociatedParamsObjectKey);
//}

- (void)willDisplayByRouter:(RRouterManager *)router handler:(void(^)(RRouterDisplayViewControllerType result, RRouterError *error))handler{   
    handler(RRouterDisplayViewControllerTypeAvaliable,nil);
}

- (bool)canDisplayByRouter:(RRouterManager *)router{
    return YES;
}


@end
