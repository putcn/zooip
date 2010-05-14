//
//  GetFarmerInfoController.h
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerController.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelFarmerInfo.h"

@interface GetFarmerInfoController : BaseServerController
{
	
}

-(void) execute:(NSDictionary *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
