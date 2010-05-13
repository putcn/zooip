//
//  ServerController.h
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkFlowController.h"


@interface ServerController : NSObject
{
	WorkFlowController *workFlowController;
}

-(ServerController *) initWithWorkFlowController:(WorkFlowController *)controller;
-(void) execute:(NSObject *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
