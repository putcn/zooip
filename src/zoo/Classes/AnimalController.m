//
//  AnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalController.h"


@implementation AnimalController

static AnimalController *_sharedAnimalController = nil;

+(AnimalController *)sharedAnimalController
{
	@synchronized([AnimalController class])
	{
		if (!_sharedAnimalController)
		{
			_sharedAnimalController = [[AnimalController alloc] init];
		}
		
		return _sharedAnimalController;
	}
	
	return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"Value %@ changed in %@", keyPath, [object description]);
	if ([keyPath isEqual:@""])
	{
		NSMutableArray *array = [change objectForKey:NSKeyValueChangeNewKey];
		
//		for(NSNumber *number in array)
//		{
//			NSLog(@"%i", [number integerValue]);
//		}
	}
}

@end
