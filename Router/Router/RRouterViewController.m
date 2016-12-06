//
//  RRouterViewController.m
//  Router
//
//  Created by yushan shen on 2016/12/6.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "RRouterViewController.h"
#import "RRouter.h"

@interface RRouterViewController ()

@end

@implementation RRouterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willDisplayByRouter:(RRouterManager *)router handler:(void (^)(RRouterDisplayViewControllerType, RRouterError *))handler{
    NSDictionary *parameters = router.parametersInUrl;
    
    self.title = parameters[@"title"];
    
    //call handler continue or interrupt display
    handler(RRouterDisplayViewControllerTypeAvaliable,nil);
    
}
@end
