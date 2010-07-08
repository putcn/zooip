/*
     File: TextFieldController.m
 Abstract: The view controller for hosting the UITextField features of this sample.
  Version: 2.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 */

#import "TextFieldController.h"
//#import "Constants.h"

#define kTextFieldWidth			260.0
#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0
#define kTextFieldHeight		30.0
static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

const NSInteger kViewTag = 1;
@implementation TextFieldController
@synthesize textFieldNormal,dataSourceArray;

- (void)dealloc
{
	[textFieldNormal release];
	[dataSourceArray release];
	[super dealloc];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.dataSourceArray = [NSArray arrayWithObjects:
								[NSDictionary dictionaryWithObjectsAndKeys:
								 @"", kSectionTitleKey, @"", kSourceKey, self.textFieldNormal, 
								 kViewKey, nil], nil];
	
	
	self.title = NSLocalizedString(@"TextFieldTitle", @"");
	UITextField *textField = [[self.dataSourceArray objectAtIndex: 0] valueForKey:kViewKey];
	[self.view addSubview:textField];
	
	// we aren't editing any fields yet, it will be in edit when the user touches an edit field
//	self.editing = YES;
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	[textFieldNormal release];
	textFieldNormal = nil;		

	self.dataSourceArray = nil;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	
	pstring = self.textFieldNormal.text;
	const char* tmp = [pstring UTF8String];
	strcpy(externChar, tmp);
	
	*pBTouch = YES;
	[self.view removeFromSuperview];
	return YES;
}

#pragma mark -
#pragma mark Text Fields

- (UITextField *)textFieldNormal
{
	if (textFieldNormal == nil)
	{
		CGRect frame = CGRectMake(110, 210, 140, kTextFieldHeight);
		textFieldNormal = [[UITextField alloc] initWithFrame:frame];
		
		textFieldNormal.borderStyle = UITextBorderStyleNone;
		textFieldNormal.textColor = [UIColor blackColor];
		textFieldNormal.font = [UIFont systemFontOfSize:20.0];
//		textFieldNormal.placeholder = @"<1-6 characters>";
		textFieldNormal.placeholder = @"";
		textFieldNormal.backgroundColor = [UIColor clearColor];
		textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		
		textFieldNormal.keyboardType = UIKeyboardTypeASCIICapable;	// use the default type input method (entire keyboard)
		textFieldNormal.returnKeyType = UIReturnKeyDone;
		
//		textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		
		textFieldNormal.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
		
		textFieldNormal.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
//		[textFieldNormal setBorderStyle:UITextBorderStyleRoundedRect];
		textFieldNormal.enablesReturnKeyAutomatically = YES;
		[textFieldNormal becomeFirstResponder];
//		textFieldNormal.enabled = no;
		
	}	
	return textFieldNormal;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{
    //limit the size :
    //int limit = 20;
    //return !([textField.text length]>limit && [string length] > range.length);

	pstring = self.textFieldNormal.text;
	if(string.length == 0)
		return YES;
	if(pstring.length >= 8)
		return NO;
	return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//	return YES;
//}



@end

