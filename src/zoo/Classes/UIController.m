//
//  UIController.m
//  zoo
//
//  Created by Gu Lei on 10-4-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIController.h"


@implementation UIController

static UIController *_sharedUIController = nil;

+(UIController *)sharedUIController
{
	@synchronized([UIController class])
	{
		if (!_sharedUIController)
		{
			_sharedUIController = [[UIController alloc] init];
		}
		
		return _sharedUIController;
	}
	
	return nil;
}

-(void) notify:(NSNotification *)notification
{
	//id notificationSender = [notification object];
}

-(int) getOperation
{
	return operation;
}

-(void) switchOperation:(int)op
{
	operation = op;
}

@end
