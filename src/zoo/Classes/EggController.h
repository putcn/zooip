//
//  EggController.h
//  zoo
//
//  Created by Rainbow on 5/16/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggViewFactory.h"


@interface EggController : NSObject {

	NSMutableDictionary *eggs;
}

+(EggController *) sharedEggController;

-(void) addEggs:(NSMutableArray *)eggIds;
-(void) clearEgg;

@end
