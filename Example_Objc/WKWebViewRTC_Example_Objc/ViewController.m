//
//  ViewController.m
//  WKWebViewRTC_Example_Objc
//
//  Created by Park Sehun on 2021/02/23.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <WKWebViewRTC/WKWebViewRTC-Swift.h>

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    configuration.allowsInlineMediaPlayback = YES;
//    configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    //configuration.applicationNameForUserAgent = @"Version/14.0.2 Safari/605.1.15";
    //onfiguration.applicationNameForUserAgent = @"Version/11.0 Safari/604.1.28";
    //configuration.applicationNameForUserAgent = @"ReactNative";
    
    // pageCall 1.0 에서 모바일로 설정하지 않으면 미디어 권한 없음 팝업이 뜬다.
    if (@available(iOS 13.0, *)) {
        configuration.defaultWebpagePreferences.preferredContentMode = WKContentModeMobile;
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    [self.view addSubview:self.webView];
    
    // Support dark mode
    if (@available(iOS 13.0, *)) {
        self.webView.backgroundColor = [UIColor systemBackgroundColor];
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.webView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
    }

    // Safe Area programmatically
    UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
    [self.webView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor].active = YES;
    [self.webView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor].active = YES;
    [self.webView.topAnchor constraintEqualToAnchor:guide.topAnchor].active = YES;
    [self.webView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;

    // Refresh myView and/or main view
    [self.view layoutIfNeeded];
    
    WKWebViewRTC *webViewRTC = [[WKWebViewRTC alloc] initWithWkwebview:self.webView contentController:self.webView.configuration.userContentController];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://pplink.net/call_new/testMobile0224n"]];
    [self.webView loadRequest:request];    
}


@end
