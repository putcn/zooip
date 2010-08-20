//
//  SendMailViewController.h
//  SendMail
//
//  Created by Hunk on 10-8-20.
//  Copyright Vanceinfo 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SendMailViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
	
}

-(void)configureDeviceForSendingMail;

-(void)displayComposerSheet;

@end

