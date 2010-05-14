//
//  BaseServerController.h
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseWorkFlowController;


@interface BaseServerController : NSObject
{
	BaseWorkFlowController *workFlowController;
}

-(BaseServerController *) initWithWorkFlowController:(BaseWorkFlowController *)controller;
-(void) execute:(NSObject *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
