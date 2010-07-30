//
//  PurchaseToolbar.m
//  zoo
//
//  Created by shen lancy on 10-7-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PurchaseToolbar.h"
#import "ModelLocator.h"
#import "GameMainScene.h"
#import "DataEnvironment.h"


@implementation PurchaseToolbar

-(id) init
{
	self = [super init];
	
	if (self)
	{
		
		Button *button;
		
		button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"buyant.png" setTarget:self
								   setSelector:@selector(btnButtonHandler) setPriority:50 offsetX:-1 offsetY:2 scale:0.80];
		button.position = ccp(20, 20);
		[self addChild:button];
		[button release];
	}
	
	return self;
}

-(void) btnButtonHandler
{
	
	if (purchaseTable == nil) {
		purchaseTable = [[tableListViewController alloc] initWithNibName:@"tableListViewController" bundle:nil];		
	}
	
	NSString *uid = [DataEnvironment sharedDataEnvironment].playerUid;
	NSString *pid = [DataEnvironment sharedDataEnvironment].pid;
	
	HttpPurchase* myPurchase = [HttpPurchase sharedPurchase];
	NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
							uid,				@"uid",
							@"getIphoneGoods",	@"method",
							pid,				@"pid",
							nil];
	[myPurchase RequestParams:params];
	[myPurchase setConnectOver:NO];
	[myPurchase setClientProtocol:MJBank_Store_Protocol];
	
	[purchaseTable openConnect];
	[[[UIApplication sharedApplication]keyWindow] addSubview:purchaseTable.view];
}


-(void)dealloc
{
	[purchaseTable release];
	
	[super dealloc];
}

@end
