//
//  DataModelFriendInfo.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-19.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelFriendInfo.h"


@implementation DataModelFriendInfo

@synthesize
farmId,
farmerId,
userName,
tinyurl,
experience,
uid;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[farmId release];
	[farmerId release];
	[userName release];
	[tinyurl release];
	[uid release];
	
	[super dealloc];
}


@end
