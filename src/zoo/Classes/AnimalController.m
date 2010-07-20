//
//  AnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalController.h"
#import "ImageResources.h"

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
		animals = [[NSMutableDictionary alloc] initWithCapacity:0];
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
		Animal *newAnimal;
		if (serverAnimalData.birdStage == 0) {
			NSLog(@"%@",@"有动物正在孵蛋!");
		}
		else {
			newAnimal = [[Animal alloc] initWithAnimalData:serverAnimalData];
			[animals setObject:newAnimal forKey:serverAnimalID];
		}

		
		// Add by Hunk on 2010-06-30
		//[newAnimal release];
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

-(void) removeAnimal:(NSString *)animalId
{
	Animal *animal = [animals objectForKey:animalId];
	[animal removeAnimalView];
	[animal release];
	[animals removeObjectForKey:animalId];
	
}

-(void) clearAnimal
{
	for (NSString *clearAnimal in [animals allKeys] )
	{
		Animal *animal = [animals objectForKey:clearAnimal];
		[animal removeAnimalView];
		[animal release];
		[animals removeObjectForKey:clearAnimal];
	}
	[[ImageResources sharedImageResources] restore];

}

-(void) gotoEat
{
	for (NSString *callAnimalID in [animals allKeys] )
	{
		Animal *callAnimal = [animals objectForKey:callAnimalID];
		[callAnimal gotoEat];
	}
}

-(void) scatterAll
{
	
}

-(void) cureAnimal:(NSString *)cureAnimalId
{
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[animals release];
	
	[super dealloc];
}



@end
