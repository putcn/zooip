//
//  BaseWorkFlowController.h
//  zoo
//
//  Created by Gu Lei on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseServerController;


@interface BaseWorkFlowController : NSObject
{
	NSString *curStep;
	NSMutableDictionary *stepControllers;
}

   

-(void) addController:(BaseServerController *)controller andStep:(NSString *)step;
-(void) setupStep;
-(void) startStep;
-(void) nextStep;
-(void) endStep;

@end
