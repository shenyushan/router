//
//  ViewController.m
//  Router
//
//  Created by yushan shen on 2016/12/2.
//  Copyright © 2016年 yushan.com. All rights reserved.
//

#import "ViewController.h"
#import "RRouter.h"
@interface ViewController ()<RRouterManagerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 150, 100, 30);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

- (void)btnClick{
    //step2 use RRouterManager display viewcontroller
    /*
    manager 在打开一个页面之前会首先询问delegate是否需要打开,当delegate允许之后，会询问url对应的VC是否可以打开
    VC可以使用manager.parametersInUr获取必要参数来决定是否打开
     
     */
    RRouterManager *manager = [[RRouterManager alloc] init];
    manager.delegate  = self;
    [manager routerPushWithURL:@"router://router.test.com/test?title=RRouterViewController" fromVC:self routerCenter:[RRouterManagerCenter sharedCenter]];

}


-(void)router:(RRouterManager *)manager willDisplayViewControllerWithUrl:(NSString *)url handler:(void (^)(RRouterManagerProcessType))handler{
    NSLog(@"即将跳转到 %@",url);
    
    //can handler to continue or interrupt display
    handler(RRouterManagerProcessTypeContinue);
}

-(void)router:(RRouterManager *)router didFailedDisplayViewControllerWithUrl:(NSString *)url error:(RRouterError *)error{
    NSLog(@"%@",error.message);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
