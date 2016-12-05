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
@property(strong, nonatomic) UILabel *label;
@property(copy, nonatomic) NSString *text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.text = self.text;
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    RRouterManagerCenter *center = [RRouterManagerCenter sharedCenter];
    [center registerAppInfoSchemes];
    [center registerRouterUrl:@"http://www.baidu.com" viewControllerClass:[ViewController class]];
    RRouterManager *manager = [[RRouterManager alloc] init];
    manager.delegate  = self;
    [manager routerPushWithURL:@"router://WWw.abaidu.com?aaa=a&bbb=b&ccc=c" fromVC:self routerCenter:center];

}
-(void)router:(RRouterManager *)manager willDisplayViewControllerWithUrl:(NSString *)url handler:(void (^)(RRouterManagerProcessType))handler{
    handler(RRouterManagerProcessTypeContinue);
    
}

-(void)router:(RRouterManager *)router didFailedDisplayViewControllerWithUrl:(NSString *)url error:(RRouterError *)error{
    
    NSLog(@"%@",error.message);
}

- (void)willDisplayByRouter:(RRouterManager *)router handler:(void(^)(RRouterDisplayViewControllerType result, RRouterError *erro))handler{
    
    self.text = [router.parametersInUrl description];
    RRouterError *error = [[RRouterError alloc] initWithType:RRouterErrorTypeUrlUnAvailable message:@"参数不合法"];
    handler(RRouterDisplayViewControllerTypeAvaliable,error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
