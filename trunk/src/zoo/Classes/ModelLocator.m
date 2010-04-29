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

@end
