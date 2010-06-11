//
//  FeedAllAnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-5-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeedAllAnimalController.h"
#import "BowlsView.h"
#import "ItemController.h"

@implementation FeedAllAnimalController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoFeedAllAnimal WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if(code == 1)
	{
		NSInteger foodEndTime = [[result objectForKey:@"remain"] intValue]*3600;
		BowlsView *bowlsView = (BowlsView *)[[ItemController sharedItemController].allItems objectForKey:@"bowls"];
		[bowlsView update:foodEndTime];
	}
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
