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

-(AnimalController *)init
{
	if ((self = [super init]))
	{
		animals = [[NSMutableArray alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"Value %@ changed in %@", keyPath, [object description]);
	if ([keyPath isEqual:@""])
	{
		NSMutableArray *animalsArray = [change objectForKey:NSKeyValueChangeNewKey];
		
		[self updateAnimal:animalsArray];
		
//		for(NSNumber *number in array)
//		{
//			NSLog(@"%i", [number integerValue]);
//		}
	}
}

-(void) updateAnimal:(NSMutableArray *)animalsData
{
	Boolean isNew = NO;
	
	//Update the animals array, and update the animal view...
	for (DataModelAnimal *serverAnimalData in animalsData)
	{
		for (DataModelAnimal *localAnimalData in animals)
		{
			if ([localAnimalData.animalId isEqual:localAnimalData.animalId])
			{
				
			}
		}
	}
}

@end
