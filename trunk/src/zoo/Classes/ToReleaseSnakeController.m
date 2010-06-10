//
//  ToReleaseSnakeController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToReleaseSnakeController.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelSnake.h"
#import "SnakeController.h"


@implementation ToReleaseSnakeController
@synthesize eggId;
-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoReleaseSnake WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {		
		NSString *snakeId = [result objectForKey:@"releaseSnakeId"];
		DataModelSnake *dataModelSnake = [[DataModelSnake alloc] init];
		dataModelSnake.eggId = eggId;
		dataModelSnake.releaseSnakeId = snakeId;
		[[DataEnvironment sharedDataEnvironment].snakes setObject:dataModelSnake forKey:snakeId];
		[[SnakeController sharedSnakeController] addSnakes:[NSArray arrayWithObject:snakeId]];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
