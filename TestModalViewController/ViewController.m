//
//  ViewController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/14.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "ViewController.h"
#import "UkeAlertController.h"

@interface ViewController ()
@property (nonatomic, strong) UkeAlertController *popUpVc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)test:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"消息消息消息消息" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test2:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"消息消息消息消息" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)test3:(id)sender {
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, 260, 150);
//    view.backgroundColor = [UIColor whiteColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor purpleColor];
//    button.frame = CGRectMake(50, 80, 80, 50);
//    [button setTitle:@"dismiss" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
    
    _popUpVc = [UkeAlertController uke_alertControllerWithTitle:@"你好" message:@"测试测试测试" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:_popUpVc animated:YES completion:nil];
}

- (void)dismiss {
    [_popUpVc dismiss];
}

- (IBAction)test4:(id)sender {
    
}


@end
