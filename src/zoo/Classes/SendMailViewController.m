//
//  SendMailViewController.m
//  SendMail
//
//  Created by Hunk on 10-8-20.
//  Copyright Vanceinfo 2010. All rights reserved.
//

#import "SendMailViewController.h"

@implementation SendMailViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
//	[self.view setBackgroundColor:[UIColor blueColor]];
	
//	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//	if(nil != mailClass)
//	{
//		// Check whether the current device is configured for sending emails
//		if([mailClass canSendMail])
//		{
//			[self displayComposerSheet];
//		}
//		else
//		{
//			// Configure the device for sending mail
//			[self configureDeviceForSendingMail];
//		}
//	}
//	else
//	{
//		[self configureDeviceForSendingMail];
//	}
	[self configureDeviceForSendingMail];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark Configure the device for sending mail
-(void)configureDeviceForSendingMail
{
	// Recipient(s)
	NSString* strRecipient = @"mailto:HappyZooFeedback@gmail.com?cc=nil,nil&subject=Happy zoo's feedback";

	// Mail body
	NSString* strBody = @"&body=感谢您对欢乐动物园提出宝贵意见和建议.";

	NSString* strEmail = [NSString stringWithFormat:@"%@%@", strRecipient, strBody];
	strEmail = [strEmail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:strEmail]];
}

#pragma mark -
#pragma mark Display composer sheet
-(void)displayComposerSheet
{
	MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	// Mail title
	[picker setSubject:@"Happy zoo's feedback"];
	
	// Recipient(s)
	NSArray* arrToRecipients = [NSArray arrayWithObject:@"HappyZooFeedback@gmail"];
	[picker setToRecipients:arrToRecipients];
	
	// Fill out the email body text
	NSString* strEmailBody = @"感谢您对欢乐动物园提出宝贵意见和建议\n";
	[picker setMessageBody:strEmailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

#pragma mark -
#pragma mark Send mail call back
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
		{}
			break;
		case MFMailComposeResultSaved:
		{}
			break;
		case MFMailComposeResultSent:
		{
			[self.view removeFromSuperview];
		}
			break;
		case MFMailComposeResultFailed:
		{}
			break;
		default:
		{}
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc 
{
    [super dealloc];
}

@end
