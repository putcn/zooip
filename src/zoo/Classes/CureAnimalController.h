//
//  CureAnimalController.h
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerController.h"
#import "ServiceHelper.h"


@interface CureAnimalController : BaseServerController
{
	NSString *animalId;
}

@property (nonatomic,retain)NSString *animalId;
-(void) execute:(NSDictionary *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

// Add by Hunk on 2010-07-14 for updating farm information
-(void)updateFarmInfoExeCute:(NSDictionary *)value;
-(void)updateFarmInfoResultCallback:(NSObject*)value;

@end
