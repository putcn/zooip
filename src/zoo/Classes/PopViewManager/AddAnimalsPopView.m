//
//  AddAnimalsPopView.m
//  zoo
//
//  Created by AlexLiu on 8/5/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "AddAnimalsPopView.h"
#import "ServiceHelper.h"
#import "StorageManageToolbar.h"
#import "GameMainScene.h"
#import "AnimalController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "DataEnvironment.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"


@implementation AddAnimalsPopView



- (id) init{
	
	if ( (self = [super init]) ){
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 80, 280, 160)];
		[myPopView setSubSize:CGSizeMake(50, 50)];
		[myPopView setM_nlistCount:2];
		
		CGRect rect = CGRectMake(0, 20, 75.f, 75.f);
		NSMutableArray *foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect]];
		[myPopView initWithBtn:foo];
		[foo release];
		foo = nil;
		currentTagFlag = @"动物";
	}
	
	return self;
}

//点击动物仓库按钮，弹出来仓库里面的动物。
- (void) btnShopButtonHandler{
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
	if (currentTagFlag == @"动物") {
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	}
	else if(currentTagFlag == @"拍来动物"){
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	}
	//[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	tabFlag = ANIMAL_WAREHOUSE_POPVIEW;
	[myPopView addView2Window];
}


//点击不同的动物，放入到动物园
-(void) itemInfoHandler:(AnimalStorageManagerButtonItem *) itemButton
{
	
	//AnimalStorageManagerPanel *itemInfo = (AnimalStorageManagerPanel *)itemButton.target; 
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	
	if(itemButton.itemType ==@"拍来动物")
	{
		currentTagFlag = @"拍来动物";
		NSString *auctionBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",auctionBirdStorageId,@"auctionBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAuctionAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		
		
	}
	else if (itemButton.itemType == @"动物")
	{
		currentTagFlag = @"动物";
		NSString *adultBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",adultBirdStorageId,@"adultBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		
	}
}


-(void)updateFarmInfoPutAnimal:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"updateFarmInfoResultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void)updateFarmInfoResultCallback:(NSObject*)value
{
	[[GameMainScene sharedGameMainScene] updateUserInfo];
}

//点击一个动物放入农场之后的回调函数
-(void) resultCallback:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	BaseServerController *getAllBirdFarmAnimalInfoController;
	
	NSDictionary *itemDic;
	NSArray *itemArray;
	
	switch (tabFlag) {
		case SHOP_POPVIEW:{
			
			if(currentTagFlag == @"拍来动物")
			{
				switch (code) {
					case 0:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"找不到拍卖所得动物"];
						break;
					case 1:
					{
						[[AnimalController sharedAnimalController] clearAnimal];
						[[DataEnvironment sharedDataEnvironment].animals removeAllObjects];
						[[DataEnvironment sharedDataEnvironment].animalIDs removeAllObjects];
						getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:nil];
						NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
												[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
						[getAllBirdFarmAnimalInfoController execute:params];
						[self updateFarmInfoPutAnimal:params];
						[DataEnvironment sharedDataEnvironment].storageAnimals = nil;
						
						
						//**********[itemInfoPane updatePage];
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"添加动物到饲养场成功"];
					}
						break;
					case 2:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"仓库中没有该动物!"];
						break;
					case 3:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲养场动物数量超标!"];
						break;
					default:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
						break;
				}
			}
			else if(currentTagFlag == @"动物")
			{
				switch (code) {
					case 1:
					{
						[[AnimalController sharedAnimalController] clearAnimal];
						[[DataEnvironment sharedDataEnvironment].animals removeAllObjects];
						[[DataEnvironment sharedDataEnvironment].animalIDs removeAllObjects];
						getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:nil];
						NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
												[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
						[getAllBirdFarmAnimalInfoController execute:params];
						[self updateFarmInfoPutAnimal:params];
						
						[DataEnvironment sharedDataEnvironment].storageAnimals = nil;
						
						//*****[itemInfoPane updatePage];
						
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"添加动物到饲养场成功"];
					}
						break;
					case 2:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"仓库动物数量不足!"];
						break;
					case 3:
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲养场动物数量超标!"];
						break;
					default :
						[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
						break;
				}
			}
			
	
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			itemArray = [itemDic allKeys];
		}
			break;
		default:
			break;
	}
	NSLog(@"操作已成功!");
}

//失败响应
-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}


