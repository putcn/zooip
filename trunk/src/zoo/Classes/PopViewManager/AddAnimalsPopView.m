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
		
		
		CGRect rect1 = CGRectMake(160, 75, 65.f, 28.f);
		CGRect rect2 = CGRectMake(225, 75, 65.f, 28.f);
		CGRect rect3 = CGRectMake(290, 75, 65.f, 28.f);
		
		NSMutableArray* foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect1]];
		[foo addObject:[NSValue valueWithCGRect:rect2]];
		[foo addObject:[NSValue valueWithCGRect:rect3]];
		
		NSArray* title = [NSArray arrayWithObjects: 
						  @"动物",
						  @"饲料",
						  @"道具",
						  nil];
		[self initWithBtn:foo Title:title];
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
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
	}
	else if(currentTagFlag == @"拍来动物"){
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
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

-(void)resultCallbackGetAllAnimals:(NSObject *)value
{
	[self generatePage];
	if (currentTagFlag == @"动物") {
		
		
	}
	else {
		
	}
	
//	NSDictionary *itemDic;
//	NSArray *itemArray;
//	switch (tabFlag) {
//		case SHOP_POPVIEW:{
//			
//			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
//			itemArray = [itemDic allKeys];
//		}
//			break;
//		default:
//			break;
//	}
//	
//	[self generatePage];

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
						gender = @"公";
						//male
					}
					else {
						gender = @"母";
						//female
					}
					
					NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalToshow.scientificNameCN];
					NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalToshow.picturePrefix];
					[picFileNameArray addObject:picFileName];
					[sexNameArray addObject:gender];
				}
				[myPopView initWithItem:picFileNameArray];
				[myPopView setSexArray:sexNameArray];
			
			}
			if (currentTagFlag == @"拍来动物") {
				NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
				DataModelStorageAuctionAnimal *stoauAnimals;
				NSArray *animalArray = [auctionAnimals allKeys];
				NSString *gender;
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
					
					[picFileNameArray addObject:picFileName];
					[sexNameArray addObject:gender];
				}
				[myPopView initWithItem:picFileNameArray];
				[myPopView setSexArray:sexNameArray];
			}
			break;
		default:
			break;
		}
			
	}
}

- (void)initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle{
	
	for (int i = 0; i < [arrayBtn count]; i++) {
		
		//show position
		UIButton* topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[topBtn setBackgroundImage:[UIImage imageNamed: @"tab.png"] forState:UIControlStateNormal];
		[topBtn setTitle:[arrayTitle objectAtIndex:i] forState:UIControlStateNormal];
		[topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		CGRect btnFrame = [[arrayBtn objectAtIndex:i] CGRectValue];
		topBtn.frame = btnFrame;
		[topBtn addTarget:self action:@selector(topBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		topBtn.tag = i;
		[myPopView.view addSubview:topBtn];
	}
}

- (void) topBtnSelected:(id)sender{
	
	UIButton *selectedBtn = (UIButton *)sender;
	tabFlag = selectedBtn.tag;
	
	for (UIView *subview in [myPopView m_ppopView].subviews) {
		[subview removeFromSuperview];
	}
	
	switch (tabFlag) {
		case 0:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
			
		case 1:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllFoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
			
		case 2:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllGoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
			
		default:
			break;
	}
}


- (void) dealloc{
	
	[myPopView release];
	
	[super dealloc];
}

@end
