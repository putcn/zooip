//
//  EggViewFactory.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggViewFactory.h"


@implementation EggViewFactory

+(EggView *) createEggViews:(int)type
{
	switch (type) {
		case 1:
			return [[DuckEggView alloc] init];
			break;
		case 2:
			return [[HenEggView alloc] init];
			break;
		case 3:
			return [[GooseEggView alloc] init];
			break;
		case 4:
			return [[PigeonEggView alloc] init];
			break;
		case 5:
			return [[MallardEggView alloc] init];
			break;
		case 6:
			return [[TurkeyEggView alloc] init];
			break;
		case 7:
			return [[MagpieEggView alloc] init];
			break;
		case 8:
			return [[SwanEggView alloc] init];
			break;
		case 9:
			return [[ParrotEggView alloc] init];
			break;
		case 10:
			return [[PheasantEggView alloc] init];
			break;
		case 11:
			return [[WildgooseEggView alloc] init];
			break;
		case 12:
			return [[MandarinduckEggView alloc] init];
			break;
		case 13:
			return [[PeahenEggView alloc] init];
			break;
		case 14:
			return [[CraneEggView alloc] init];
			break;
		default:
			return nil;
			break;
	}
	return nil;
}

@end
