//
//  AnimalController.h
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelAnimal.h"


@interface AnimalController : NSObject
{
	NSMutableArray *animals;
}

+(AnimalController *) sharedAnimalController;

-(void) updateAnimal:(NSMutableArray *)animalsData;

@end