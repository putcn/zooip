//
//  AnimalViewFactory.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalViewFactory.h"


@implementation AnimalViewFactory


+(AnimalView *) createAnimalView:(NSString *) type
{
	if ([type isEqualToString:@"1"])
	{
		
	}
	else if ([type isEqualToString:@"2"])
	{
		
	}
	else
	{
		
	}
	
	return nil;
}

@end
