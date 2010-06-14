//
//  AnimalStorageManagerButtonItem.m
//  zoo
//
//  Created by Alex Liu on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalStorageManagerButtonItem.h"


@implementation AnimalStorageManagerButtonItem

@synthesize itemId,itemType,storageID;

-(id) initWithItems:(NSString *)itId setitType:(NSString *)itType setAmount:(NSInteger) Amount setGender:(NSString *)gender setAnimalID:(NSString *)animalIDP setImagePath:(NSString*) imagePath setAnimalName:(NSString *) animalName setTarget:(id) target setSelector:(SEL) handler
	   setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	if( (self=[super init] ))
	{
		itemId = itId;
		itemType = itType;
		storageID = animalIDP;
		amount = Amount;
		genDer = gender;
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
	
	//****[animalNameLable setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(self.contentSize.width/2, self.contentSize.height - item.contentSize.height /2);
	[self addChild:item z:7];
	//[self addChild:animalNameLable z:7];
	
	//存储的是仓库里面动物的数量
	CCLabel *buyImg;
	if (itemType == @"stoAnimals") {
		buyImg = [CCLabel labelWithString:[NSString stringWithFormat: @"%d", amount] fontName:@"Arial" fontSize:20];
	}
	else {
		buyImg = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:20];
	}
	
	//数量的显示颜色
	[buyImg setColor:ccc3(255, 0, 255)];
	
	
	//动物Gender 字体和显示颜色
	CCLabel *priceLbl = [CCLabel labelWithString:genDer fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	if (itemType == @"animal") {
		if ([itemId intValue] >= 50) {
			item.flipX = YES;
		}
	}
	//设置位置
	buyImg.position = ccp(buyImg.contentSize.width +30, buyImg.contentSize.width + 20);
	priceLbl.position = ccp(buyImg.contentSize.width + 50 , buyImg.position.y);
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
	[itemId release];
	[itemType release];
	[storageID release];
	
	[genDer release];
	[targetCallBack release];
	[super dealloc];
}


@end