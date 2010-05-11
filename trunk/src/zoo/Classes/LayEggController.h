//
//  LayEggController.h
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerController.h"
@class AllLayEggController;

@interface LayEggController : ServerController
{
	AllLayEggController *allLayEggController;
}

-(LayEggController *) initWithAllEggController:(AllLayEggController *)controller;

@end
