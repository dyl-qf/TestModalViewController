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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)test:(id)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示\n友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [self presentViewController:alert2 animated:YES completion:nil];
}

- (IBAction)test2:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];

//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test3:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];
//    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"你正在使用移动流量，是否继续播放？" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UkeAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test4:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}


@end
