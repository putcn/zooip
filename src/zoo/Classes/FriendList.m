//
//  FriendList.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendList.h"
#import "zooAppDelegate.h"
#import "GetFriendsInfoController.h"
#import "FriendMangePanel.h"
@implementation FriendList

-(id) initWithTab:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
		
		currentPageNum = 1;
		result = nil;
		[self generatePage];
		
		//实现翻页按钮
		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(nextPage:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
//		forwardPageBtn.flipX = YES;
		nextPageBtn.position = ccp(300, -160);
		forwardPageBtn.position = ccp(200, -160);
		[self addChild:nextPageBtn z:8];
		[self addChild:forwardPageBtn z:8];
		[nextPageBtn release];
		[forwardPageBtn release];
		
		//搜索框
//		Button *search_bg = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"搜索_bg.png" setTarget:self setSelector:@selector(UseTextFieldView:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
		CCSprite *search_bg = [CCSprite spriteWithFile:@"搜索_bg.png"];
		search_bg.position = ccp(20, -160);		
		[self addChild:search_bg z:8];
		
		//搜索按钮
		Button *searchBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"搜索_弹起.png" setTarget:self setSelector:@selector(searchDown:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
		searchBtn.position = ccp(90, -160);
		[self addChild:searchBtn z:8];
		[searchBtn release];
		
//		zooAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//		[delegate UseTextFieldView];
		[self UseTextFieldView];
		
		NSString* title = [NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage];
		pageLabel = [CCLabel labelWithString:title fontName:@"Arial" fontSize:20];
		[pageLabel setColor:ccc3(0, 0, 0)];
		pageLabel.position = ccp(250,-160);
		[self addChild:pageLabel z:7];
		nStatus = 2;
		
	}
	return self;
}

-(void)UseTextFieldView
{
	_view = [[UIView alloc] initWithFrame:CGRectMake(8,  111, 119, 25)];
	[_view setBackgroundColor: [UIColor clearColor]];
	
	_view.tag = 9900;

	levelEntryTextField = [[UITextField alloc] initWithFrame:
						   CGRectMake(0,  0, 119, 25)];
//	[levelEntryTextField setBackgroundColor: [UIColor yellowColor]];
	[levelEntryTextField setDelegate:self];

    [_view addSubview:levelEntryTextField];
	_view.transform = CGAffineTransformMakeRotation(M_PI * (90.0 / 180.0));
	[[[CCDirector sharedDirector] openGLView] addSubview:_view];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[(FriendMangePanel*)parentTarget setPosition: ccp(-200,220)];	
	_view.frame=CGRectMake(175,  45, 25, 119);
	nStatus = 1;

}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
	[textField resignFirstResponder];
	
	[(FriendMangePanel*)parentTarget setPosition: ccp(-180,100)];
	_view.frame=CGRectMake(55,  65, 25, 119);
	nStatus = 2;
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    if (textField==levelEntryTextField) {
        [levelEntryTextField endEditing:YES];
		result = levelEntryTextField.text;
    }
}

-(int ) getStatus
{
	return nStatus;
}

-(void) searchDown:(Button *)button
{
	searchDown = TRUE;
	for (int i = 0; i< 5; i ++) {
		[self removeChildByTag:i cleanup:YES];
	}
	[self generatePage];
	
}


-(void) nextPage:(Button *)button
{
	if ( currentPageNum + 1 <= totalPage) {
		for (int i = 0; i< currentNum; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum + 1;		
		[self generatePage];
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
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
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
	}
}


-(void) generatePage
{
	NSDictionary *friendInfoDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].friendInfos;
	DataModelFriendInfo *dataModelfriend;	
	NSArray *friendsInfoArray =  [friendInfoDic allKeys];
	
	//==================
	if(friendsInfoArray.count == 0)
	{
		totalPage = 1;
	}
	else
	{
		totalPage = (friendsInfoArray.count-1)/5 + 1;
	}
	
	int endNumber = currentPageNum * 5;
	if (endNumber >= friendsInfoArray.count) {
		endNumber = friendsInfoArray.count;
	}
	currentNum = endNumber - (currentPageNum -1 ) *5 ;
	
	//=====================
	
	NSArray *friendInfoArray = [friendInfoDic allValues];
	
	NSArray *sortedFriendInfoArray = [friendInfoArray sortedArrayUsingFunction:compareFriendArrayExpSelector context:nil];
	int nTemp = 0;
	if(searchDown == TRUE && result.length != 0)
	{
		for (int i = 0; i < friendsInfoArray.count; i ++) {			
			dataModelfriend = [sortedFriendInfoArray objectAtIndex:i];
			//生成朋友列表
			//头像
			FriendInfoBut *friendIcoButton = [[FriendInfoBut alloc] initFirendInfo:dataModelfriend.farmId setFarmerId:dataModelfriend.farmerId  setFriendId:dataModelfriend.uid setFriendName:dataModelfriend.userName 
																   setFirendIcoUrl:dataModelfriend.tinyurl setExperience:dataModelfriend.experience setTarget:parentTarget setSelector:@selector(gotoFriendHandler:) 
																	   setPriority:40 offsetX:1 offsetY:1];				
			//头像坐标、翻页
			if([dataModelfriend.userName isEqualToString:result])
			{
				friendIcoButton.position = ccp(20 +(nTemp%5)*70, -110);
				[self addChild:friendIcoButton z:7 tag:nTemp%5];
				nTemp ++;
			}	
		}
	}
	else 
	{
		for (int i = (currentPageNum -1)*5; i < endNumber; i ++) {	
		dataModelfriend = [sortedFriendInfoArray objectAtIndex:i];
		//生成朋友列表
		//头像
		FriendInfoBut *friendIcoButton = [[FriendInfoBut alloc] initFirendInfo:dataModelfriend.farmId setFarmerId:dataModelfriend.farmerId  setFriendId:dataModelfriend.uid setFriendName:dataModelfriend.userName 
															   setFirendIcoUrl:dataModelfriend.tinyurl setExperience:dataModelfriend.experience setTarget:parentTarget setSelector:@selector(gotoFriendHandler:) 
																   setPriority:40 offsetX:1 offsetY:1];	
		
		//头像坐标、翻页
		friendIcoButton.position = ccp(20 +(i%5)*70, -110);
		[self addChild:friendIcoButton z:7 tag:i%5];
		}
	}
	//for (int i=0; i< friendsInfoArray.count; i++) {
	
	
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
	// Add by Hunk on 2010-06-29
//	[friendListArray release];
//	[levelEntryTextField removeFromSuperview];
//	[parentTarget release];
	[super dealloc];
}




@end
