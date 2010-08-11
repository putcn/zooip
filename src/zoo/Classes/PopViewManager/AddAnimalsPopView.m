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

NSString *AddAnimals = @"ADD_ANIMALS";

@implementation AddAnimalsPopView



- (id) init{
	
	if ( (self = [super init]) ){
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 120, 280, 160)];
		[myPopView setSubSize:CGSizeMake(50, 50)];
		[myPopView setM_nlistCount:1];
		[myPopView setM_npopViewType:ANIMAL_WAREHOUSE_POPVIEW];
		
		
		UIImageView* logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"depot_logo.png"]];
		logoImage.frame = CGRectMake(90, 68, 80, 35);
		[myPopView.view addSubview:logoImage];
		[logoImage release];
		logoImage = nil;
		
		CGRect rect1 = CGRectMake(165, 80, 65.f, 23.f);
		CGRect rect2 = CGRectMake(230, 80, 85.f, 23.f);
		
		NSMutableArray* foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect1]];
		[foo addObject:[NSValue valueWithCGRect:rect2]];
		
		NSArray* title = [NSArray arrayWithObjects: 
						  @"动物",
						  @"拍来动物",
						  nil];
		[self initWithBtn:foo Title:title];
		[foo release];
		foo = nil;
		
		tabFlag = ANIMAL_WAREHOUSE;
		stoAnimalsArray = [[NSMutableArray alloc] init];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAimalToFrame:) name:AddAnimals object:nil];
	}
	
	return self;
}

//点击动物仓库按钮，弹出来仓库里面的动物。
- (void) btnShopButtonHandler{
	tabFlag = ANIMAL_WAREHOUSE;
	[stoAnimalsArray removeAllObjects];
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
	
	[myPopView addView2Window];
}

//失败响应
-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}


-(void) generatePage
{	
	[stoAnimalsArray removeAllObjects];
	
	NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
	NSMutableArray* sexNameArray = [[NSMutableArray alloc] init];
	NSMutableArray* countArray = [[NSMutableArray alloc] init];
	
	switch (tabFlag) {
		case ANIMAL_WAREHOUSE:
		{
			NSDictionary *storageAnimal = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
			DataModelStorageAnimal *stoAnimals;
			NSArray *animalArray = [storageAnimal allKeys];
			NSNumber *gender;
			
			for (int i = 0; i < [animalArray count]; i ++) {
				stoAnimals = [storageAnimal objectForKey:[animalArray objectAtIndex:i]];
				DataModelOriginalAnimal *serverAnimalToshow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoAnimals.originalAnimalId];			
				
				if ([serverAnimalToshow.originalAnimalId intValue] > 50) {
					gender = [NSNumber numberWithInt:1];
				}
				else {
					gender = [NSNumber numberWithInt:0];
				}
				
				NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalToshow.picturePrefix];
				[picFileNameArray addObject:picFileName];
				[sexNameArray addObject:gender];
				[stoAnimalsArray addObject:stoAnimals];
				[countArray addObject:[NSNumber numberWithInt: stoAnimals.amount]];
			}
			[myPopView setSexArray:sexNameArray];
			[myPopView setStorageAniArray:countArray];
			[myPopView initWithItem:picFileNameArray];
			
		}
			break;
		case BUY_ANIMAL_WAREHOUSE:
		{
				NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
				DataModelStorageAuctionAnimal *stoauAnimals;
				NSArray *animalArray = [auctionAnimals allKeys];
				NSNumber *gender;
				DataModelOriginalAnimal *serverAnimalShow;
				for (int i = 0; i < [animalArray count]; i ++) {
					stoauAnimals = [auctionAnimals objectForKey:[animalArray objectAtIndex:i]];
					serverAnimalShow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoauAnimals.originalAnimalId];
					
					if ([serverAnimalShow.originalAnimalId intValue] > 50) {
						gender = [NSNumber numberWithInt:1];
					}
					else {
						gender = [NSNumber numberWithInt:0];
					}
					
					NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalShow.picturePrefix];
					
					[picFileNameArray addObject:picFileName];
					[sexNameArray addObject:gender];
					[stoAnimalsArray addObject:stoauAnimals];
				}
			[myPopView setSexArray:sexNameArray];
			[myPopView setStorageAniArray:countArray];
			[myPopView initWithItem:picFileNameArray];

		}
			break;
			
		default:
			break;
	}
	
	[picFileNameArray release];
	picFileNameArray = nil;
	[sexNameArray release];
	sexNameArray = nil;
	[countArray release];
	countArray = nil;
	
	[myPopView setTabFlag:tabFlag];

}

