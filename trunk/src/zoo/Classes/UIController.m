//
//  UIController.m
//  zoo
//
//  Created by Gu Lei on 10-4-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIController.h"


@implementation UIController

static UIController *_sharedUIController = nil;

+(UIController *)sharedUIController
{
	@synchronized([UIController class])
	{
		if (!_sharedUIController)
		{
			_sharedUIController = [[UIController alloc] init];
		}
		
		return _sharedUIController;
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
