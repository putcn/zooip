//
//  AnimalViewFactory.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalViewFactory.h"


@implementation AnimalViewFactory


+(AnimalView *) createAnimalView:(NSInteger) type birdStage:(NSInteger) stage
{
	switch (type) {
		//母鸭
		case 1:
			if(stage == 1)
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
				return [[DuckView alloc] init];
			break;
		//母鸡
		case 2:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if(stage > 1)
				return [[HenView alloc] init];
			
			break;
		//母鹅
		case 3:
			if (stage == 1) 
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
			    return [[GooseView alloc] init];
			break;
		//母鸽子
		case 4:
			if (stage == 1) 
				return [[BabyPigeonView alloc] init];
			else if(stage > 1)
				return [[PigeonView alloc] init];
			break;
		//母野鸭
		case 5:
			if (stage == 1)
				return [[BabyMallardView alloc] init];
			else if(stage > 1)
				return [[MallardView alloc] init];
			break;
		//母火鸡
		case 6:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if(stage >1)
				return [[TurkeyView alloc] init];
			break;
		//母喜鹊
		case 7:
			if (stage == 1)
				return [[BabyMagpieView alloc] init];
			else if(stage > 1)
				return [[MagpieView alloc] init];
			break;
		//母天鹅(资源未到位)
		case 8:
			if (stage == 1) 
				return [[BabySwanView alloc] init];
			else if(stage > 1)
				return [[SwanView alloc] init];
			break;
		//母鹦鹉(资源未到位)
		case 9:
			if (stage == 1) 
				return [[BabyPigeonView alloc] init];
			else if(stage > 1)
				return [[ParrotView alloc] init];
			break;
		//母雉鸡
		case 10:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if (stage > 1)
				return [[PheasantView alloc] init];
			break;
		//公大雁(资源未到位)
		case 11:
			if (stage == 1) 
				return [[BabyWildgooseView alloc] init];
			else if (stage > 1)
				return [[WildgooseView alloc] init];
			break;
		//母鸳鸯
		case 12:
			if (stage == 1) 
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
				return [[MandarinDuckView alloc] init];
			break;
		//母孔雀
		case 13:
			if (stage == 1) 
				return [[BabyPeacockView alloc] init];
			else if(stage > 1)
				return [[PeacockView alloc] init];
			break;
		//母丹顶鹤
		case 14:
			if (stage == 1) 
				return [[BabyCraneView alloc] init];
			else if(stage > 1)
				return [[CraneView alloc] init];
			break;
			
		//公鸭
		case 51:
			if (stage == 1) 
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
				return [[DuckView alloc] init];
			break;
		//公鸡
		case 52:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if(stage > 1)
				return [[RoosterView alloc] init];
			break;
		//公鹅
		case 53:
			if (stage == 1) 
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
				return [[GooseView alloc] init];
			break;
		//公鸽子
		case 54:
			if (stage == 1) 
				return [[BabyPigeonView alloc] init];
			else if(stage > 1)
				return [[PigeonView alloc] init];
			break;
		//公野鸭
		case 55:
			if (stage == 1) 
				return [[BabyMallardView alloc] init];
			else if(stage > 1)
				return [[MallardView alloc] init];
			break;
		//公火鸡
		case 56:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if(stage > 1)
				return [[TurkeycockView alloc] init];
			break;
		//公喜鹊
		case 57:
			if (stage == 1) 
				return [[BabyMagpieView alloc] init];
			else if(stage > 1)
				return [[MagpieView alloc] init];
			break;
		//公天鹅(资源未到位)
		case 58:
			if (stage == 1) 
				return [[BabySwanView alloc] init];
			else if(stage > 1)
				return [[SwanView alloc] init];
			break;
		//公鹦鹉(资源未到位)
		case 59:
			if (stage == 1) 
				return [[BabyPigeonView alloc] init];
			else if(stage > 1)
				return [[ParrotView alloc] init];
			break;
		//公雉鸡
		case 60:
			if (stage == 1) 
				return [[BabyHenView alloc] init];
			else if(stage > 1)
				return [[MalePheasant alloc] init];
			break;
		//公大雁(资源未到位)
		case 61:
			if (stage == 1) 
				return [[BabyWildgooseView alloc] init];
			else if(stage > 1)
				return [[WildgooseView alloc] init];
			break;
		//公鸳鸯
		case 62:
			if (stage == 1) 
				return [[BabyDuckView alloc] init];
			else if(stage > 1)
				return [[MaleMandarinDuckView alloc] init];
			break;
		//公孔雀
		case 63:
			if (stage == 1) 
				return [[BabyPeacockView alloc] init];
			else if(stage > 1)
				return [[PeacockView alloc] init];
			break;
		//公丹顶鹤
		case 64:
			if (stage == 1) 
				return [[BabyCraneView alloc] init];
			else if(stage > 1)
				return [[CraneView alloc] init];
			break;

		default:
			return nil;
			break;
	}
	return nil;
}

@end
