//
//  AnimalViewFactory.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalViewFactory.h"


@implementation AnimalViewFactory


+(AnimalView *) createAnimalView:(NSString *) type
{
	if ([type isEqualToString:@"littleduck"])
	{
		return [[LittleDuckView alloc] init];
	}
	else if ([type isEqualToString:@"duck"])
	{
		return [[DuckView alloc] init];
	}
	else if ([type isEqualToString:@"goose"])
	{
		return [[GooseView alloc] init];
	}
	else if ([type isEqualToString:@"chicken"])
	{
		return [[ChickenView alloc] init];
	}
	else if ([type isEqualToString:@"cock"])
	{
		return [[CockView alloc] init];
	}
	else if ([type isEqualToString:@"hen"])
	{
		return [[HenView alloc] init];
	}
	else if ([type isEqualToString:@"maleTurkey"])
	{
		return [[MaleTurkeyView alloc] init];
	}
	else if ([type isEqualToString:@"babyDove"])
	{
		return [[BabyDoveView alloc] init];
	}
	else if ([type isEqualToString:@"dove"])
	{
		return [[DoveView alloc] init];
	}
	else if ([type isEqualToString:@"babyMagpie"])
	{
		return [[BabyMagpieView alloc] init];
	}
	else if ([type isEqualToString:@"magpie"])
	{
		return [[MagpieView alloc] init];
	}
	else if ([type isEqualToString:@"babyPeacock"])
	{
		return [[BabyPeacockView alloc] init];
	}
	else if ([type isEqualToString:@"peacock"])
	{
		return [[PeacockView alloc] init];
	}
	else if ([type isEqualToString:@"babyMallard"])
	{
		return [[LittleMallardView alloc] init];
	}
	else if ([type isEqualToString:@"maleMandarinDuck"])
	{
		return [[MaleMandarinDuckView alloc] init];
	}
	else if ([type isEqualToString:@"redCrowne"])
	{
		return [[RedCrowneView alloc] init];
	}
	else if ([type isEqualToString:@"chinemy"])
	{
		return [[ChinemyView alloc] init];
	}
	else if ([type isEqualToString:@"snake"])
	{
		return [[SnakeView alloc] init];
	}
	else if ([type isEqualToString:@"tibentanMastiff"])
	{
		return [[TibentanMastiffView alloc] init];
	}
	else if ([type isEqualToString:@"mallard"])
	{
		return [[MallardView alloc] init];
	}
	return nil;
}

@end
