//
//  GetAllBirdFarmAnimalInfoController.h
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerController.h"
#import "ServiceHelper.h"

@interface GetAllBirdFarmAnimalInfoController : NSObject <ServerController>
{
	
}

-(void) execute:(NSDictionary *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
