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


@implementation ShopPopView


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
	}
	
	return self;
}

- (void) btnShopButtonHandler{
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	tabFlag = SHOP_POPVIEW;
	[myPopView addView2Window];
}

//生成商品页面
- (void) generatePage
{
	switch (tabFlag) {
		case SHOP_POPVIEW:{
			
			
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
			int nTemp;
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
			
			
			NSArray* animalArray = [NSArray arrayWithArray:animalArrayTemp];
			NSMutableArray* picFileNameArray = [[NSMutableArray alloc] init];
			
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
			}
			[myPopView initWithItem:picFileNameArray];
			
			//			[picFileNameArray release];
			//			picFileNameArray = nil;
		}		
			
			break;
		default:
			break;
	}
	
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
