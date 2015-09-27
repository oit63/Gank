//
//  WebViewController.m
//  gank
//
//  Created by yons on 15/8/18.
//  Copyright (c) 2015年 Alfred. All rights reserved.
//

#import "WebViewController.h"
#import "FirstViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController
@synthesize webView;
@synthesize urlString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



}
- (void)viewWillAppear:(BOOL)animated {
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    NSLog(@"=====%@",urlString);
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)prepareForView:(NSString *)string {
    NSLog(string);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
