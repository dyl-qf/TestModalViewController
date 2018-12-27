//
//  ViewController.m
//  TestModalViewController
//
//  Created by liqian on 2018/12/14.
//  Copyright © 2018 liqian. All rights reserved.
//

#import "ViewController.h"
#import "UkeAlertController.h"
#import "ViewController2.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)test:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test2:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test3:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 300, 800);
    view.backgroundColor = [UIColor redColor];
    
//    UIView *subView = [[UIView alloc] init];
//    //    subView.frame = CGRectMake(0, 0, 400, 200);
//    subView.backgroundColor = [UIColor orangeColor];
//    [view addSubview:subView];
//    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200, 200));
//        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
//    }];
    
//    UkeAlertController *alert = [UkeAlertController alertControllerWithContentView:view preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UkeAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test4:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 300, 800);
    view.backgroundColor = [UIColor redColor];
    
//    UIView *subView = [[UIView alloc] init];
////    subView.frame = CGRectMake(0, 0, 400, 200);
//    subView.backgroundColor = [UIColor orangeColor];
//    [view addSubview:subView];
//    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 200));
//        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
//    }];
    
//    UkeAlertController *alert = [UkeAlertController alertControllerWithContentView:view preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];

    [alert addAction:[UkeAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
