//
//  DataModelStorageAuctionAnimal.h
//  zoo
//
//  Created by Gu Lei on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelStorageAuctionAnimal : NSObject
{
	NSString* auctionBirdStorageId;
	NSString* animalId;
	NSString* originalAnimalId;
}

@property (nonatomic, retain) NSString* auctionBirdStorageId;
@property (nonatomic, retain) NSString* animalId;
@property (nonatomic, retain) NSString* originalAnimalId;

@end
