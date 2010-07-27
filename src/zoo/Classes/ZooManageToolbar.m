//
//  ZooManageToolbar.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZooManageToolbar.h"
#import "GameMainScene.h"
#import "ModelLocator.h"
#import "AnimalExpansionPanel.h"
#import "FeedbackDialog.h"

@implementation ZooManageToolbar

-(id) init
{
	self = [super init];
	
	if (self)
	{
		selectIndex = 0;
		secondTouchAniManagement = NO;
		secondTouchFarmExpansion = NO;
		secondTouchFarmStorage = NO;
		
		playerButtonContainer = [[CCSprite alloc] init];
		[self addChild:playerButtonContainer];
		playerButtonContainer.position = ccp(-400, playerButtonContainer.position.y);
		
		friendButtonContainer = [[CCSprite alloc] init];
		[self addChild:friendButtonContainer];
		friendButtonContainer.position = ccp(-400, friendButtonContainer.position.y);
		
		[self addStatusIconTexture];
		[self addButton];
		
		statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"" setTarget:self
									   setSelector:@selector(btnStatusIconHandler) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
		statusIcon.position = ccp(20, 20);
		[statusIcon setVisible:YES];
		
		CCTexture2D *bg = [playerStatusIconTextures objectAtIndex:selectIndex];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[statusIcon setTexture:bg];
		[statusIcon setTextureRect: rect];
		[bg release];
		[self addChild:statusIcon];
	}
	
	return self;
}

- (void) addButton
{
	playerOperationButtons = [[NSMutableArray alloc] init];
	friendOperationButtons = [[NSMutableArray alloc] init];
	
	Button *button;
	
	//////////////////////////////////////////////////////////////////////////
	//Player
	//////////////////////////////////////////////////////////////////////////
	//拖拽
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"箭头.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(20, 20);
	button.tag = OPERATION_DEFAULT;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//喂食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"饲料.png" setTarget:self
							   setSelector:@selector(btnFeedButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(55, 20);
	//button.tag = 1;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//收蛋
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"拾取.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(90, 20);
	button.tag = OPERATION_PICK_EGG;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//添加动物
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"鸟窝.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationAddAnimalsButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(125, 20);
	//button.tag = 3;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//动物管理
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"动物管理.png" setTarget:self
							   setSelector:@selector(btnManagementButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(160, 20);
	//button.tag = 4;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//扩容
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"扩容.png" setTarget:self
							   setSelector:@selector(btnFarmExpansionButtionHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(195, 20);
	//button.tag = 5;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//治疗
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"医疗.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(230, 20);
	button.tag = OPERATION_CURE_ANIMAL;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//消灭蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"杀虫剂.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(265, 20);
	button.tag = OPERATION_KILL_ANTS;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//捕蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"网.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(300, 20);
	button.tag = OPERATION_KILL_SNAKE;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//除便
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"清扫.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(335, 20);
	button.tag = OPERATION_CLEAR_DEJECTA;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//吃食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"召唤.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(370, 20);
	button.tag = OPERATION_CALL;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	//Friend
	//////////////////////////////////////////////////////////////////////////////////////
	//拖拽
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"箭头.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(20, 20);
	button.tag = OPERATION_DEFAULT;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"蛇.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(55, 20);
	button.tag = OPERATION_RELEASE_SNAKE;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"蚂蚁.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(90, 20);
	button.tag = OPERATION_RELEASE_ANTS;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放炮
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"炮竹.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(125, 20);
	button.tag = OPERATION_THROW_FIREWORK;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//偷蛋
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"拾取.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(160, 20);
	button.tag = OPERATION_STEAL_EGG;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//治疗
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"医疗.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(195, 20);
	button.tag = OPERATION_CURE_ANIMAL;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//消灭蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"杀虫剂.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(230, 20);
	button.tag = OPERATION_KILL_ANTS;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//捕蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"网.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(265, 20);
	button.tag = OPERATION_KILL_SNAKE;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//除便
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"清扫.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(300, 20);
	button.tag = OPERATION_CLEAR_DEJECTA;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//吃食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"召唤.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:51 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(335, 20);
	button.tag = OPERATION_CALL;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
}

-(void) addStatusIconTexture
{
	playerStatusIconTextures = [[NSMutableArray alloc] initWithCapacity:0];
	
	CCTexture2D *bg;
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"箭头.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"饲料.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"拾取.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"鸟窝.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"动物管理.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"扩容.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"医疗.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"杀虫剂.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"网.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"清扫.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"召唤.png" ofType:nil] ] ];
	[playerStatusIconTextures addObject:bg];
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	friendStatusIconTextures = [[NSMutableArray alloc] initWithCapacity:0];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"箭头.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"蛇.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"蚂蚁.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"炮竹.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"拾取.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"医疗.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"杀虫剂.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"网.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"清扫.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
	
	bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"召唤.png" ofType:nil] ] ];
	[friendStatusIconTextures addObject:bg];
}

-(void) setStatusIcon: (int)index
{
	CCTexture2D *bg;
	
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo])
	{
		bg = [playerStatusIconTextures objectAtIndex:index];
	}
	else
	{
		bg = [friendStatusIconTextures objectAtIndex:index];
	}
	CGRect rect = CGRectZero;
	rect.size = bg.contentSize;
	[statusIcon setTexture:bg];
	[statusIcon setTextureRect: rect];
	
	[statusIcon setVisible:YES];
}
-(void)btnFarmExpansionButtionHandler:(Button *)button
{	
	if(animalExpansionPanel == nil)
	{
		animalExpansionPanel = [[AnimalExpansionPanel alloc] initWithParam:nil setTarget:self];
		[self addChild:animalExpansionPanel];
	}
	else {
		animalExpansionPanel.position = ccp(240,160);
	}

}

