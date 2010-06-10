//
//  ToReleaseAntsController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToReleaseAntsController.h"
#import "DataModelAnt.h"
#import "DataEnvironment.h"
#import "AntController.h"


@implementation ToReleaseAntsController


-(void)execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoReleaseAnts WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];

}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {		
		NSString *antId = [result objectForKey:@"releaseAntsId"];
		DataModelAnt *dataModelAnt = [[DataModelAnt alloc] init];
		dataModelAnt.releaseAntsId = antId;
		[[DataEnvironment sharedDataEnvironment].snakes setObject:dataModelAnt forKey:antId];
		[[AntController sharedAntController] addAnts:[NSArray arrayWithObject:antId]];
	}
	[super resultCallback:value];
}

-(void)faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}
@end
