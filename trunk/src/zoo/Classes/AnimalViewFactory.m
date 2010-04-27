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
		return [[LittleDuckView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"duck"])
	{
		return [[DuckView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"goose"])
	{
		return [[GooseView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"chicken"])
	{
		return [[ChickenView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"cock"])
	{
		return [[CockView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"hen"])
	{
		return [[HenView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"maleTurkey"])
	{
		return [[MaleTurkeyView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"babyDove"])
	{
		return [[BabyDoveView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"dove"])
	{
		return [[DoveView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"babyMagpie"])
	{
		return [[BabyMagpieView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"magpie"])
	{
		return [[MagpieView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"babyPeacock"])
	{
		return [[BabyPeacockView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"peacock"])
	{
		return [[PeacockView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"babyMallard"])
	{
		return [[LittleMallardView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"maleMandarinDuck"])
	{
		return [[MaleMandarinDuckView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"redCrowne"])
	{
		return [[RedCrowneView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"chinemy"])
	{
		return [[ChinemyView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"snake"])
	{
		return [[SnakeView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"tibentanMastiff"])
	{
		return [[TibentanMastiffView alloc] initWithPrefix:@"ss"];
	}
	else if ([type isEqualToString:@"mallard"])
	{
		return [[MallardView alloc] initWithPrefix:@"ss"];
	}
	return nil;
}

@end
