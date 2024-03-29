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
#import "DataModelStorageZygoteEgg.h"

NSString *SaleEggs = @"SALE_EGGS";

@implementation SaleEggsView

- (id) init
{
	if ( (self = [super init]) )
	{
		myPopView = [[popViewManager alloc] init];
		[myPopView setPopViewFrame:CGRectMake(100, 150, 280, 100)];
		[myPopView setSubSize:CGSizeMake(50, 50)];
		[myPopView setM_nlistCount:1];
		[myPopView setM_npopViewType:EGG_WAREHOUSE_POPVIEW];
		
		UIImageView* logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"仓库LOGO.png"]];
		logoImage.frame = CGRectMake(90, 68, 80, 35);
		[myPopView.view addSubview:logoImage];
		[logoImage release];
		logoImage = nil;
		
		CGRect rect1 = CGRectMake(175, 80, 65.f, 23.f);
		CGRect rect2 = CGRectMake(240, 80, 65.f, 23.f);
		
		NSMutableArray* foo = [[NSMutableArray alloc] init];
		[foo addObject:[NSValue valueWithCGRect:rect1]];
		[foo addObject:[NSValue valueWithCGRect:rect2]];
		
		NSArray* title = [NSArray arrayWithObjects: 
						  @"普通蛋",
						  @"受精蛋",
						  nil];
		[self initWithBtn:foo Title:title];
		
		[foo release];
		foo = nil;
		
		eggEnNameArray = [[NSArray alloc] initWithObjects:@"craneEgg.png",@"duckEgg.png",@"gooseEgg.png",@"henEgg.png",@"magpieEgg.png",@"mallardEgg.png",@"mandarinduckEgg.png",@"parrotEgg.png",@"peahenEgg.png",@"pheasantEgg.png",@"pigeonEgg.png",@"swanEgg.png",@"turkeyEgg.png",@"wildgooseEgg.png",@"mallardEgg.png",@"pigeonEgg.png",nil];
		StorageEggArray = [[NSMutableArray alloc] init];
		tabFlag = SALE_COMMONEGGS;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:SaleEggs object:nil];
	}
	
	return self;	
}

- (void) saleEggsButtonHandler
{
	NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];

	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
	[myPopView setTabFlag:SALE_COMMONEGGS];
	[myPopView addView2Window];
}

- (void) resultCallback:(NSObject *)value
{
	NSDictionary* storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
	
	[StorageEggArray removeAllObjects];
	DataModelStorageEgg* storageEgg;
	NSArray* eggsArray = [storageEggDic allKeys];
	[StorageEggArray removeAllObjects];
	
	NSMutableArray* arrTemp = [[NSMutableArray alloc]init];
	for(int i = 0; i < [eggsArray count]; i++)
	{
		storageEgg = [storageEggDic objectForKey:[eggsArray objectAtIndex:i]];
		
		int eggImgId = [storageEgg.eggImgId intValue];
		
		NSString *picName = [NSString stringWithFormat:@"%@", [eggEnNameArray objectAtIndex:eggImgId]];
	
		[arrTemp addObject:picName];
		[StorageEggArray addObject:storageEgg];
	}
	
	[myPopView setStorageEggArray:StorageEggArray];
	[myPopView initWithItem:arrTemp];
}

- (void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

- (void)initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle
{
	for (int i = 0; i < [arrayBtn count]; i++) 
	{
		//show position
		UIButton* topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[topBtn setBackgroundImage:[UIImage imageNamed: @"tab.png"] forState:UIControlStateNormal];
		[topBtn setTitle:[arrayTitle objectAtIndex:i] forState:UIControlStateNormal];
		topBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
		[topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		CGRect btnFrame = [[arrayBtn objectAtIndex:i] CGRectValue];
		topBtn.frame = btnFrame;
		[topBtn addTarget:self action:@selector(topBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		topBtn.tag = 3 + i;
		[myPopView.view addSubview:topBtn];
	}
}

- (void) topBtnSelected:(id)sender
{
	UIButton *selectedBtn = (UIButton *)sender;
	tabFlag = selectedBtn.tag;
	
	for (UIView *subview in [myPopView m_ppopView].subviews) 
	{
		[subview removeFromSuperview];
	}
	
	NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];	
	
	switch (tabFlag) 
	{
		case 3:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
		case 4:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultOfZygoteEggCallback:" AndFailedSel:@"faultOfZygoteEggCallback:"];
			break;
		default:
			break;
	}
	
	[myPopView setTabFlag:tabFlag];
}


-(void)resultOfZygoteEggCallback:(id)sender
{
	NSDictionary* storageZygoteEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
	
	DataModelStorageZygoteEgg* storageZygoteEgg;
	NSArray* eggsArray = [storageZygoteEggDic allKeys];
	[StorageEggArray removeAllObjects];
	
	NSMutableArray* arrTemp = [[NSMutableArray alloc]init];
	for(int i = 0; i < [eggsArray count]; i++)
	{
		storageZygoteEgg = [storageZygoteEggDic objectForKey:[eggsArray objectAtIndex:i]];
		
		NSString *picName = [NSString stringWithFormat:@"%@",storageZygoteEgg.eggId];

		NSString *picFileName = [NSString stringWithFormat:@"zygote%@.png",picName];
				
		[arrTemp addObject:picFileName];
		[StorageEggArray addObject:storageZygoteEgg];
	}
	
	[myPopView setStorageEggArray:StorageEggArray];	
	[myPopView initWithItem:arrTemp];
}

-(void)dealloc
{
	[myPopView release];
	[StorageEggArray release];
	[eggEnNameArray release];
	
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
	
	switch (tabFlag) 
	{
		case SALE_COMMONEGGS:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			break;
		case SALE_ZYGOTEEGGS:
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultOfZygoteEggCallback:" AndFailedSel:@"faultOfZygoteEggCallback:"];
			break;
		default:
			break;
	}
}

@end
