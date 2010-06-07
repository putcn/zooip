//
//  AnimalManagementButtonItem.m
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalManagementButtonItem.h"


@implementation AnimalManagementButtonItem

@synthesize itemId,itemType,animalID;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setAnimalID:(NSString *)animalIDP setImagePath:(NSString*) imagePath setAnimalName:(NSString *) animalName setTarget:(id) target setSelector:(SEL) handler
setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	if( (self=[super init] ))
	{
		itemId = itId;
		itemType = itType;
		animalID = animalIDP;
		CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"itemButtonBack.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = itemImg.contentSize;
		[self setTexture: itemImg];
		[self setTextureRect: rect];
		[itemImg release];
		targetCallBack = [target retain];
		selector = handler;
		pri = priorityValue;

		[self setImg:imagePath setName:animalName];
	}
	self.scale = 1.5f;
	return self;
}

-(void) setImg: (NSString *) imagePath setName:(NSString *) animalName
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	[itemImg release];

	CCLabel *animalNameLable = [CCLabel labelWithString:animalName fontName:@"Arial" fontSize:20];
	[animalNameLable setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(self.contentSize.width/2, self.contentSize.height - item.contentSize.height /2);
	
	[self addChild:item z:7];
	//TODO: add name and gender image
	//***[self addChild:animalNameLable z:7];
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

