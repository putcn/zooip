//
//  ZooManageToolbar.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZooManageToolbar.h"


@implementation ZooManageToolbar

-(id) init
{
	self = [super init];
	
	if (self)
	{
		selectIndex = 0;
		
		playerButtonContainer = [[CCSprite alloc] init];
		[self addChild:playerButtonContainer];
		playerButtonContainer.position = ccp(-400, playerButtonContainer.position.y);
		
		friendButtonContainer = [[CCSprite alloc] init];
		[self addChild:friendButtonContainer];
		friendButtonContainer.position = ccp(-400, friendButtonContainer.position.y);
		
		[self addStatusIconTexture];
		[self addButton];
		
		statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"" setTarget:self
									   setSelector:@selector(btnStatusIconHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
		statusIcon.position = ccp(20, 20);
		[statusIcon setVisible:YES];
		
		CCTexture2D *bg = [playerStatusIconTextures objectAtIndex:selectIndex];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[statusIcon setTexture:bg];
		[statusIcon setTextureRect: rect];
		
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
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(20, 20);
	button.tag = OPERATION_DEFAULT;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//喂食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"饲料.png" setTarget:self
							   setSelector:@selector(btnFeedButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(55, 20);
	//button.tag = 1;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//收蛋
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"拾取.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(90, 20);
	button.tag = OPERATION_PICK_EGG;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//添加动物
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"鸟窝.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(125, 20);
	//button.tag = 3;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//动物管理
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"动物管理.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(160, 20);
	//button.tag = 4;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//扩容
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"扩容.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(195, 20);
	//button.tag = 5;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//治疗
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"医疗.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(230, 20);
	button.tag = OPERATION_CURE_ANIMAL;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//消灭蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"杀虫剂.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(265, 20);
	button.tag = OPERATION_KILL_ANTS;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//捕蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"网.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(300, 20);
	button.tag = OPERATION_KILL_SNAKE;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//除便
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"清扫.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(335, 20);
	button.tag = OPERATION_CLEAR_DEJECTA;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//吃食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"召唤.png" setTarget:self
							   setSelector:@selector(btnPlayerOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(370, 20);
	button.tag = OPERATION_CALL;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	//Friend
	//////////////////////////////////////////////////////////////////////////////////////
	//拖拽
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"箭头.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(20, 20);
	button.tag = OPERATION_DEFAULT;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"蛇.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(55, 20);
	button.tag = OPERATION_RELEASE_SNAKE;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"蚂蚁.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(90, 20);
	button.tag = OPERATION_RELEASE_ANTS;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//放炮
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"炮竹.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(125, 20);
	button.tag = OPERATION_THROW_FIREWORK;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//偷蛋
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"拾取.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(160, 20);
	button.tag = OPERATION_STEAL_EGG;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//治疗
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"医疗.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(195, 20);
	button.tag = OPERATION_CURE_ANIMAL;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//消灭蚂蚁
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"杀虫剂.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(230, 20);
	button.tag = OPERATION_KILL_ANTS;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//捕蛇
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"网.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(265, 20);
	button.tag = OPERATION_KILL_SNAKE;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//除便
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"清扫.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(300, 20);
	button.tag = OPERATION_CLEAR_DEJECTA;
	[friendButtonContainer addChild: button];
	[friendOperationButtons addObject:button];
	
	//吃食
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"召唤.png" setTarget:self
							   setSelector:@selector(btnFriendOperationButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(335, 20);
	button.tag = OPERATION_FEED_ALL;
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
	
	if ([self.parent getIsSelf])
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

-(void) btnPlayerOperationButtonHandler:(Button *)button
{
	[[UIController sharedUIController] switchOperation:button.tag];
	
	selectIndex = [playerOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

-(void) btnFriendOperationButtonHandler:(Button *)button
{
	selectIndex = [friendOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[friendButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

-(void) btnFeedButtonHandler:(Button *)button
{
	
}

-(void) spriteMoveOutFinished
{
	[self setStatusIcon:selectIndex];
}

-(void) btnStatusIconHandler
{
	[statusIcon setVisible:NO];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(0, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveInFinished)];
	
	id ease = [CCEaseBackOut actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	if ([self.parent getIsSelf])
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

@end
