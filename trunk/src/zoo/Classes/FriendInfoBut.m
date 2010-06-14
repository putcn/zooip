//
//  FriendInfoBut.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendInfoBut.h"


@implementation FriendInfoBut

@synthesize friendFarmId, friendFarmerId,fId;


-(id) initFirendInfo:(NSString *)farmId setFarmerId:(NSString *)farmerid  setFriendId:(NSString *)friendId 
		setFriendName:(NSString *)friendName setFirendIco:(NSString*) friendIco setExperience:(int) experience  
		setTarget:(id) target setSelector:(SEL) handler setPriority:(int) priorityValue 
		offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	if( (self=[super init] ))
	{
		friendFarmId   = farmId;
		friendFarmerId = farmerid;
		
		CCTexture2D *bgImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"itemButtonBack.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bgImg.contentSize;
		[self setTexture: bgImg];
		[self setTextureRect: rect];
		[bgImg release];
		targetCallBack = [target retain];
		selector = handler;
		pri = priorityValue;
		
		//[self setImg:imagePath setBuyType:buyType setPrice:price];
	}
	self.scale = 1.5f;
	return self;
}


//设置好友的头像，姓名，经验值
-(void) setFriendIco: (NSString *) icoPath setFriendName: (NSString *) friendName setExperience:(int) exprience;
{
	CCSprite *icoNode = [CCSprite node];
	CCTexture2D *icoImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:icoPath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = icoImg.contentSize;
	[icoNode setTexture: icoImg];
	[icoNode setTextureRect: rect];
	[icoImg release];
	
	CCLabel *friendNameLab = [CCLabel labelWithString:friendName fontName:@"Arial" fontSize:20];
	[friendNameLab setColor:ccc3(255, 0, 255)];
	
	icoNode.position = ccp(self.contentSize.width/2, self.contentSize.height - icoNode.contentSize.height /2);
	
	friendNameLab.position = ccp(50 , self.contentSize.height - 80);
	
	[self addChild:icoNode z:7];
	[self addChild:friendNameLab z:7];
	
	
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

