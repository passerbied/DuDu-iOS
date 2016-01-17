//
//  WebVC.m
//  DuDu
//
//  Created by i-chou on 1/15/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

#import "WebVC.h"

@implementation WebVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:ccr(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    webView.scrollView.decelerationRate = 1.0;
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.resourcePath ofType:@"txt"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    
    [webView loadData:content MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:path]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error.debugDescription);
}

@end
