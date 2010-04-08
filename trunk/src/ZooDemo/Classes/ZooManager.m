//
//  ZooManager.m
//  ZooDemo
//
//  Created by Gu Lei on 10-4-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZooManager.h"


@implementation ZooManager

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
							   setSelector:nil setPriority:0 offsetX:-1 offsetY:2];
	button.position = ccp(20, 20);
	[self addChild: button];
	
	//商店
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"购物车.png" setTarget:self
							   setSelector:@selector(btnButtonHandler) setPriority:0 offsetX:-1 offsetY:2];
	button.position = ccp(62, 22);
	[self addChild: button];
	
	//产品仓库
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"我的蛋窝.png" setTarget:self
							   setSelector:nil setPriority:0 offsetX:-1 offsetY:2];
	button.position = ccp(100, 20);
	[self addChild: button];
}

-(void) btnButtonHandler
{
	[self.parent popupShopList];
}

@end
