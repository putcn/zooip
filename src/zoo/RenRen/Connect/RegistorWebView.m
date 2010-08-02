//
//  RegistorWebView.m
//  zoo
//
//  Created by AlexLiu on 7/23/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "RegistorWebView.h"


@implementation RegistorWebView

@synthesize instructionsView,doneButton;
@synthesize myWebView;
@synthesize navigationController;
@synthesize  activityIndicator;


- (id)initWithURL:(NSURL *)url
{
	if ((self = [super init])) {
		
	}
	return self;
}

//3 in viewDidload function:
//- (void)viewDidload{
- (void)viewDidLoad {
	
	NSLog(@"test%@",@"ALEXTEST&*)#$^&@#*^$&*@#");
    [super viewDidLoad];
//	CGRect webFrame = [[UIScreen mainScreen] applicationFrame]; //web大小
//	webFrame.origin.y += 25;//向下移动为了留出输入网址的frame
//	//webFrame.size.height -= 80;
//	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease ];
//    myWebView.backgroundColor = [UIColor redColor]; //背景色
//	myWebView.scalesPageToFit = YES; 
//	myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//	//myWebView.delegate = self;
//	[self.view addSubview:myWebView];
//	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com/"]]];//自动加载URL
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
		
	myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 480, 290)]; 
	[myWebView setUserInteractionEnabled:YES]; 
	[myWebView setBackgroundColor:[UIColor whiteColor]]; 
	[myWebView setDelegate:self]; 
	[myWebView setOpaque:NO];//使网页透明 
	
	NSString *path = @"http://reg.renren.com"; 
	NSURL *url = [NSURL URLWithString:path]; 
    
	[myWebView loadRequest:[NSURLRequest requestWithURL:url]]; 
	
	//创建UIActivityIndicatorView背底半透明View     
	instructionsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)]; 
	[instructionsView setTag:103]; 
	[instructionsView setBackgroundColor:[UIColor blackColor]]; 
	[instructionsView setAlpha:0.8]; 
	[self.view addSubview:instructionsView]; 
	
	NSArray *buttonNames = [NSArray arrayWithObjects:[UIImage imageNamed:@"return.png"],nil];
	UISegmentedControl *segmentdeControl = [[UISegmentedControl alloc] initWithItems:buttonNames];
	
	segmentdeControl.momentary = YES;
	//Customize the Segmented Control
	segmentdeControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	segmentdeControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentdeControl.backgroundColor = [UIColor clearColor];
	segmentdeControl.frame = CGRectMake(0, 0, 30, 30);
	[segmentdeControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	//Add
	self.navigationItem.titleView = segmentdeControl;
	
//	UIButton *info = [UIButton buttonWithType:UIButtonTypeInfoLight];
//	[info addTarget:self 
//			 action:@selector(flipAction:) 
//   forControlEvents:UIControlEventTouchUpInside];
//	
//	UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:info];
//	self.navigationItem.rightBarButtonItem = infoBarButton;
	
//	UIBarButtonItem *callModalViewButton = [[UIBarButtonItem alloc]
//											initWithTitle:@"经文"
//											style:UIBarButtonItemStyleBordered
//											target:self
//											action:@selector(callModalList)];
//	self.navigationItem.leftBarButtonItem = callModalViewButton;
//	[callModalViewButton release];
	
	activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2.0f, 2.0f)]; 
	[activityIndicator setCenter:instructionsView.center]; 
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite]; 
	[instructionsView addSubview:activityIndicator]; 
	[self.view addSubview:myWebView]; 
	[instructionsView release]; 
	[myWebView release];
}

-(void)segmentAction:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"POP" object:nil];
	[self.view removeFromSuperview];
	//[self.navigationController.view removeFromSuperview];
	//self.navigationController.navigationBarHidden = YES;
}

//- (void) viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [super viewWillAppear:animated];
//}
//
//- (void) viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [super viewWillDisappear:animated];
//}

-(void)flipAction:(id)sender
{}
	

//加载网页动画 
- (void)webViewDidStartLoad:(UIWebView *)webView{ 
	if (myAlert==nil){        
		myAlert = [[UIAlertView alloc] initWithTitle:nil 
											 message: @"正在读取网络资料" 
											delegate: self 
								   cancelButtonTitle: nil 
								   otherButtonTitles: nil]; 
		UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]; 
		activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f); 
		[myAlert addSubview:activityView]; 
		[activityView startAnimating]; 
		[myAlert show]; 
	} 
} 
- (void)webViewDidFinishLoad:(UIWebView *)webView{ 
	[myAlert dismissWithClickedButtonIndex:0 animated:YES];
	if(myAlert != nil)
		myAlert =nil;
}
//开始加载数据 
//- (void)webViewDidStartLoad:(UIWebView *)webView {     
//	[activityIndicator startAnimating];          
//} 

//数据加载完 
//- (void)webViewDidFinishLoad:(UIWebView *)webView { 
//	[activityIndicator stopAnimating];     
	//UIView *view = (UIView *)[self.view viewWithTag:103]; 
//	[view removeFromSuperview]; 
//} 


- (void)dealloc
{
	myWebView.delegate = nil;
	[myWebView release];
	
	[activityIndicator release];
	[myAlert release];
	
	[navigationController release];
	[instructionsView release];
	[doneButton release];
	[super dealloc];
}

@end


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


