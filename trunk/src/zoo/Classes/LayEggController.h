//
//  LayEggController.h
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerController.h"
#import "ServiceHelper.h"
@class AllLayEggController;


@interface LayEggController : BaseServerController
{
	AllLayEggController *allLayEggController;
	NSString* animalId;
}

-(LayEggController *) initWithAllEggController:(AllLayEggController *)controller;

@end
