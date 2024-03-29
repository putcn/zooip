//
//  AnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalController.h"
#import "ImageResources.h"
#import "GameMainScene.h"
#import "RandomHelper.h"

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
		else if(serverAnimalData.status == 3){
			[self addBornAnimal:serverAnimalData.originalAnimalId];
		}
		else if(serverAnimalData.status == 0 || serverAnimalData.status == 1){
//			[NSThread detachNewThreadSelector:@selector(addAnimalThread:) toTarget:self withObject:serverAnimalData];
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

-(void) addAnimalThread:(DataModelAnimal *)animalData
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	Animal *newAnimal = nil;
	newAnimal = [[Animal alloc] initWithAnimalData:animalData];
	[animals setObject:newAnimal forKey:animalData.animalId];
	[pool release];
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
	NSLog(@"%@\n", animals);
	
	for (NSString *clearAnimal in [animals allKeys] )
	{
		
		NSLog(@"%@\n", clearAnimal);
		
		Animal *animal = [animals objectForKey:clearAnimal];
		[animal removeAnimalView];
	//	[animal release];
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

-(void) addBornAnimal:(NSInteger)type
{
	CCSprite *sprite = [CCSprite node];
	switch (type) {
			//母鸭
		case 1:
			[sprite initWithFile:@"duck_nest.png"];
			break;
			//母鸡
		case 2:
			[sprite initWithFile:@"hen_nest.png"];
			break;
			//母鹅
		case 3:
			[sprite initWithFile:@"goose_nest.png"];
			break;
			
		case 4:
			[sprite initWithFile:@"pigeon_nest.png"];
			break;
			
		case 5:
			[sprite initWithFile:@"mallard_nest.png"];
			break;
			
		case 6:
			[sprite initWithFile:@"turkey_nest.png"];
			break;
			//母火鸡
		case 7:
			[sprite initWithFile:@"magpie_nest.png"];
			break;
			//母喜鹊
		case 8:
			[sprite initWithFile:@"swan_nest.png"];
			break;
			//母天鹅(资源未到位)
		case 9:
			[sprite initWithFile:@"parrot_nest.png"];
			break;
			//母鹦鹉(资源未到位)
		case 10:
			[sprite initWithFile:@"pheasant_nest.png"];
			break;
			//母雉鸡
		case 11:
			[sprite initWithFile:@"wildgoose_nest.png"];
			break;
			//公大雁(资源未到位)
		case 12:
			[sprite initWithFile:@"mandarinduck_nest.png"];
			break;
			//母鸳鸯
		case 13:
			[sprite initWithFile:@"peahen_nest.png"];
			break;
			//母孔雀
		case 14:
			[sprite initWithFile:@"crane_nest.png"];
			break;
			//母丹顶鹤
			
		default:
			break;
	}
	CGPoint pos = CGPointMake([RandomHelper getRandomNum:300 to:600], [RandomHelper getRandomNum:100 to:300]);
	sprite.position = pos;
	[[GameMainScene sharedGameMainScene] addSpriteToStage:sprite z:5];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[animals release];
	
	[super dealloc];
}



@end
