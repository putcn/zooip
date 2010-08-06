//
//  MarryAndMatePopView.m
//  zoo
//
//  Created by AlexLiu on 8/6/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "MarryAndMatePopView.h"
#import "ServiceHelper.h"
#import "StorageManageToolbar.h"
#import "GameMainScene.h"
#import "AnimalController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "DataEnvironment.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"


@implementation MarryAndMatePopView

- (id) init{
	
	if ( (self = [super init]) ){
		tabFlagType = @"animalMarry";
		
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 120, 280, 160)];
		[myPopView setSubSize:CGSizeMake(40, 40)];
		[myPopView setM_nlistCount:2];
		[myPopView setM_npopViewType:SHOP_POPVIEW];
		
		CGRect rect = CGRectMake(0, 20, 75.f, 75.f);
		NSMutableArray *foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect]];
		[myPopView initWithBtn:foo];
		[foo release];
		foo = nil;
	}
	
	return self;
}

//此函数是，对离婚列表/结婚列表里面，点击其中的一个动物所做出的点击响应。
-(void) itemInfoHandler:(AnimalManagementButtonItem *) itemButton
{
	//结婚的响应
	if(managementType == @"animalMarry")
	{
		BOOL ret = NO;
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		NSString *aniID;
		DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:itemButton.animalID];
		
		for (int i = 0; i < [[DataEnvironment sharedDataEnvironment].animalIDs count]; i ++) {
			aniID = [animalIDs objectAtIndex:i];
			DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			//if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender && aniID != leftAnimalID && aniID != rightAnimalID)
			if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender)
			{
				ret = YES;
				break;
			}
		}
		if(!ret) //没有可以结婚的,弹出窗口
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可以结婚的动物!"];
		}
		else 
		{
//			//判断是否首次加载
//			if (animalToMateInfoPanel == nil) {
//				animalToMateInfoPanel = [[AnimalManageToMateInfoPanel alloc] initWithItem:itemButton.itemId type:itemButton.itemType animalID:itemButton.animalID setTarget:self];
//				animalToMateInfoPanel.position = ccp(self.contentSize.width/2, animalToMateInfoPanel.contentSize.height/2);
//				[self addChild:animalToMateInfoPanel z:20];
//			}
//			else {//TODO: 第二次加载需要完善
//				[animalToMateInfoPanel updateInfoPanel:itemButton];
//				//[animalToMateInfoPanel updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
//				//***[animalToMateInfoPanel updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
//				animalToMateInfoPanel.position = ccp(self.contentSize.width/2, animalToMateInfoPanel.contentSize.height/2);
//			}
		}
	}
	//离婚的响应
	else 
	{
//		if (animalToMateOrDisapart == nil) {
//			animalToMateOrDisapart = [[AniamalManagementMateOrDisapart alloc] initWithItem:itemButton.itemId type:itemButton.itemType animalID:itemButton.animalID setTarget:self];
//			animalToMateOrDisapart.position = ccp(self.contentSize.width/2, animalToMateOrDisapart.contentSize.height/2);
//			[self addChild:animalToMateOrDisapart z:20];
//		}
//		else {	//TODO: 第二次加载需要完善	
//			//[animalToMateInfoPanel updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
//			[animalToMateOrDisapart updateInfoPanel:itemButton];
//			animalToMateOrDisapart.position = ccp(self.contentSize.width/2, animalToMateOrDisapart.contentSize.height/2);
//		}
	}
}



-(void) generatePage
{
	NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
	NSMutableArray* buyTypeArray = [[NSMutableArray alloc] init];
	NSMutableArray* priceArray = [[NSMutableArray alloc] init];
	
	switch (tabFlag) {
		case ANIMAL_MATEORMARRY_POPVIEW:{
	//动物结婚
	if (tabFlagType == @"animalMarry") {
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		DataModelOriginalAnimal *originAnimal;
		NSString *aniID;

		DataModelAnimal *serverAnimalData2;
		for (int i =0; i< [[DataEnvironment sharedDataEnvironment].animalIDs count]; i ++) {
			originAnimal = [animalIDs objectAtIndex:i];
			aniID = [animalIDs objectAtIndex:i];
			serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
			NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];
			[picFileNameArray addObject:picFileName];
		}
		[myPopView initWithItem:picFileNameArray];
	}
	//动物离婚
	if (tabFlagType == @"animalMate") {
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		DataModelOriginalAnimal *originAnimal;
		NSString *aniID;
		
		int kTemp = 0;
		for(int i = 0 ;i <[[DataEnvironment sharedDataEnvironment].animalIDs count];i++)
		{
			originAnimal = [animalIDs objectAtIndex:i];
			aniID = [animalIDs objectAtIndex:i];
			DataModelAnimal *serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			if(serverAnimalData2.coupleAnimalId != nil)
			{
				NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
				NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
				NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];

				kTemp++;
				[picFileNameArray addObject:picFileName];
			}
			[myPopView initWithItem:picFileNameArray];
		}
	}
		}
			break;
		default :
			break;
	}
	
}


//按着tab的类型，请求数据
//动物结婚和婚姻管理。
- (void) btnShopButtonHandler{
	
//	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	tabFlag = ANIMAL_MATEORMARRY_POPVIEW;
	[myPopView addView2Window];
	[self generatePage];
}


- (void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	switch (tabFlag) {
		case SHOP_POPVIEW:{
			
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			itemArray = [itemDic allKeys];
		}
			break;
		default:
			break;
	}
	
	[self generatePage];
}

- (void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

- (void) dealloc{
	
	[myPopView release];
	
	[super dealloc];
}
@end