-(void) btnPlayerOperationButtonHandler:(Button *)button
{
	if(feed != nil)
	{
		[self removeChild:feed cleanup:NO];
	}
	
	[[UIController sharedUIController] switchOperation:button.tag];
	
	selectIndex = [playerOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

//指定喂食按钮，让其消失
-(void)btnPlayerOperationFeedButtonHandler:(Button *)button
{
	selectIndex = 1;
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinishedFeed)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

-(void)spriteMoveOutFinishedFeed
{
	[self setStatusIcon:selectIndex];
	

//	if (feed != nil) {
//		feed.position = ccp(10000,5000);
//	}
}

-(void) spriteMoveOutFinished
{
	[self setStatusIcon:selectIndex];
	
	if (aniManagementBtnCtrl != nil) {
		aniManagementBtnCtrl.position = ccp(10000,5000);
	}
	if (animalManagerContainer != nil) {
		animalManagerContainer.position = ccp(10000,5000);
	}
	if (animalExpansionPanel != nil) {
		animalExpansionPanel.position = ccp(10000,5000);
	}
}

-(void) btnPlayerOperationAddAnimalsButtonHandler:(Button *)button
{	
	if(animalManagerContainer == nil)
	{
		animalManagerContainer = [[AnimalStorageManagerContainer alloc] init];
		[self addChild:animalManagerContainer];
	}
	else {
		[animalManagerContainer updateStorage];
		animalManagerContainer.position = ccp(240,160);
	}
}

-(void)storageCancle
{
	//animalManagerContainer
}

-(void) btnFriendOperationButtonHandler:(Button *)button
{
	if(feed != nil)
	{
		[self removeChild:feed cleanup:NO];
	}
	[[UIController sharedUIController] switchOperation:button.tag];
	
	selectIndex = [friendOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[friendButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

-(void) btnFeedButtonHandler:(Button *)button
{
	if(!secondTouchFeedButton)
	{
		feed = [[AnimalFeedButtonContainer alloc] initWithTarget:self];
		//aniManagementBtnCtrl .position = ccp(160,40);
		[self addChild:feed];
		
	}
	else {
		[self removeChild:feed cleanup:YES];
	}
	
	secondTouchFeedButton = !secondTouchFeedButton;
	
}

-(void)btnManagementButtonHandler:(Button *)button
{
	if(!secondTouchAniManagement)
	{
		aniManagementBtnCtrl = [[AnimalMangementButtonContainer alloc] init];
		//aniManagementBtnCtrl .position = ccp(160,40);
		[self addChild:aniManagementBtnCtrl];

	}
	else {
		[self removeChild:aniManagementBtnCtrl cleanup:YES];
	}

	secondTouchAniManagement = !secondTouchAniManagement;
}



-(void) btnStatusIconHandler
{
	[statusIcon setVisible:NO];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(0, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveInFinished)];
	
	id ease = [CCEaseBackOut actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo])
	{
		[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
	}
	else
	{
		[friendButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
	}
}

-(void) spriteMoveInFinished
{
	
}

-(void) switchZoo:(Boolean)isSelf
{
	playerButtonContainer.position = ccp(-400, playerButtonContainer.position.y);
	friendButtonContainer.position = ccp(-400, playerButtonContainer.position.y);
	
	[self setStatusIcon:0];
	[statusIcon setVisible:YES];
}

-(void)levelupConfirm:(Button *)button
{
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestexpansionFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackFarmExpand:" AndFailedSel:@"faultCallback:"];
}
-(void)faultCallback:(NSObject *)value
{
	NSLog(@"操作失败!");
}

-(void) resultCallbackFarmExpand:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	
	NSLog(@"%@\n", dic);
	
	switch (code) {
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场不存在"];
			break;
		case 1:
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"扩容成功！"];
			
			// Add by Hunk on 2010-07-12
//			NSInteger goldenEgg = [[dic objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goldenEgg"] intValue];
//			
//			((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg += goldenEgg;
//			
//			[[GameMainScene sharedGameMainScene] updateUserInfo];
		}
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"金蛋余额不足！"];
			break;
		case 3:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"级别不够！"];
			break;
		case 4:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"扩容失败！"];
			break;
		case 5:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"级别不足！"];
			break;
		case 6:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蚂蚁余额不足！"];
			break;		
		case 7:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"上一次操作正在进行！"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
			break;
			
	}
	NSLog(@"操作已成功!");
	animalExpansionPanel.position = ccp(10000,5000);
}


-(void)levelCancle:(Button *)button
{
	animalExpansionPanel.position = ccp(10000,5000);
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[aniManagementBtnCtrl release];
	[animalManagerContainer release];
	[animalExpansionPanel release];
	[feed release];
	[playerStatusIconTextures release];
	[friendStatusIconTextures release];
	[playerOperationButtons release];
	[friendOperationButtons release];
	[playerButtonContainer release];
	[friendButtonContainer release];
	[statusIcon release];
	
	[super dealloc];
}


@end