- (void)initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle{
	
	for (int i = 0; i < [arrayBtn count]; i++) {
		
		//show position
		UIButton* topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[topBtn setBackgroundImage:[UIImage imageNamed: @"tab.png"] forState:UIControlStateNormal];
		[topBtn setTitle:[arrayTitle objectAtIndex:i] forState:UIControlStateNormal];
		topBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
		[topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		CGRect btnFrame = [[arrayBtn objectAtIndex:i] CGRectValue];
		topBtn.frame = btnFrame;
		[topBtn addTarget:self action:@selector(topBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		topBtn.tag = ANIMAL_WAREHOUSE+i;
		[myPopView.view addSubview:topBtn];
	}
}

-(void)resultCallbackGetAllAnimals:(NSObject *)value
{
	[self generatePage];
	
}

- (void) topBtnSelected:(id)sender{
	
	UIButton *selectedBtn = (UIButton *)sender;
	tabFlag = selectedBtn.tag;
	
	for (UIView *subview in [myPopView m_ppopView].subviews) {
		[subview removeFromSuperview];
	}
	
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
		
	switch (tabFlag) {
		case ANIMAL_WAREHOUSE:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
			break;
			
		case BUY_ANIMAL_WAREHOUSE:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
			break;
			
		default:
			break;
	}
}

- (void) dealloc{
	
	[myPopView release];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:AddAnimals object:nil];
	
	[super dealloc];
}

//add by lancy
- (void) addAimalToFrame:(NSNotification *)aNotification{
	
	for (UIView *subview in [myPopView m_ppopView].subviews) 
	{
		[subview removeFromSuperview];
	}
	
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	NSDictionary* params;
	int index = [myPopView touchIndex];
	
	switch (tabFlag) {
		case ANIMAL_WAREHOUSE:{
			
			DataModelStorageAnimal* storageAnimal = [stoAnimalsArray objectAtIndex:index];
			NSString* adultBirdStorageId = storageAnimal.adultBirdStorageId;
			params = [NSDictionary dictionaryWithObjectsAndKeys:
					  farmId,				@"farmId",
					  adultBirdStorageId,	@"adultBirdStorageId",
					  nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
			break;
			
		case BUY_ANIMAL_WAREHOUSE:{
			
			DataModelOriginalAnimal *serverAnimalShow = [stoAnimalsArray objectAtIndex:index];
			NSString* auctionBirdStorageId = serverAnimalShow.originalAnimalId;
			params = [NSDictionary dictionaryWithObjectsAndKeys:
					  farmId,					@"farmId",
					  auctionBirdStorageId,		@"auctionBirdStorageId",
					  nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAuctionAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
			break;
			
		default:
			break;
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
		case BUY_ANIMAL_WAREHOUSE:{
			
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
			break;
			
		case ANIMAL_WAREHOUSE:{
			
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
			break;
			
		default:
			break;			
	}
	
	itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	itemArray = [itemDic allKeys];
	
	NSLog(@"操作已成功!");
	
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
	
	switch (tabFlag) {
		case ANIMAL_WAREHOUSE:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
			break;
			
		case BUY_ANIMAL_WAREHOUSE:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
			break;
			
		default:
			break;
	}
}

@end
