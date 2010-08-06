//
//  SaleEggsView.m
//  zoo
//
//  Created by Hunk on 10-8-6.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "SaleEggsView.h"
#import "DataEnvironment.h"
#import "DataModelStorageEgg.h"


@implementation SaleEggsView

- (id) init
{
	if ( (self = [super init]) )
	{
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 150, 280, 100)];
		[myPopView setSubSize:CGSizeMake(40, 40)];
		[myPopView setM_nlistCount:1];
		[myPopView setM_npopViewType:SHOP_POPVIEW];
		
		CGRect rect = CGRectMake(0, 20, 75.f, 75.f);
		NSMutableArray *foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect]];
		[myPopView initWithBtn:foo];
		[foo release];
		foo = nil;
		
		eggEnNameArray = [[NSArray alloc] initWithObjects:@"craneEgg.png",@"duckEgg.png",@"gooseEgg.png",@"henEgg.png",@"magpieEgg.png",@"mallardEgg.png",@"mandarinduckEgg.png",@"parrotEgg.png",@"peahenEgg.png",@"pheasantEgg.png",@"pigeonEgg.png",@"swanEgg.png",@"turkeyEgg.png",@"wildgooseEgg.png",@"mallardEgg.png",@"pigeonEgg.png",nil];
	}
	
	return self;	
}

- (void) saleEggsButtonHandler
{
	NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];
//	if (tabFlag == @"普通蛋") 
//	{
		
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
//	}
//	else if(tabFlag == @"受精蛋")
//	{
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultZygCallback:" AndFailedSel:@"faultCallback:"];
//	}
	
	
	
//	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	tabFlag = SHOP_POPVIEW;
	[myPopView addView2Window];
}

- (void) resultCallback:(NSObject *)value
{
	NSDictionary* storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
	
	DataModelStorageEgg* storageEgg;
	NSArray* eggsArray = [storageEggDic allKeys];
	
	NSMutableArray* arrTemp = [[NSMutableArray alloc]init];
	for(int i = 0; i < [eggsArray count]; i++)
	{
		storageEgg = [storageEggDic objectForKey:[eggsArray objectAtIndex:i]];
		
		int eggImgId = [storageEgg.eggImgId intValue];
		
		NSString *picName = [NSString stringWithFormat:@"%@", [eggEnNameArray objectAtIndex:eggImgId]];
	
		[arrTemp addObject:picName];
	}
	
	[myPopView initWithItem:arrTemp];
}

- (void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}


//m_nEggsType

-(void)dealloc
{
	[super dealloc];
}

@end