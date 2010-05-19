//
//  DejectaController.h
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DejectaController : NSObject {
	
	NSMutableArray *allDejectas;
}

+(DejectaController *) sharedDejectaController;

-(void) addDejectas:(NSArray *)dejectaIds;
-(void) clearDejectas;

@end
