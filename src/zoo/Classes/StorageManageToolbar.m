//
//  StorageManageToolbar.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StorageManageToolbar.h"
#import "GameMainScene.h"

@implementation StorageManageToolbar

-(id) init
{
	self = [super init];
	
	if (self)
	{
		[self addButton];
	}
	
	return self;
}

- (void) addButton
{
	Button *button;
	
	//我的动物园
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"我的动物园.png" setTarget:self
							   setSelector:@selector(switchPlayerZoo) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(20, 20);
	[self addChild: button z:50];
	
	//商店
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"购物车.png" setTarget:self
							   setSelector:@selector(btnShopButtonHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(62, 22);
	[self addChild: button z:50];
	
	//产品仓库
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"我的蛋窝.png" setTarget:self
							   setSelector:@selector(btnStorageButtonHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(100, 20);
	[self addChild: button z:50];
}

-(void) switchPlayerZoo
{
	[[GameMainScene sharedGameMainScene] switchZoo:YES uid:nil];
}

-(void) btnShopButtonHandler
{
	if (manageContainer == nil) {
		manageContainer = [[ManageContainer alloc] init];
		manageContainer.position = ccp(240,160);
		[[GameMainScene sharedGameMainScene] addDialogToScreen:manageContainer z:10];
	}
	else {
		if (manageContainer.position.x == 240) {
			manageContainer.position = ccp(1000,0);
		}
		else {
			manageContainer.position = ccp(240,160);
		}

	}

}

-(void) btnStorageButtonHandler
{
	//storageContainer
	
	
	
	if (storageContainer == nil) {
		storageContainer = [[StorageContainer alloc] init];
		storageContainer.position = ccp(240,160);
		[[GameMainScene sharedGameMainScene] addDialogToScreen:storageContainer z:10];
	}
	else {
		
	
		if (storageContainer.position.x == 240) {
			storageContainer.scale = 0;
			storageContainer = [[StorageContainer alloc] init];
			storageContainer.position = ccp(1000,0);
			[[GameMainScene sharedGameMainScene] addDialogToScreen:storageContainer z:10];
			
		}
		else {
			storageContainer.position = ccp(240,160);
		}
		
		
	}
	
	
	
}

@end
