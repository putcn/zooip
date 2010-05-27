//
//  ItemButton.m
//  zoo
//
//  Created by Rainbow on 5/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ItemButton.h"


@implementation ItemButton
@synthesize itemId,itemType;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setImagePath:(NSString*) imagePath setBuyType:(int) buyType setPrice:(NSString *) price setTarget:(id) target setSelector:(SEL) handler
	   setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	if( (self=[super init] ))
	{
		itemId = itId;
		itemType = itType;
		CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"itemButtonBack.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = itemImg.contentSize;
		[self setTexture: itemImg];
		[self setTextureRect: rect];
		[itemImg release];
		targetCallBack = [target retain];
		selector = handler;
		pri = priorityValue;
		[self setImg:imagePath setBuyType:buyType setPrice:price];
	}
	self.scale = 1.5f;
	return self;
}

-(void) setImg: (NSString *) imagePath setBuyType: (int) buyType setPrice:(NSString *) price
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	[itemImg release];
	CCSprite *buyImg;
	if (buyType == 0) {
		buyImg = [CCSprite spriteWithFile:@"goldegg.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"goldant.png"];
	}
	CCLabel *priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(self.contentSize.width/2, self.contentSize.height - item.contentSize.height /2);
	buyImg.position = ccp(buyImg.contentSize.width/2 +20, self.contentSize.height - 80);
	priceLbl.position = ccp(buyImg.contentSize.width + 50 , buyImg.position.y);
	
	[self addChild:item z:7];
	[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
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
	if ( ![self containsTouchLocation:touch] || !self.visible ) return NO;
	self.scale = 1.8f;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.scale = 1.5f;
	if (selector != nil && [self containsTouchLocation:touch])
	{
		[targetCallBack performSelector:selector withObject:self];
	}
}

-(void) dealloc
{
	[targetCallBack release];
	[super dealloc];
}


@end
