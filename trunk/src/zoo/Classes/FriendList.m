//
//  FriendList.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendList.h"


@implementation FriendList

-(id) initWithTab:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_ButtonContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
		[bg release];

				
		
		[self generatePage];
		
		//实现翻页按钮
		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(nextPage:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		forwardPageBtn.flipX = YES;
		nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 0);
		forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 0);
		[self addChild:nextPageBtn z:7];
		[self addChild:forwardPageBtn z:7];
	}
	return self;
}


-(void) nextPage:(Button *)button
{
	if ( currentPageNum + 1 <= totalPage) {
		for (int i = 0; i< currentNum; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum + 1;
		
		[self generatePage];
	}
}

-(void) forwardPage:(Button *)button
{
	if (currentPageNum - 1 > 0) {
		for (int i = 0; i< currentNum; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum - 1;
		
		[self generatePage];
	}
}


-(void) generatePage
{
	
	
	NSDictionary *friendInfoDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].friendInfos;
	
	DataModelFriendInfo *dataModelfriend;
	
	NSArray *friendsInfoArray =  [friendInfoDic allKeys];
	
	
	

		int endNumber = currentPageNum * 4;
		if (endNumber >= friendsInfoArray.count) {
			endNumber = friendsInfoArray.count;
		}
	
		currentNum = endNumber - (currentPageNum -1 ) *4 ;
	
	
	
	
	NSArray *friendInfoArray = [friendInfoDic allValues];
	
	NSArray *sortedFriendInfoArray = [friendInfoArray sortedArrayUsingFunction:compareFriendArrayExpSelector context:nil];
	
	
	//for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
	
	for (int i=0; i< friendsInfoArray.count; i++) {
		
		dataModelfriend = [sortedFriendInfoArray objectAtIndex:i];
			//生成朋友列表
		//头像
		FriendInfoBut *friendIcoButton = [[FriendInfoBut alloc] initFirendInfo:dataModelfriend.farmId setFarmerId:dataModelfriend.farmerId  setFriendId:dataModelfriend.uid setFriendName:dataModelfriend.userName 
															   setFirendIcoUrl:dataModelfriend.tinyurl setExperience:dataModelfriend.experience setTarget:parentTarget setSelector:@selector(gotoFriendHandler:) 
															    setPriority:49 offsetX:1 offsetY:1];	
		
		friendIcoButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 120* ((i-4*(currentPageNum-1))/4) - 50);
		[self addChild:friendIcoButton z:7 tag:i%4];
		
		
		
	}
	
		
	
}

NSInteger compareFriendArrayExpSelector(id f1, id f2, void *context)
{
	int e1 = [(DataModelFriendInfo *)f1 experience];
    int e2 = [(DataModelFriendInfo *)f2 experience];
    if (e1 < e2)
	{
		return NSOrderedDescending;
	}
    else if (e1 > e2)
	{
		return NSOrderedAscending;
	}
    else
	{
		return NSOrderedSame;
	}
}


-(void) dealloc
{
	[parentTarget release];
	[super dealloc];
}




@end
