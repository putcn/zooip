//
//  SendMailButton.m
//  zoo
//
//  Created by Hunk on 10-8-20.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "SendMailButton.h"
#import "Button.h"
#import "SendMailViewController.h"

@implementation SendMailButton

-(id)init
{
	if((self = [super init]))
	{
		Button* sendMailBtn; 
		sendMailBtn = [[Button alloc]initWithLabel:@"邮件反馈"
												  setColor:ccc3(255, 0, 0)
												   setFont:@"Arial"
												   setSize:16
											 setBackground:@"取消_按下.png"
												 setTarget:self
											   setSelector:@selector(sendMailBtnHandler:)
											   setPriority:50
												   offsetX:-1
												   offsetY:-1
													 scale:0.8f];
		
		sendMailBtn.position = ccp(40, 40);
		[self addChild:sendMailBtn];
		[sendMailBtn release];
	}
	return self;
}

#pragma mark -
#pragma mark Send mail button handler
-(void)sendMailBtnHandler:(id)sender
{
	NSLog(@"Send mail touched\n");
	
	SendMailViewController* sendMail = [[SendMailViewController alloc]init];
	
	[[UIApplication sharedApplication].keyWindow addSubview:sendMail.view];
}

-(void)dealloc
{
	[super dealloc];
}

@end
