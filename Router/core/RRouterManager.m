//
//  RRouterManager.m
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "RRouterManager.h"
#import "RRouterViewControllerProtocol.h"
#import "RRouterManagerCenter.h"
#import "UIViewController+Router.h"
#import "NSString+UrlComponent.h"
#import "RRouterError.h"

@interface RRouterManager()

@property(copy, nonatomic)   void(^delegateHandler)(RRouterManagerProcessType result);
@property(copy, nonatomic)   void(^viewControllerHandler)(RRouterDisplayViewControllerType result, RRouterError *error);
@property(weak, nonatomic)   UIViewController *presentFromVC;
@property(weak, nonatomic)   UINavigationController *navigationVC;
@property(copy, nonatomic)   NSString *url;
@property(retain, nonatomic) NSDictionary *parametersInUrl;

@property(retain, nonatomic) UIViewController *targetVC;
@property(retain, nonatomic)RRouterManagerCenter *routerCenter; //default is  [RRouterManagerCenter sharedCenter]


@end

@implementation RRouterManager

-(void)dealloc{
    NSLog(@"1111");
}
- (instancetype)init{
    if (self = [super init]) {
        self.routerCenter = [RRouterManagerCenter sharedCenter];
        [self initDelegateHandler];
        [self initViewcontrollerHandler];
    }
    return self;
}

-(void)setUrl:(NSString *)url{
    _url = url;
    self.parametersInUrl = [url parameters];
}

- (void)initDelegateHandler{
    __block RRouterManager * blockSelf = self;
    self.delegateHandler = ^(RRouterManagerProcessType result){
        if (result == RRouterManagerProcessTypeContinue) {
            //ask for targetvc to handle
            if ([blockSelf.targetVC respondsToSelector:@selector(willDisplayByRouter:handler:)]) {
                [blockSelf.targetVC willDisplayByRouter:blockSelf handler:blockSelf.viewControllerHandler];
            }else{
                //if targetvc not handle ,manager will handle
                [blockSelf displayViewController];
            }
        }else if (result == RRouterManagerProcessTypeInterrupt){
            NSLog(@"RRouterManager.delegate interrupt display viewcontroller %@",[blockSelf.targetVC class]);
        }
        blockSelf = nil;
    };
}

- (void)initViewcontrollerHandler{
    
    __block RRouterManager * blockSelf = self;
    self.viewControllerHandler = ^(RRouterDisplayViewControllerType result, RRouterError *error){
        if (result == RRouterDisplayViewControllerTypeRefused) {
            NSLog(@"%@ refuse display",[blockSelf.targetVC class]);
            if ([blockSelf.delegate respondsToSelector:@selector(router:didFailedDisplayViewControllerWithUrl:error:)]) {
                [blockSelf.delegate router:blockSelf didFailedDisplayViewControllerWithUrl:blockSelf.url error:error];
            }
        }else if(result == RRouterDisplayViewControllerTypeAvaliable){
            [blockSelf displayViewController];
        }
        blockSelf = nil;
    };
}

- (void)displayViewController{
    
    if (self.presentFromVC) {
        [self.presentFromVC presentViewController:self.targetVC animated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(router:didfinishedDisplayViewControllerWithUrl:)]) {
                [self.delegate router:self didfinishedDisplayViewControllerWithUrl:self.url];
            }
        }];
    }else if (self.navigationVC){
        [self.navigationVC pushViewController:self.targetVC animated:YES];
    }
}

- (void)routerPresentWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC routerCenter:(RRouterManagerCenter *)routerCenter{
    self.targetVC = [routerCenter viewControllerForRouterUrl:routerUrl];
    if (!self.targetVC) {
        if ([self.delegate respondsToSelector:@selector(router:didFailedDisplayViewControllerWithUrl:error:)]) {
            RRouterError *error = [[RRouterError alloc] initWithType:RRouterErrorTypeUrlUnSupport message:@"unsupport url"];
            [self.delegate router:self didFailedDisplayViewControllerWithUrl:routerUrl error:error];
        }
        return;
    }
    self.presentFromVC = fromVC;
    self.navigationVC = nil;
    self.url = routerUrl;
    self.routerCenter = routerCenter;
    if ([self.delegate respondsToSelector:@selector(router:willDisplayViewControllerWithUrl:handler:)]) {
        [self.delegate router:self willDisplayViewControllerWithUrl:routerUrl handler:self.delegateHandler];
    }else{
        self.delegateHandler(RRouterManagerProcessTypeContinue);
    }
    
}
- (void)routerPresentUseDefaultCenterWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC {
    [self routerPushWithURL:routerUrl fromVC:fromVC routerCenter:[RRouterManagerCenter sharedCenter]];
}


- (void)routerPushWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC routerCenter:(RRouterManagerCenter *)routerCenter{
    self.targetVC = [routerCenter viewControllerForRouterUrl:routerUrl];
    if (!self.targetVC) {
        if ([self.delegate respondsToSelector:@selector(router:didFailedDisplayViewControllerWithUrl:error:)]) {
            RRouterError *error = [[RRouterError alloc] initWithType:RRouterErrorTypeUrlUnSupport message:[NSString stringWithFormat:@"unsupport url:%@",routerUrl]];
            [self.delegate router:self didFailedDisplayViewControllerWithUrl:routerUrl error:error];
        }
        return;
    }
    self.navigationVC = fromVC.navigationController;
    self.presentFromVC = nil;
    self.url = routerUrl;
    self.routerCenter = routerCenter;
    if ([self.delegate respondsToSelector:@selector(router:willDisplayViewControllerWithUrl:handler:)]) {
        [self.delegate router:self willDisplayViewControllerWithUrl:routerUrl handler:self.delegateHandler];
    }else{
        self.delegateHandler(RRouterManagerProcessTypeContinue);
    }
}

- (void)routerPushUseDefaultCenterWithURL:(NSString *)routerUrl fromVC:(UIViewController *)fromVC {
    [self routerPushWithURL:routerUrl fromVC:fromVC routerCenter:[RRouterManagerCenter sharedCenter]];
}


@end













