//
//  DejectaController.m
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DejectaController.h"


@implementation DejectaController
static DejectaController *_sharedDejectaController = nil;

+(DejectaController *) sharedDejectaController
{
	@synchronized([DejectaController class])
	{
		if (!_sharedDejectaController)
		{
			_sharedDejectaController = [[DejectaController alloc] init];
		}
		
		return _sharedDejectaController;
	}
	
	return nil;
}

-(id) init
{
	if ((self = [super init]))
	{
		allDejectas = [[NSMutableArray alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addDejectas:(NSArray *)dejectaIds
{
	for (NSString *deId in dejectaIds) {
		[[DejectaView alloc] initWithID:deId];
	}
}

-(void) clearDejectas
{
	for (DejectaView *clearDejecta in allDejectas)
	{
		[allDejectas removeObject:clearDejecta];
		[clearDejecta dealloc];
	}
}

@end
