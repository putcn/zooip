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


@implementation FriendMangePanel

@synthesize title;

-(id) init
{
	if ((self = [super init])) {
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabEnable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton2.png" ofType:nil] ] ];
		tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton1.png" ofType:nil] ] ];
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ManageContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.position = ccp(240,160);
		self.scale = 300.0f/1024.0f;
		self.title = @"朋友信息";
		[self addTitle];
	

		FriendList *friendContainer = [[FriendList alloc] initWithTab:self];
		
		friendContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
		
		[self addChild:friendContainer z:7];
			
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:50];
		transBackground.scale = 17.0f;
		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
		[self addChild:transBackground z:-1];
		
	}
	return self;
}

//设置标题
-(void)addTitle
{
	NSLog(@"%@",title);
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}




-(void) gotoFriendHandler:(FriendInfoBut *) friendButton
{
	
	NSLog(@"oooooooooooooooo   friendFarmId  oooooooooooooooooooo   %@",friendButton.friendFarmId);
	NSLog(@"ooooooooooooooooo   friendFarmerId      oooooooooooooo    %@",friendButton.friendFarmerId);
	NSLog(@"ooooooooooooooooooooooooooooooooooooooooo");
	NSLog(@"ooooooooooooooooooooooooooooooooooooooooo");
	
	
};

-(void) dealloc
{
		
	[tabContentDic release];
	[itemInfoPane release];
	[tabDisable release];
	[tabEnable release];
	[tabDic release];
	[super dealloc];
}

@end



