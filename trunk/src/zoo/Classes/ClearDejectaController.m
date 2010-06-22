//
//  ClearDejectaController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ClearDejectaController.h"
#import "DejectaController.h"


@implementation ClearDejectaController
@synthesize dejectaId;


-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoClearDejecta WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1)
	{
		NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
		[[DejectaController sharedDejectaController] removeDejecta:self.dejectaId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功清除粪便"];
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"粪便已经清除"];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
