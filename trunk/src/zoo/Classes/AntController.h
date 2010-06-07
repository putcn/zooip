//
//  AntController.h
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntView.h"
#import "DataModelAnt.h"
#import "OperationEndView.h"

@interface AntController : NSObject {
	
	NSMutableDictionary *allAnts;
}

+(AntController *) sharedAntController;

-(void) addAnts:(NSArray *)antIds;
-(void) clearAnts;
-(void) removeAnt:(NSString *)antId setExperience:(NSInteger)experience;

@end
