//
//  DataModelUserTips.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-19.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelUserTips.h"


@implementation DataModelUserTips

@synthesize
snsUserId,
egg,
shit,
snake,
ant;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[snsUserId release];
	
	[super dealloc];
}


@end
