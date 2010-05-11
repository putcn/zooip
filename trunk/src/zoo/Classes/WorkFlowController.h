//
//  WorkFlowController.h
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ServerController;

@interface WorkFlowController : NSObject
{
	NSString *step;
	NSMutableDictionary *stepControllers;
}

-(void) addController:(ServerController *)controller andStep:(NSString *) step;
-(void) start;
-(void) nextStep;
-(void) end;

@end
