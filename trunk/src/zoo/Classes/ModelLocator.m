//
//  ModelLocator.m
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ModelLocator.h"


@implementation ModelLocator

static ModelLocator *_sharedModelLocator = nil;
static Boolean isSelfZoo = YES;

+(ModelLocator *)sharedModelLocator
{
	@synchronized([ModelLocator class])
	{
		if (!_sharedModelLocator)
		{
			_sharedModelLocator = [[ModelLocator alloc] init];
		}
		
		return _sharedModelLocator;
	}
	
	return nil;
}

-(void) setIsSelfZoo:(Boolean) isSelf
{
	isSelfZoo = isSelf;
}

-(Boolean) getIsSelfZoo
{
	return isSelfZoo;
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[super dealloc];
}


@end
