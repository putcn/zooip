//
//  RegistorWebView.h
//  zoo
//
//  Created by AlexLiu on 7/23/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kLeftMargin 0
#define kTweenMargin 0
#define kTextFieldHeight 40

@interface RegistorWebView :  UIViewController<UIWebViewDelegate>
{
	UIView *instructionsView;	
	UIBarButtonItem *doneButton;
	UIWebView *myWebView;
//	UINavigationController *navigationController;
	UIActivityIndicatorView *activityIndicator;
	UIAlertView *myAlert;
}

//@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIView *instructionsView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end

