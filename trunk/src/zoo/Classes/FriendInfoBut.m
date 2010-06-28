//
//  FriendInfoBut.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendInfoBut.h"


@implementation FriendInfoBut

@synthesize friendFarmId, friendFarmerId,uId,friendNames,icoUrl;

-(id) initFirendInfo:(NSString *)farmId setFarmerId:(NSString *)farmerid  setFriendId:(NSString *)friendId 
		setFriendName:(NSString *)friendName setFirendIcoUrl:(NSString*) friendIcoUrl setExperience:(int) experience  
		setTarget:(id) target setSelector:(SEL) handler setPriority:(int) priorityValue 
		offsetX:(int) offsetXValue offsetY:(int) offsetYValue
{
	//单个头像信息
	if( (self=[super init] ))
	{
		friendFarmId   = farmId;
		friendFarmerId = farmerid;
		uId = friendId;
		icoUrl = friendIcoUrl;
		
		CCTexture2D *bgImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"friendIcoRim.png" ofType:nil] ] ];
		
		CGRect rect = CGRectZero;
		rect.size = bgImg.contentSize;
		[self setTexture: bgImg];
		[self setTextureRect: rect];
		[bgImg release];
		targetCallBack = [target retain];
		selector = handler;
		pri = priorityValue;
		
		
		[ self setFriendIco:icoUrl setFriendName:friendName  setExperience:experience];
	}
	//self.scale = 1.5f;
	return self;
}


//设置好友的头像，姓名，经验值
-(void) setFriendIco: (NSString *) icoPath setFriendName: (NSString *) friendName setExperience:(int) exprience;
{
	
	if (icoPath == nil) {
		icoPath = @"http://www.cocoqq.com/upimg/090128/12331420cO3Z555Z1.gif";
	}
	NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: icoPath]];
	
	if (imageData == nil) {
		

		imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://www.cocoqq.com/upimg/090128/12331420cO3Z555Z1.gif"]];
		
	}
	
	
	CCSprite *icoNode = [CCSprite node];
	
	CCTexture2D *icoImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithData:imageData ] ];
	
	CGRect rect = CGRectZero;
	rect.size = icoImg.contentSize;
	[icoNode setTexture: icoImg];
	[icoNode setTextureRect: rect];
	[icoImg release];
	[imageData release];
	
		
	NSString *friendInfoStr = [NSString stringWithFormat:@"%@ ",friendName];
	CCLabel *friendNameLab = [CCLabel labelWithString:friendInfoStr fontName:@"Arial" fontSize:12];
	[friendNameLab setColor:ccc3(255, 0, 255)];
	
	icoNode.position = ccp(self.contentSize.width/2, self.contentSize.height - icoNode.contentSize.height /2);
	icoNode.scale = 40/(icoImg.contentSize.width);
	friendNameLab.position = ccp(35 , self.contentSize.height - 60);
	
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
	//self.scale = 1.8f;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	//self.scale = 1.5f;
	if (selector != nil && [self containsTouchLocation:touch])
	{
		[targetCallBack performSelector:selector withObject:self];
	}
}

-(void) dealloc
{
	
	[friendFarmId   release];
	[friendFarmerId release];
	[uId            release];
	[friendNames    release];
	[icoUrl         release];
	[targetCallBack release];
	[super dealloc];
}




@end

