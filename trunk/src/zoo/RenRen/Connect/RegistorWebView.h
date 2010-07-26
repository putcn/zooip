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

@interface RegistorWebView :  UIViewController
{
	UIView *instructionsView;	
	UIBarButtonItem *doneButton;
	UIBarButtonItem *flipButton;
	UIWebView *myWebView;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIView *instructionsView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *flipButton;
@property (nonatomic, retain) UIWebView *myWebView;

@end

