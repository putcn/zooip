//
//  DataModelStorageAnimal.h
//  zoo
//
//  Created by Gu Lei on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelStorageAnimal : NSObject
{
	NSString* adultBirdStorageId;
	NSString* originalAnimalId;
	
	NSInteger amount;
}

@property (nonatomic, retain) NSString* adultBirdStorageId;
@property (nonatomic, retain) NSString* originalAnimalId;

@property (nonatomic, assign) NSInteger amount;

@end
