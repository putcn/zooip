//
//  EggController.h
//  zoo
//
//  Created by Rainbow on 5/16/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EggViewFactory.h"
#import "DataEnvironment.h"
#import "DataModelEgg.h"

@interface EggController : NSObject {

	NSMutableArray *allEggs;
}

+(EggController *) sharedEggController;

-(void) addEggs:(NSArray *)eggIds;
-(void) clearEgg;

@end
