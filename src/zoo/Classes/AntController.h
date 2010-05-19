//
//  AntController.h
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AntController : NSObject {
	
	NSMutableArray *allAnts;
}

+(AntController *) sharedAntController;

-(void) addAnts:(NSArray *)antIds;
-(void) clearAnts;

@end
