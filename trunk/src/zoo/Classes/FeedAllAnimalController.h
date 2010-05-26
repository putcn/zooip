//
//  FeedAllAnimalController.h
//  zoo
//
//  Created by Gu Lei on 10-5-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerController.h"
#import "ServiceHelper.h"


@interface FeedAllAnimalController : BaseServerController
{
	
}

-(void) execute:(NSDictionary *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
