//
//  ShopPopView.m
//  zoo
//
//  Created by shen lancy on 10-8-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShopPopView.h"
#import "ServiceHelper.h"
#import "StorageManageToolbar.h"
#import "Common.h"


@implementation ShopPopView


- (id) init{
	
	if ( (self = [super init]) ){
		
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 120, 280, 160)];
		[myPopView setSubSize:CGSizeMake(40, 40)];
		[myPopView setM_nlistCount:2];
		[myPopView setM_npopViewType:SHOP_POPVIEW];
		
		UIImageView* logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_logo.png"]];
		logoImage.frame = CGRectMake(90, 68, 80, 35);
		[myPopView.view addSubview:logoImage];
		[logoImage release];
		logoImage = nil;
		
		CGRect rect1 = CGRectMake(165, 80, 65.f, 23.f);
		CGRect rect2 = CGRectMake(230, 80, 65.f, 23.f);
		CGRect rect3 = CGRectMake(295, 80, 65.f, 23.f);
		
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
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback2:" AndFailedSel:@"faultCallback:"];
	}
	
	return self;
}

- (void) btnShopButtonHandler{
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	tabFlag = BUY_ANIMAL;
	[myPopView addView2Window];
}

//生成商品页面
- (void) generatePage
{
	switch (tabFlag) {
		case BUY_ANIMAL:{
	
			NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			
			DataModelOriginalAnimal *originAnimal; //levelRequired
			NSArray *animalArrayTemp1 = [originAnimalDic allKeys];
			NSMutableArray* animalArrayTemp = [[NSMutableArray alloc] init];
			[animalArrayTemp addObjectsFromArray:animalArrayTemp1];
			
			NSMutableArray* arrOfLevel = [[NSMutableArray alloc]init];
			
			for(int i = 0; i < [animalArrayTemp count]; i++)
			{
				originAnimal = [originAnimalDic objectForKey:[animalArrayTemp objectAtIndex:i]];
				
				[arrOfLevel addObject:[NSNumber numberWithInt:originAnimal.levelRequired]];
			}
			
			// 冒泡排序
/*			int nTemp;
			NSString* strTemp;
			for(int j = 0; j <= [arrOfLevel count] - 1 ; j++)
			{
				for(int i = 0; i < [arrOfLevel count] - 1- j; i++)
				{
					if([[arrOfLevel objectAtIndex:i] intValue] >= [[arrOfLevel objectAtIndex:i+1] intValue])
					{
						nTemp = [[arrOfLevel objectAtIndex:i] intValue];
						strTemp = [animalArrayTemp objectAtIndex:i];
						
						int nRight = [[arrOfLevel objectAtIndex:i+1] intValue];
						NSString* strRight = [animalArrayTemp objectAtIndex:i + 1];
						
						[arrOfLevel replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:nRight]];
						[animalArrayTemp replaceObjectAtIndex:i withObject:strRight];
						
						[arrOfLevel replaceObjectAtIndex:i+1 withObject:[NSNumber numberWithInt:nTemp]];
						[animalArrayTemp replaceObjectAtIndex:i + 1 withObject:strTemp];
						
					}
				}
			}
*/			
			
			NSArray* animalArray = [NSArray arrayWithArray:animalArrayTemp];
			NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
			NSMutableArray* buyTypeArray = [[NSMutableArray alloc] init];
			NSMutableArray* priceArray = [[NSMutableArray alloc] init];
			
			for (int i = 0; i < [animalArray count]; i ++) 
			{
				originAnimal = [originAnimalDic objectForKey:[animalArray objectAtIndex:i]];
				
				int buyType = 0;
				NSString *price = [NSString stringWithFormat:@"%d",originAnimal.basePrice];
				if (originAnimal.antsPrice > 0) {
					buyType = 1;
					price = [NSString stringWithFormat:@"%d",originAnimal.antsPrice];
				}
				
				//根据动物的originalAnimalId生成ItemButton
				NSString *picFileName = [NSString stringWithFormat:@"%@.png",originAnimal.picturePrefix];				

				[picFileNameArray addObject:picFileName];
				[buyTypeArray addObject:[NSNumber numberWithInt:buyType]];
				[priceArray addObject:price];
			}
			[myPopView setBuyTypeArray:buyTypeArray];
			[myPopView setPriceArray:priceArray];
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[buyTypeArray release];
			buyTypeArray = nil;
			[priceArray release];
			priceArray = nil;
		}		
			break;
			
		case BUY_FOODS:{
			
			NSDictionary *foodDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
			DataModelFood *dataModelFood;
			NSArray *foodArray = [foodDic allKeys];
			
			NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
			NSMutableArray* buyTypeArray = [[NSMutableArray alloc] init];
			NSMutableArray* priceArray = [[NSMutableArray alloc] init];
			
			for (int i = 0; i < [foodArray count]; i ++) {
				dataModelFood = [foodDic objectForKey:[foodArray objectAtIndex:i]];
				
				int buyType = 0;
				NSString *price = [NSString stringWithFormat:@"%d",dataModelFood.foodPrice];
				if (dataModelFood.antsRequired > 0) {
					buyType = 1;
					price = [NSString stringWithFormat:@"%d",dataModelFood.antsRequired];
				}
				NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",dataModelFood.foodImg];
				
				[picFileNameArray addObject:picFileName];
				[buyTypeArray addObject:[NSNumber numberWithInt:buyType]];
				[priceArray addObject:price];
			}
			
			[myPopView setBuyTypeArray:buyTypeArray];
			[myPopView setPriceArray:priceArray];
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[buyTypeArray release];
			buyTypeArray = nil;
			[priceArray release];
			priceArray = nil;
		}
			break;
			
		case BUY_GOODS:{
			
			NSDictionary *goodsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
			DataModelGood *dataModelGood;
			NSArray *goodsArray = [goodsDic allKeys];
			
			NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
			NSMutableArray* buyTypeArray = [[NSMutableArray alloc] init];
			NSMutableArray* priceArray = [[NSMutableArray alloc] init];
			
			for (int i = 0; i < [goodsArray count]; i ++) {
				dataModelGood = [goodsDic objectForKey:[goodsArray objectAtIndex:i]];
				int buyType = 0;
				NSString *price = [NSString stringWithFormat:@"%d",dataModelGood.goodsGoldenPrice];
				if (dataModelGood.goodsAntsPrice > 0) {
					buyType = 1;
					price = [NSString stringWithFormat:@"%d",dataModelGood.goodsAntsPrice];
				}
				NSString *picFileName;
				if ([dataModelGood.goodsPicture intValue]== 2) {
					picFileName = @"tibentanmastiff_rest_01.png";
				}
				else if([dataModelGood.goodsPicture intValue]== 1)
				{	
					picFileName = @"chinemy_walk_left_01.png";
				}
				
				[picFileNameArray addObject:picFileName];
				[buyTypeArray addObject:[NSNumber numberWithInt:buyType]];
				[priceArray addObject:price];
			}
			[myPopView setBuyTypeArray:buyTypeArray];
			[myPopView setPriceArray:priceArray];
			[myPopView initWithItem:picFileNameArray];
			
			[picFileNameArray release];
			picFileNameArray = nil;
			[buyTypeArray release];
			buyTypeArray = nil;
			[priceArray release];
			priceArray = nil;		
		}
			break;
			
		default:
			break;
	}
	[myPopView setTabFlag:tabFlag];
}


- (void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	switch (tabFlag) {
		case BUY_ANIMAL:{
			
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			itemArray = [itemDic allKeys];
		}
			break;
			
		case BUY_FOODS:{
			
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
			itemArray = [itemDic allKeys];
		}
			break;
			
		case BUY_GOODS:{
			
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
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
		topBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
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
		case BUY_ANIMAL:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
			
		case BUY_FOODS:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllFoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
			
		case BUY_GOODS:
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

- (void) resultCallback2:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	
	itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	itemArray = [itemDic allKeys];
}
@end
