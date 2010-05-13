//
//  UIController.h
//  zoo
//
//  Created by Gu Lei on 10-4-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIController : NSObject
{
	NSString *operation;
}

+(UIController *) sharedUIController;

-(void) switchOperation:(NSString *)op;

@end
