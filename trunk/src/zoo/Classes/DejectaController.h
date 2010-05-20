//
//  DejectaController.h
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DejectaView.h"
#import "OperationEndView.h"

@interface DejectaController : NSObject {
	
	NSMutableDictionary *allDejectas;
}

+(DejectaController *) sharedDejectaController;

-(void) addDejectas:(NSArray *)dejectaIds;
-(void) clearDejectas;

@end
