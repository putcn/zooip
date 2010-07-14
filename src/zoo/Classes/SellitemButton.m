//
//  SellitemButton.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SellitemButton.h"


@implementation SellitemButton

@synthesize itemId,itemType;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setImagePath:(NSString*) imagePath setEggTotal:(NSString*) eggTotal setEggName:(NSString *) eggName setTarget:(id) target setSelector:(SEL) handler
	   setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	if( (self=[super init] ))
	{
		itemId = itId;
		itemType = itType;
		CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"物品边框.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = itemImg.contentSize;
		[self setTexture: itemImg];
		[self setTextureRect: rect];
		[itemImg release];
		
		targetCallBack = [target retain];
		selector = handler;
		pri = priorityValue;
		
		
		[self setImg:imagePath setEggTotal:eggTotal setEggName:eggName];
	}
	self.scale = 2.8f;
	return self;
}


-(void) setImg: (NSString *) imagePath setEggTotal: (NSString*) eggTotal setEggName:(NSString *) eggName
{
	item = [CCSprite node];
	itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	item.scale = 0.7;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	[itemImg release];
	
	CCLabel *eggNameLbl = [CCLabel labelWithString:eggName fontName:@"Arial" fontSize:20];
	CCLabel *eggTotalLab = [CCLabel labelWithString:eggTotal fontName:@"Arial" fontSize:20];

	[eggNameLbl  setColor:ccc3(0, 0, 0)];
	[eggTotalLab setColor:ccc3(0, 0, 0)];
	
	item.position = ccp(self.contentSize.width/2, self.contentSize.height - item.contentSize.height /2);
	
	eggNameLbl .position = ccp(25 , self.contentSize.height - 60);
	eggTotalLab.position = ccp(eggNameLbl.position.x + 30 , self.contentSize.height - 60);
	eggNameLbl.scale = 0.7;
	eggTotalLab.scale = 0.7;
	[self addChild:item z:7];
	
	[self addChild:eggNameLbl z:7];
	[self addChild:eggTotalLab z:7];
	
}


-(void)upData
{
	item.scale = 0;
	[self removeChild: item cleanup:YES];
	[item release];
	
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
//	self.scale += 1.0f;
	if ( ![self containsTouchLocation:touch] || !self.visible ) return NO;
	
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//	self.scale -= 1.0f;
	if (selector != nil && [self containsTouchLocation:touch])
	{
		[targetCallBack performSelector:selector withObject:self];
	}
}

-(void) dealloc
{
	
	[itemId         release];
	[itemType       release];
	[item           release];
	[itemImg        release];
	[targetCallBack release];
	[super dealloc];
}


@end