-(void) generatePage
{	
	NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
	NSMutableArray* sexNameArray = [[NSMutableArray alloc] init];
	switch (tabFlag) {
		case ANIMAL_WAREHOUSE_POPVIEW:
		{
			
			NSLog(@"************* generatePage ***********************");
			if (currentTagFlag == @"动物") {
				NSDictionary *storageAnimal = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
				DataModelStorageAnimal *stoAnimals;
				NSArray *animalArray = [storageAnimal allKeys];
				NSString *gender;
				
				for (int i = 0; i < [animalArray count]; i ++) {
					stoAnimals = [storageAnimal objectForKey:[animalArray objectAtIndex:i]];
					DataModelOriginalAnimal *serverAnimalToshow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoAnimals.originalAnimalId];			
					
					if ([serverAnimalToshow.originalAnimalId intValue] > 50) {
						
						//male
					}
					else {
						//female
					}
					
					NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalToshow.scientificNameCN];
					NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalToshow.picturePrefix];
					[picFileNameArray addObject:picFileName];
					[sexNameArray addObject:gender];
				}
				
				
			}
			if (currentTagFlag == @"拍来动物") {
				NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
				DataModelStorageAuctionAnimal *stoauAnimals;
				NSArray *animalArray = [auctionAnimals allKeys];
				
				DataModelOriginalAnimal *serverAnimalShow;
				CCSprite *localGender;
				for (int i = 0; i < [animalArray count]; i ++) {
					stoauAnimals = [auctionAnimals objectForKey:[animalArray objectAtIndex:i]];
					serverAnimalShow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoauAnimals.originalAnimalId];
					
					if ([serverAnimalShow.originalAnimalId intValue] > 50) {
						localGender = [CCSprite spriteWithFile:@"公.png"];
					}
					else {
						localGender = [CCSprite spriteWithFile:@"母.png"];
					}
					
					NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalShow.scientificNameCN];
					NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalShow.picturePrefix];
					
				}
			}
			break;
		default:
			break;
		}
			
	}
}


//生成商品页面
//- (void) generatePage
//{
//	switch (tabFlag) {
//		case SHOP_POPVIEW:{
//			
//			
//			NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
//			
//			DataModelOriginalAnimal *originAnimal; //levelRequired
//			NSArray *animalArrayTemp1 = [originAnimalDic allKeys];
//			NSMutableArray* animalArrayTemp = [[NSMutableArray alloc] init];
//			[animalArrayTemp addObjectsFromArray:animalArrayTemp1];
//			
//			NSMutableArray* arrOfLevel = [[NSMutableArray alloc]init];
//			
//			for(int i = 0; i < [animalArrayTemp count]; i++)
//			{
//				originAnimal = [originAnimalDic objectForKey:[animalArrayTemp objectAtIndex:i]];
//				
//				[arrOfLevel addObject:[NSNumber numberWithInt:originAnimal.levelRequired]];
//			}
//			
//			// 冒泡排序
//			int nTemp;
//			NSString* strTemp;
//			for(int j = 0; j <= [arrOfLevel count] - 1 ; j++)
//			{
//				for(int i = 0; i < [arrOfLevel count] - 1- j; i++)
//				{
//					if([[arrOfLevel objectAtIndex:i] intValue] >= [[arrOfLevel objectAtIndex:i+1] intValue])
//					{
//						nTemp = [[arrOfLevel objectAtIndex:i] intValue];
//						strTemp = [animalArrayTemp objectAtIndex:i];
//						
//						int nRight = [[arrOfLevel objectAtIndex:i+1] intValue];
//						NSString* strRight = [animalArrayTemp objectAtIndex:i + 1];
//						
//						[arrOfLevel replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:nRight]];
//						[animalArrayTemp replaceObjectAtIndex:i withObject:strRight];
//						
//						[arrOfLevel replaceObjectAtIndex:i+1 withObject:[NSNumber numberWithInt:nTemp]];
//						[animalArrayTemp replaceObjectAtIndex:i + 1 withObject:strTemp];
//						
//					}
//				}
//			}
//			
//			
//			NSArray* animalArray = [NSArray arrayWithArray:animalArrayTemp];
//			NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
//			
//			for (int i = 0; i < [animalArray count]; i ++) 
//			{
//				originAnimal = [originAnimalDic objectForKey:[animalArray objectAtIndex:i]];
//				
//				int buyType = 0;
//				NSString *price = [NSString stringWithFormat:@"%d",originAnimal.basePrice];
//				if (originAnimal.antsPrice > 0) {
//					buyType = 1;
//					price = [NSString stringWithFormat:@"%d",originAnimal.antsPrice];
//				}
//				
//				//根据动物的originalAnimalId生成ItemButton
//				NSString *picFileName = [NSString stringWithFormat:@"%@.png",originAnimal.picturePrefix];				
//				
//				[picFileNameArray addObject:picFileName];
//			}
//			[myPopView initWithItem:picFileNameArray];
//			
//			//			[picFileNameArray release];
//			//			picFileNameArray = nil;
//		}		
//			
//			break;
//		default:
//			break;
//	}
//	
//}

- (void) dealloc{
	
	[myPopView release];
	
	[super dealloc];
}

@end
