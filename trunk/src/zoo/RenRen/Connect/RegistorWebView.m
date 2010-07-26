//
//  RegistorWebView.m
//  zoo
//
//  Created by AlexLiu on 7/23/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "RegistorWebView.h"


@implementation RegistorWebView

@synthesize instructionsView,doneButton,flipButton;
@synthesize myWebView;
@synthesize navigationController;


- (id)initWithURL:(NSURL *)url
{
	if ((self = [super init])) {
		
	}
	return self;
}

//3 in viewDidload function:
- (void)loadView {
    //[super viewDidLoad];
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame]; //web大小
	webFrame.origin.y += 25;//向下移动为了留出输入网址的frame
	//webFrame.size.height -= 80;
	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease ];
    myWebView.backgroundColor = [UIColor redColor]; //背景色
	myWebView.scalesPageToFit = YES; 
	myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	//myWebView.delegate = self;
	[self.view addSubview:myWebView];
	
	//CGRect textFieldFrame = CGRectMake(kLeftMargin, kTweenMargin,
//									   self.view.bounds.size.width - (kLeftMargin * 2.0), kTextFieldHeight); 
//	UITextField *urlField = [[UITextField alloc] initWithFrame:textFieldFrame];//输入框
//	urlField.borderStyle = UITextBorderStyleBezel;
//	urlField.textColor = [UIColor blackColor];
//	urlField.delegate = self;
//	urlField.placeholder = @"<enter a URL>"; //提示
//	urlField.text = @"http://www.163.com";//开始显示的网址
//	urlField.backgroundColor = [UIColor whiteColor];
//	urlField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//	urlField.returnKeyType = UIReturnKeyGo;  //return 显示的是GO
//	urlField.keyboardType = UIKeyboardTypeURL; // 方便输入网址的类型键盘
//	urlField.autocapitalizationType = UITextAutocapitalizationTypeNone; // don't capitalize
//	urlField.autocorrectionType = UITextAutocorrectionTypeNo; // we don't like autocompletion while typing
//	urlField.clearButtonMode = UITextFieldViewModeAlways; //输入框右边的 “叉”
//	[urlField setAccessibilityLabel:NSLocalizedString(@"URLTextField", @"")];
//	[self.view addSubview:urlField];
//	[urlField release];
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com/"]]];//自动加载URL
}
//
//
////4 U can see the frame from above.
////5This function makes your view rotation was supported.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return YES;
//}
//
////6 After you enter a URL, if you press "Done", the keyboard miss and open the URL you just typed. 
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//	[textField resignFirstResponder];
//	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[textField text]]]];
//	
//	return YES;
//}
//
//
////8 OK, in fact , all  works very well for now. Next , call this two functions is just in case.
//#pragma mark  -
//#pragma mark UIViewController delegate methods
//- (void)viewWillAppear:(BOOL)animated
//{
//	self.myWebView.delegate = self; // setup the delegate as the web view is shown
//	NSLog(@"willappear");
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//	[self.myWebView stopLoading]; // in case the web view is still loading its content
//	self.myWebView.delegate = nil; // disconnect the delegate as the webview is hidden
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//	NSLog(@"willDisappear");
//}
//
////9 #pragma mark -
////#pragma mark UIWebViewDelegate
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//	// 状态栏上的缓冲标志
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//	// 消除缓冲标志
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//	
//	// 报告错误
//	NSString* errorString = [NSString stringWithFormat:
//							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
//							 error.localizedDescription];
//	[self.myWebView loadHTMLString:errorString baseURL:nil];
//}



- (void)dealloc
{
	myWebView.delegate = nil;
	[myWebView release];
	
	[navigationController release];
	[instructionsView release];
	[doneButton release];
	[flipButton release];
	[super dealloc];
}



@end
