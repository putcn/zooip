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

//-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//	NSLog(@"Value %@ changed in %@", keyPath, [object description]);
//	if ([keyPath isEqual:@""])
//	{
//		NSMutableArray *animalsArray = [change objectForKey:NSKeyValueChangeNewKey];
//		
//		[self updateAnimal:animalsArray];
//		
////		for(NSNumber *number in array)
////		{
////			NSLog(@"%i", [number integerValue]);
////		}
//	}
//}

-(void) addAnimal:(NSMutableArray *)animalIDs
{
	DataModelAnimal *serverAnimalData;
	
	//Update the animals array, and update the animal view...
	
	//Edit the existent animal or Add the new animal
//	Boolean isNew = YES;
	for (NSString *serverAnimalID in animalIDs)
	{
		//isNew = YES;
//		for (Animal *localAnimal in animals)
//		{
//			if ([localAnimal.animalData.animalId isEqual:serverAnimalData.animalId])
//			{
//				isNew = NO;
//				
//				//TODO: Edit Animal Status
//				break;
//			}
//		}
		
//		if (isNew == YES)
//		{
			//TODO: Add Animal
		serverAnimalData = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:serverAnimalID];
		Animal *newAnimal = [[Animal alloc] initWithAnimalData:serverAnimalData];
		[animals addObject:newAnimal];
//		}
	}
	
//	//Remove the unexistent animal
//	Boolean isExistent = NO;
//	for (Animal *localAnimal in animals)
//	{
//		isExistent = NO;
//		for (NSString *serverAnimalID in animalIDs)
//		{
//			//serverAnimalData = [DataEnvironment sharedDataEnvironment]
//			
//			if ([localAnimal.animalData.animalId isEqual:serverAnimalData.animalId])
//			{
//				isExistent = YES;
//				break;
//			}
//		}
//		
//		if (isExistent == NO)
//		{
//			//TODO: Remove animal
//			[animals removeObject:localAnimal];
//			[localAnimal dealloc];
//		}
//	}
}

-(void) clearAnimal
{
	for (Animal *clearAnimal in animals)
	{
		[animals removeObject:clearAnimal];
		[clearAnimal dealloc];
	}
}

-(void) gotoEat
{
	for (Animal *callAnimal in animals)
	{
		[callAnimal gotoEat];
	}
}

@end
