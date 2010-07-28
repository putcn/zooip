//
//  Button.m
//  
//
//  Created by Niu Darcy on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Button.h"


@implementation Button

@synthesize label, target;

-(id) initWithLabel:(NSString*) labelText setColor:(ccColor3B) labelColor setFont:(NSString*) labelFont
		setSize:(int) labelSize setBackground:(NSString*) imagePath setTarget:(id) targetValue setSelector:(SEL) handler 
		setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue scale:(float) scaleValue
{
	if( (self=[super init] ))
	{
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
		[bg release];
		
		CGSize s = [self.texture contentSize];
		
		text = [CCLabel labelWithString:labelText fontName:labelFont fontSize:labelSize];
		text.position = ccp( s.width / 2 + offsetXValue , s.height / 2 + offsetYValue );
		text.color = labelColor;
		[self addChild:text];
		
		targetCallBack = [targetValue retain];
		selector = handler;
		
		pri = priorityValue;
	}
	
	defaultScale = scaleValue;
	self.scale = scaleValue;
	return self;
}

-(void) dealloc
{
	[targetCallBack release];
	[super dealloc];
}

-(void) setLabel:(NSString*) labelValue
{
	[text setString: labelValue];
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:pri swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] || !self.visible ) 
		return NO;
	NSLog(@"touch began");
	self.scale = defaultScale * 1.3;
	
//	CCLabel* labelFeedBtnName = [CCLabel labelWithString:@"喂食" fontName:@"Marker Felt" fontSize:40];
//	labelFeedBtnName.position = ccp(200, 100);
//	[self addChild:labelFeedBtnName z:1000 tag:1000];
	
	return YES;
}

//-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//	if ( ![self containsTouchLocation:touch] || !self.visible )
//	{
//		[text setString:@"HHHHHHHHHHHHHHH"];
//	}
//}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.scale = defaultScale;
	if (selector != nil && [self containsTouchLocation:touch])
	{
		[targetCallBack performSelector:selector withObject:self];
	}
}

@end
