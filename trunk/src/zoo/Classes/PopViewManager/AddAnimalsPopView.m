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
		
		
		CGRect rect1 = CGRectMake(160, 75, 65.f, 28.f);
		CGRect rect2 = CGRectMake(225, 75, 85.f, 28.f);
		
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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:SaleEggs object:nil];
	}
	
	return self;
}

//点击动物仓库按钮，弹出来仓库里面的动物。
- (void) btnShopButtonHandler{
	tabFlag = ANIMAL_WAREHOUSE;
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
	
	[myPopView addView2Window];
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
			}
			[myPopView setSexArray:sexNameArray];
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[sexNameArray release];
			sexNameArray = nil; 
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
				}
			[myPopView setSexArray:sexNameArray];
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[sexNameArray release];
			sexNameArray = nil;
		}
			break;
			
		default:
			break;
	}
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:SaleEggs object:nil];
	
	[super dealloc];
}

//add by lancy
- (void) reloadData:(NSNotification *)aNotification{
	
	for (UIView *subview in [myPopView m_ppopView].subviews) 
	{
		[subview removeFromSuperview];
	}
	
	NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];	
	
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
