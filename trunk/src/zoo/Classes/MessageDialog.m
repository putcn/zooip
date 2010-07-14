//
//  MessageDialog.m
//  Common
//
//  Created by Niu Darcy on 1/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageDialog.h"


@implementation MessageDialog

@synthesize isOpen;

-(id) initDialog:(NSString*) filePath setTarget:(id) target setSelector:(SEL) handler
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] ))
	{
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:filePath ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		
		CGSize s = [self.texture contentSize];
		
		lblMessage = [CCLabel labelWithString:@"操作已成功!" dimensions:CGSizeMake(s.width - 50, s.height - 70)
								  alignment:UITextAlignmentCenter fontName:@"Microsoft YaHei" fontSize:12];
		lblMessage.position = ccp( s.width / 2 , (s.height / 2) - 10 );
		lblMessage.color = ccc3(0, 0, 0);
		[self addChild:lblMessage];
		
		Button *btnClose = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:12 setBackground:@"Confirm.png" setTarget:self setSelector:@selector(closeDialogHandler) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
		btnClose.position = ccp( s.width - 5, 5 );
		[self addChild:btnClose];
		[btnClose release];
		
		self.position = ccp( -500 , -500 );
		isOpen = NO;
		
		targetCallBack = [target retain];
		selector = handler;
	}
	return self;
}

- (void) dealloc
{
	[lblMessage release];
	[self.texture release];
	[super dealloc];
}

-(void) closeDialogHandler
{
	if (isOpen) [self popUp:@""];
}
-(void) popUp:(NSString*) msg;
{
	[lblMessage setString:msg];
	CGSize size = [[CCDirector sharedDirector] winSize];
	if (isOpen)
	{
		self.position = ccp( -500 , -500 );
	}
	else
	{
		self.position = ccp( size.width / 2 , size.height / 2 );
		
		self.scale = 0.1f;
		id actionScaling = [CCScaleTo actionWithDuration:0.6  scale:1];
		
		id ease = [CCEaseBackOut actionWithAction: actionScaling];
		[ease setDuration:0.3];
		
		[self runAction:ease];
	}
	isOpen = !isOpen;
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( self.position.x > -500 ) return YES;
	return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (selector != nil && [self containsTouchLocation:touch])
	{
		isOpen = NO;
		self.position = ccp( -500 , -500 );
		[targetCallBack performSelector:selector];
	}
}

@end
