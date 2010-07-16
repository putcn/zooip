//
//  LayEggController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LayEggController.h"
#import "AllLayEggController.h"
#import "DataModelAnimal.h"
#import "DataModelEgg.h"

@implementation LayEggController

//-(LayEggController *) initWithAllEggController:(AllLayEggController *)controller
//{
//	if ((self = [super init]))
//	{
//		allLayEggController = controller;
//		return self;
//	}
//
//	return nil;
//}

-(void) execute:(NSObject *)value
{
	acount = 0;
	if ([[DataEnvironment sharedDataEnvironment].animalIDs count] == 0) {
		[super resultCallback:nil];
	}
	else {
		for (NSString *aniId in [DataEnvironment sharedDataEnvironment].animalIDs) {
			NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:aniId, @"animalId" , nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetLayEggsRemain WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}		
	}
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
	NSInteger code = [[dic objectForKey:@"code"] intValue];
	switch (code) {
			case 0:
			NSLog(@"%@",@"动物处于饥饿状态");
				break;
		case 1:
			NSLog(@"%@",@"动物下蛋时间未到");
			break;
		case 2:
			NSLog(@"%@",@"不存在该动物");
			break;
		case 3:
			NSLog(@"%@",@"下蛋失败");
			break;
		case 4:
			NSLog(@"%@",@"公动物不能下蛋");
			break;
	}
//			// TODO DELETE
//			//"code:1 动物处于饥饿状态 + animal + eggs + birdEggId + farmId + eggId + quantity + remain + lastStoleTime + numOfZygote + coordinate + eggId
//			//code:2 动物下蛋时间未到 + 下次下蛋剩余时间:remain
//			//code:3 不存在该动物
//			//code:4 下蛋失败
//			//code:5 公动物不能下蛋
//			//code:0 + eggs + birdEggId + farmId + eggId + quantity + remain + lastStoleTime + numOfZygote + coordinate + eggId"
//		case 0:
//		{
//			// 下蛋成功
//			NSDictionary* eggsDic = [[DataEnvironment sharedDataEnvironment] eggs];
//			NSArray* eggsArray = [dic objectForKey:@"eggs"];
//			for (int i = 0; i < [eggsArray count]; i++) {
//				NSDictionary* eggDic = [eggsArray objectAtIndex:i];
//				DataModelEgg* egg = [[DataModelEgg alloc] init];
//				
//				egg.birdEggId = [[eggDic objectForKey:@"birdEggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"birdEggId"];
//				egg.farmId = [[eggDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"farmId"];
//				egg.lastStoleTime = [[eggDic objectForKey:@"lastStoleTime"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"lastStoleTime"];
//				egg.coordinate = [[eggDic objectForKey:@"coordinate"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"coordinate"];
//				egg.eggId = [[eggDic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggId"];
//				//egg.eggName = [[eggDic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggName"];
//				//egg.eggNameEN = [[eggDic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggNameEN"];
//				//egg.eggImgId = [[eggDic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggImgId"];
//				egg.eggDescription = [[eggDic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggDescription"];
//				
//				egg.quantity = [[eggDic objectForKey:@"quantity"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"quantity"] intValue];
//				egg.remain = [[eggDic objectForKey:@"remain"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"remain"] intValue];
//				egg.numOfZygote = [[eggDic objectForKey:@"numOfZygote"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"numOfZygote"] intValue];
//				//egg.eggPrice = [[eggDic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"eggPrice"] intValue];
//				//egg.zygotePrice = [[eggDic objectForKey:@"zygotePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"zygotePrice"] intValue];
//				
//				[eggsDic setValue:egg forKey:[egg eggId]];
//			}
//		}
//			break;
//		case 1:
//			// TODO 动物处于饥饿状态
//			break;
//		case 2:
//		{
//			// TODO 动物下蛋时间未到
//			DataModelAnimal* animal = [[[DataEnvironment sharedDataEnvironment] animals] objectForKey:animalId];
//			NSInteger remain = [[dic objectForKey:@"remain"] intValue];
//			[animal setRemain:remain];
//		}
//			break;
//		case 3:
//			// TODO 不存在该动物
//			break;
//		case 4:
//			// TODO 下蛋失败
//			break;
//		case 5:
//			// TODO 公动物不能下蛋
//			break;
//
//		default:
//			break;
//	}
	acount++;
	if (acount == [[DataEnvironment sharedDataEnvironment].animalIDs count]) {
		acount = 0;
		[super resultCallback:value];
	}

}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[allLayEggController release];
	[animalId release];
	
	[super dealloc];
}


@end
