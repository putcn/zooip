//
//  ItemButton.m
//  zoo
//
//  Created by Rainbow on 5/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ItemButton.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"


@implementation ItemButton
@synthesize itemId,itemType;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setImagePath:(NSString*) imagePath setBuyType:(int) buyType setPrice:(NSString *) price setTarget:(id) target setSelector:(SEL) handler
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
		[self setImg:imagePath setBuyType:buyType setPrice:price];
	}
	self.scale = 2.8f;
	return self;
}


//根据商品的图片名称,买入类型,价格生成商品的图标
-(void) setImg: (NSString *) imagePath setBuyType: (int) buyType setPrice:(NSString *) price
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	if (buyType != 0) {
		[item setFlipX:YES];
	};
	item.scale = 0.7;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	[itemImg release];
	CCSprite *buyImg;
	if (buyType == 0) {
		buyImg = [CCSprite spriteWithFile:@"金蛋ico.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
	}
	buyImg.scale = 0.7f;
	CCLabel *priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:22];
	[priceLbl setColor:ccc3(0, 0, 0)];
	if (itemType == @"animal") {
		if ([itemId intValue] >= 50) {
			item.flipX = YES;
		}
	}
	priceLbl.scale = 0.7;
	item.position = ccp(self.contentSize.width/2, self.contentSize.height - item.contentSize.height /2);
	buyImg.position = ccp(buyImg.contentSize.width/2 +5, self.contentSize.height - 60);
	priceLbl.position = ccp(buyImg.contentSize.width + 30 , buyImg.position.y);
	
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
	// Add by Hunk on 2010-06-29
	[itemId release];
	[itemType release];
	
	[targetCallBack release];
	[super dealloc];
}


@end
