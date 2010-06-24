//
//  FriendMangePanel.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendMangePanel.h"

#import "Button.h"
#import "FeedbackDialog.h"
#import "GameMainScene.h"
#import "FriendsToolbar.h"


@implementation FriendMangePanel

@synthesize title;
@synthesize scaleFlag;

-(id) init
{
	if ((self = [super init])) {
		
		//背景
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bg_friend.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		self.position = ccp(-180,100);
		[bg release];
		 
		
		//动物园logo
		CCSprite *logo = [CCSprite spriteWithFile:@"LOGO.png"];
		logo.position = ccp(200,145);
		[self addChild:logo z:7];
		
		
	
		friendContainer = [[FriendList alloc] initWithTab:self];
		friendContainer.position = ccp(50, 190);
		[self addChild:friendContainer z:7];
			
		
		
		Button *exitButton = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"exitButton.png" setTarget:self setSelector:@selector(exitHandler:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		exitButton.position = ccp(400, 135);
		[self addChild:exitButton z:7];
		
		
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:45];
		transBackground.scale = 17.0f;
		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
		[self addChild:transBackground z:-1];
		
		
	}
	return self;
}




-(void) gotoFriendHandler:(FriendInfoBut *) friendButton
{
	
	[[GameMainScene sharedGameMainScene] switchZoo:friendButton.uId];
	
	self.position = ccp(-2000,100);
	
};




-(void) exitHandler:(Button *)button
{
	
	[self disableFriendView];
	
}


-(void) disableFriendView
{
	self.position = ccp(-2000,100);
}





/*

-(void)popUpHandler
{
	friendView.scale = 0.1f;
	id actionScaling = [CCScaleTo actionWithDuration:0.6  scale:300.0f/1024.0f];
	
	id ease = [CCEaseBackOut actionWithAction: actionScaling];
	[ease setDuration:0.3];
	
	[friendView runAction:ease];
}


*/




-(void) resetPostion
{
	if (self.position.x == -180) {
		self.position = ccp(-2000,100);
	}else {
		
		self.position = ccp(-180,100);
	}

	

}




-(void) dealloc
{
		
	[title           release];
	[friendContainer release];
	[itemInfoPane    release];
	[scaleFlag       release];
	[tabContentDic   release];
	[itemInfoPane    release];
	[tabDisable      release];
	[tabEnable       release];
	[tabDic          release];
	[super dealloc];
}

@end



