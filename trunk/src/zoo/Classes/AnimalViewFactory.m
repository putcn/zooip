//
//  AnimalViewFactory.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalViewFactory.h"


@implementation AnimalViewFactory


+(AnimalView *) createAnimalView:(int) type birdStage:(int) stage
{
	switch (type) {
		//公鸭
		case 1:
			if(stage == 1)
				return [[LittleDuckView alloc] init];
			else if(stage > 1)
				return [[DuckView alloc] init];
			break;
		//公鸡
		case 2:
			if (stage == 1) 
				return [[ChickenView alloc] init];
			else if(stage > 1)
				return [[CockView alloc] init];
			
			break;
		//公鹅
		case 3:
			if (stage == 1) 
				return [[LittleDuckView alloc] init];
			else if(stage > 1)
			    return [[GooseView alloc] init];
			break;
		//公鸽子
		case 4:
			if (stage == 1) 
				return [[BabyDoveView alloc] init];
			else if(stage > 1)
				return [[DoveView alloc] init];
			break;
		//公野鸭
		case 5:
			if (stage == 1)
				return [[LittleMallardView alloc] init];
			else if(stage > 1)
				return [[MallardView alloc] init];
			break;
		//雄火鸡
		case 6:
			if (stage == 1) 
				return [[MaleTurkeyView alloc] init];
			else if(stage >1)
				return [[MaleTurkeyView alloc] init];
			break;
		//雄喜鹊
		case 7:
			if (stage == 1)
				return [[BabyMagpieView alloc] init];
			else if(stage > 1)
				return [[MagpieView alloc] init];
			break;
		//雄天鹅(资源未到位)
		case 8:
			return [[DoveView alloc] init];
			break;
		//公鹦鹉(资源未到位)
		case 9:
			return [[DoveView alloc] init];
			break;
		//公雉鸡
		case 10:
			if (stage == 1) 
				return [[MalePhasianusColchicusView alloc] init];
			else if (stage > 1)
				return [[MalePhasianusColchicusView alloc] init];
			break;
		//公大雁(资源未到位)
		case 11:
			return [[DoveView alloc] init];
			break;
		//鸳鸯
		case 12:
			if (stage == 1) 
				return [[MaleMandarinDuckView alloc] init];
			else if(stage > 1)
				return [[MaleMandarinDuckView alloc] init];
			break;
		//公孔雀
		case 13:
			if (stage == 1) 
				return [[BabyPeacockView alloc] init];
			else if(stage > 1)
				return [[PeacockView alloc] init];
			break;
		//公丹顶鹤
		case 14:
			if (stage == 1) 
				return [[RedCrowneView alloc] init];
			else if(stage > 1)
				return [[RedCrowneView alloc] init];
			break;
			
		//母鸭
		case 51:
			if (stage == 1) 
				return [[LittleDuckView alloc] init];
			else if(stage > 1)
				return [[DuckView alloc] init];
			break;
		//母鸡
		case 52:
			if (stage == 1) 
				return [[ChickenView alloc] init];
			else if(stage > 1)
				return [[HenView alloc] init];
			break;
		//母鹅
		case 53:
			if (stage == 1) 
				return [[LittleDuckView alloc] init];
			else if(stage > 1)
				return [[GooseView alloc] init];
			break;
		//雌鸽子
		case 54:
			if (stage == 1) 
				return [[BabyDoveView alloc] init];
			else if(stage > 1)
				return [[DoveView alloc] init];
			break;
		//母野鸭
		case 55:
			if (stage == 1) 
				return [[LittleMallardView alloc] init];
			else if(stage > 1)
				return [[MallardView alloc] init];
			break;
		//母火鸡
		case 56:
			if (stage == 1) 
				return [[MaleTurkeyView alloc] init];
			else if(stage > 1)
				return [[MaleTurkeyView alloc] init];
			break;
		//雌喜鹊
		case 57:
			if (stage == 1) 
				return [[BabyMagpieView alloc] init];
			else if(stage > 1)
				return [[MagpieView alloc] init];
			break;
		//母天鹅(资源未到位)
		case 58:
			return [[DoveView alloc] init];
			break;
		//雌鹦鹉(资源未到位)
		case 59:
			return [[DoveView alloc] init];
			break;
		//母雉鸡
		case 60:
			if (stage == 1) 
				return [[PhasianusColchicusView alloc] init];
			else if(stage > 1)
				return [[PhasianusColchicusView alloc] init];
			break;
		//雌大雁(资源未到位)
		case 61:
			return [[DoveView alloc] init];
			break;
		//雌鸳鸯
		case 62:
			if (stage == 1) 
				return [[MaleMandarinDuckView alloc] init];
			else if(stage > 1)
				return [[MaleMandarinDuckView alloc] init];
			break;
		//雌孔雀
		case 63:
			if (stage == 1) 
				return [[BabyPeacockView alloc] init];
			else if(stage > 1)
				return [[PeahenView alloc] init];
			break;
		//雌丹顶鹤
		case 64:
			if (stage == 1) 
				return [[RedCrowneView alloc] init];
			else if(stage > 1)
				return [[RedCrowneView alloc] init];
			break;

		default:
				return [[DoveView alloc] init];
			break;
	}
	return nil;
}

@end
