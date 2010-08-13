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
		[myPopView setM_npopViewType:ANIMAL_MATEORMARRY_POPVIEW];
		
		
		CGRect rect1 = CGRectMake(160, 75, 65.f, 28.f);
		CGRect rect2 = CGRectMake(225, 75, 80.f, 28.f);
		
		NSMutableArray* foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect1]];
		[foo addObject:[NSValue valueWithCGRect:rect2]];
		
		NSArray* title = [NSArray arrayWithObjects: 
						  @"结婚",
						  @"婚姻管理",
						  nil];
		[self initWithBtn:foo Title:title];
		[foo release];
		foo = nil;
		
		currentTagFlag = @"动物";
	}
	
	return self;
}

-(void) generatePage
{
	NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
	NSMutableArray* buyTypeArray = [[NSMutableArray alloc] init];
	NSMutableArray* priceArray = [[NSMutableArray alloc] init];
	
	switch (tabFlag)
	{
		case 0:
		{
			NSDictionary* originalAnimalsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			DataModelOriginalAnimal* originalAnimals;
			NSArray* animalArray = [originalAnimalsDic allKeys];
			NSNumber* gender;
			NSMutableArray* sexNameArray = [[NSMutableArray alloc] init];
			
			for (int i = 0; i < [animalArray count]; i ++) 
			{
				originalAnimals = [originalAnimalsDic objectForKey:[animalArray objectAtIndex:i]];
				DataModelOriginalAnimal* dataModelOriginalAnimalToshow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:originalAnimals.originalAnimalId];			
				
				if ([dataModelOriginalAnimalToshow.originalAnimalId intValue] > 50) 
				{
					gender = [NSNumber numberWithInt:1];
				}
				else 
				{
					gender = [NSNumber numberWithInt:0];
				}
				[sexNameArray addObject:gender];
				
			}
			[myPopView setSexArray:sexNameArray];
			
			
			//动物结婚
			NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
			DataModelOriginalAnimal *originAnimal;
			NSString *aniID;
			
			DataModelAnimal *serverAnimalData2;
			for (int i =0; i< [[DataEnvironment sharedDataEnvironment].animalIDs count]; i ++) 
			{
				originAnimal = [animalIDs objectAtIndex:i];
				aniID = [animalIDs objectAtIndex:i];
				serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
				NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
				[picFileNameArray addObject:picFileName];
			
				
				[myPopView.stoAnimalsArray addObject:originAnimal];
			}
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[buyTypeArray release];
			buyTypeArray = nil;
			[priceArray release];
			priceArray = nil;
		}
			break;
			//动物离婚
		case 1:
		{
			
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
					NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
					
					kTemp++;
					[picFileNameArray addObject:picFileName];
				}
				
			}
			[myPopView initWithItem:picFileNameArray];
			
		}
			break;
		default:
			break;
	}
	[myPopView setTabFlag:tabFlag];
}


//按着tab的类型，请求数据
//动物结婚和婚姻管理。
- (void) marryAndMateButtonHandler{
	
//	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
	tabFlag = 0;
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
			//[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
		{
			tabFlag = 0;
			[self generatePage];
		}
			break;
			
		case 1:
		{
			tabFlag = 1;
			[self generatePage];
		}
			//[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackGetAllAnimals:" AndFailedSel:@"faultCallback:"];
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