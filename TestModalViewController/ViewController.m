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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleAlert];

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
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"--->");
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test2:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～\n课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～课前15分钟才可进入教室\n请耐心等待哦～" preferredStyle:UIAlertControllerStyleActionSheet];

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
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)test3:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"第一个" message:nil preferredStyle:UIAlertControllerStyleAlert];
    alert.identifier = @"1";
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert show];
    
    
    UkeAlertController *alert2 = [UkeAlertController alertControllerWithTitle:@"第二个" message:nil preferredStyle:UIAlertControllerStyleAlert];
    alert2.identifier = @"2";
    [alert2 addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert2 show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UkeAlertController *alert2 = [UkeAlertController alertControllerWithTitle:@"第二个" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        alert2.identifier = @"2";
//        [alert2 addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//        [alert2 show];
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeUkeAlertControllerWithIdentifier:@"2" animated:NO completion:nil];
//
////        [self removeAllUkeAlertConrollerAnimated:NO completion:^{
////            UkeAlertController *alert3 = [UkeAlertController alertControllerWithTitle:@"第一个" message:nil preferredStyle:UIAlertControllerStyleAlert];
////            alert3.identifier = @"1";
////            [alert3 addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
////            [alert3 show];
////        }];
//    });
}

- (IBAction)test4:(id)sender {
    UkeAlertController *alert = [UkeAlertController alertControllerWithTitle:@"第一个" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
//    alert.cornerRadius = 0;
//    alert.contentWidth = [UIScreen mainScreen].bounds.size.width;
//    alert.sheetContentMarginBottom = 0;
    
//    UIView *view = [[UIView alloc] init];
////    view.frame = CGRectMake(0, 0, 300, 800);
//    view.backgroundColor = [UIColor redColor];
//
//    UIView *subView = [[UIView alloc] init];
//    subView.backgroundColor = [UIColor orangeColor];
//    [view addSubview:subView];
//    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(200, 800));
//        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
//    }];
    
//    UkeAlertController *alert = [UkeAlertController alertControllerWithContentView:view preferredStyle:UIAlertControllerStyleActionSheet];
    
//    UkePopUpViewController *popUp = [UkePopUpViewController alertControllerWithContentView:view preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UkeAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UkeAlertController *alert2 = [UkeAlertController alertControllerWithTitle:@"第二个" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UkeAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [alert2 addAction:[UkeAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert2 show];
    });
}


@end
