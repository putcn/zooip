//
//  GController.m
//  zoo
//
//  Created by shen lancy on 10-8-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecPopViewController.h"
#import "Common.h"
#import "DataEnvironment.h"
#import "ServiceHelper.h"
#import "FeedbackDialog.h"
#import "ItemInfoPane.h"
#import "GameMainScene.h"

#import "DataModelOriginalAnimal.h"
#import "DataModelAnimal.h"

@interface SecPopViewController(OtherFunctions)
- (void) buyAnimals;
- (void) buyFoods;
- (void) buyGoods;

-(void)saleCommonEggs;
-(void)saleZogyteEggs;
-(void)antsChoose;
@end 


@implementation SecPopViewController
@synthesize animalIDArray;
@synthesize m_npopViewType, m_ntabFlag, itemId, curr_itemType, tempCount,labelString;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		showImage = [UIImageView alloc];
		
		animalIDArray = [[NSMutableArray alloc] init];
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	farmerId = [[NSString alloc] init];
	buyAniId = [[NSString alloc] init];
	
	
	//
	NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	DataModelOriginalAnimal *originAnimal; //levelRequired
	NSArray *animalArrayTemp1 = [originAnimalDic allKeys];
	animalArrayTemp = [[NSMutableArray alloc] init];
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
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[labelString release];
	labelString = nil;
	[farmerId release];
	farmerId = nil;
	[buyAniId release];
	buyAniId = nil;
	
	[showImage release];
	showImage = nil;
	[iconImage release];
	iconImage = nil;
	[priceLabel release];
	priceLabel = nil;
	[nameLabel release];
	nameLabel = nil;
	[describeLabel release];
	describeLabel = nil;
	[buySlider release];
	buySlider =nil;
	[countLabel release];
	countLabel = nil;
	[wrongLabel release];
	wrongLabel = nil;
	[OKButton release];
	OKButton = nil;
	
	[priceLabel release];
	priceLabel = nil;
	
	[animalArrayTemp release];
	animalArrayTemp = nil;
	
    [super dealloc];
}

// slown down or speed up the slide show as the slider is moved
- (IBAction)sliderAction:(id)sender
{
	UISlider* durationSlider = sender;
	NSString* showStr = @"选择了";
	NSString* finalRate = @"下公蛋的概率:";
	tempCount  = mixCount * [durationSlider value];
	switch (m_ntabFlag) {
		case BUY_ANIMAL:
			showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@"个动物"]];
			break;
			
		case BUY_FOODS:
			showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@"件商品"]];
			break;
			
		case BUY_GOODS:
			showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@"件商品"]];
			break;
		case SALE_COMMONEGGS:
		{
			showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@"个普通蛋"]];
			
			farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
			DataModelStorageEgg *storageEgg; 
			NSArray *storageEggArrayTemp = [storageEggDic allKeys];
			storageEgg = [storageEggDic objectForKey:[storageEggArrayTemp objectAtIndex:itemId]];
			NSString* describeStr;
			describeStr = @"单个售价:";
			describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"%d金蛋\n", storageEgg.eggPrice]];
			describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"总计收入:%d金蛋", tempCount*storageEgg.eggPrice]];
			describeLabel.numberOfLines = 2;
			describeLabel.text = describeStr;
			
			countLabel.text = [NSString stringWithFormat:@"%d", storageEgg.numOfProduct];
		}
			break;
		case Mate_Before_Marry:
		{
			int nRate = 0;
			
			if(tempCount > 0 && tempCount <= 1)
			{
				nRate = 6;
			}
			else if(tempCount > 1 && tempCount < 9)
			{
				if(tempCount % 2 == 0)
				{
					nRate = (tempCount / 2) * (6 + 5);
				}
				else
				{
					nRate = (tempCount / 2) * 6 + ((tempCount / 2) - 1 ) * 5;
				}
			}
			else if(tempCount == 9)
			{
				nRate = 50;
			}
			
		
			NSString* _showStr = [finalRate stringByAppendingString:[NSString stringWithFormat:@"%d%@",nRate,@""]];
			
			showStr = [_showStr stringByAppendingString:@"%"];
			CGFloat price = tempCount;
			
			int nPrice = price;
			
//			if(nPrice < 2)
//			{
//				nPrice = 0;
				NSString* strPrice = [NSString stringWithFormat:@"%d", nPrice];
				priceLabel.text = strPrice;
			//}
//			else
//			{
//				NSString* strPrice = [NSString stringWithFormat:@"%d", nPrice-2];
//				priceLabel.text = strPrice;
//			}
		}
			break;
			
		case Mate_After_Marry:
		{
			if(tempCount <= 1)
			{
				NSString* _showStr = [finalRate stringByAppendingString:[NSString stringWithFormat:@"%d%@",2,@""]];
				showStr = [_showStr stringByAppendingString:@"%"];
			}
			else
			{
				NSString* _showStr = [finalRate stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@""]];
				showStr = [_showStr stringByAppendingString:@"%"];
			}
						
			CGFloat price = tempCount / 2;
			
			int nPrice = price;
			
			if(nPrice < 1)
			{
				nPrice = 1;
				NSString* strPrice = [NSString stringWithFormat:@"%d", nPrice];
				priceLabel.text = strPrice;
			}
			else if(nPrice >= 1 && nPrice < 25)
			{
				NSString* strPrice = [NSString stringWithFormat:@"%d", nPrice];
				priceLabel.text = strPrice;
			}
			else 
			{
				NSString* strPrice = [NSString stringWithFormat:@"%d", nPrice + 1];
				priceLabel.text = strPrice;
			}
		}
			break;

		case SALE_ZYGOTEEGGS:
		//	showStr = [showStr stringByAppendingString:[NSString stringWithFormat:@"%d%@",tempCount,@"个受精蛋"]];
			break;
		default:
			break;
	}
	countLabel.text = showStr;
}

- (IBAction) OKSelected:(id)sender{
	
	switch (m_ntabFlag) {
		case BUY_ANIMAL:{
			
			//用蚂蚁购买
			if (tempPrice > 0) {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										buyAniId,									@"originalAnimalId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
			//用金币购买
			else {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										buyAniId,									@"originalAnimalId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];		
			}
		}
			break;
			
		case BUY_FOODS:{
			
			//用蚂蚁购买
			if (tempPrice > 0) {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										buyAniId,									@"foodId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
			//用金币购买
			else {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										buyAniId,									@"foodId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
		}
			
		case BUY_GOODS:{
			
			if ([buyAniId compare:@"1"] == NSOrderedSame) {
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,@"farmerId",
										buyAniId,@"goodsId",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyTurtleByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
			if ([buyAniId compare:@"2"] == NSOrderedSame){
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,@"farmerId",
										buyAniId,@"goodsId",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyDogByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];			
			}
		}
			break;
			
		case SALE_COMMONEGGS:
		{
			farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
			DataModelStorageEgg *storageEgg; 
			NSArray *storageEggArrayTemp = [storageEggDic allKeys];
			storageEgg = [storageEggDic objectForKey:[storageEggArrayTemp objectAtIndex:itemId]];
			
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
									farmerId,@"farmerId",
									storageEgg.eggId,@"eggId",
									[NSString stringWithFormat:@"%d",tempCount],@"amount",
									nil];
			
			NSLog(@"%@\n", params);
			
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellProduct WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			
		}
				break;
		case SALE_ZYGOTEEGGS:
		{
			farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *storageZygoteEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
			DataModelStorageZygoteEgg *storageZygoteEgg; 
			NSArray *storageZygoteEggArrayTemp = [storageZygoteEggDic allKeys];
			storageZygoteEgg = [storageZygoteEggDic objectForKey:[storageZygoteEggArrayTemp objectAtIndex:itemId]];
			
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
									farmerId,@"farmerId",
									storageZygoteEgg.zygoteStorageId,@"zygoteStorageId",
									[NSString stringWithFormat:@"%d",1],@"amount",
									nil];
			
			NSLog(@"%@\n", params);
			
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];			
		}
			break;
			
			//动物婚前交配
		case Mate_Before_Marry:
		{
			//组参数并发送service
			
			
			
			//toMateAnimal------action=marry
			//toMateAnimal------action=mate 	动物结婚
			//动物结婚前的交配 	farmId                    动物园ID
			//maleId                    公动物ID
			//femaleId                 母动物ID
			//
			//ants
			//蚂蚁数量
			
			//action                    操作行为（marry or mate）
			NSInteger nAnts = [priceLabel.text integerValue];
			NSString* str1 = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
			NSString* str2 = [animalIDArray objectAtIndex:0];
			NSString* str3 = [animalIDArray objectAtIndex:1];
			
			NSString* str4 = [NSString stringWithFormat:@"%d", nAnts];
			NSString* str5 = @"mate";
			
			NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
									str1, @"farmId",
									str2, @"maleId",
									str3, @"femaleId",
									str4, @"ants",
									str5, @"action",
									nil];

			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoMateAnimal 
												   WithParameters:params 
												 AndCallBackScope:self 
													AndSuccessSel:@"resultCallback:" 
													 AndFailedSel:@"faultCallback:"];
		}
			break;
			//动物婚后交配
		case Mate_After_Marry:
		{
			//组参数并发送service
			
			//**** 蚂蚁的数量需要传入
			
			NSInteger nAnts = [priceLabel.text integerValue];
			
			NSString *strfFarmerId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId;
						
			
			for(int i = 0;i < [animalIDArray count]; i++)
				NSLog(@"%@\n", [animalIDArray objectAtIndex:i]);
			
			// female
			NSString* strLeftAnimalID = [animalIDArray objectAtIndex:0];
			// male
			NSString* strRightAnimalID = [animalIDArray objectAtIndex:1];
			
			NSString* strAnts = [NSString stringWithFormat:@"%d", nAnts];
			
			NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
									strfFarmerId,@"farmerId",
									strLeftAnimalID, @"animalId",
									strAnts,@"ants",
									nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoFeedFemaleAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			
		}
			break;

		default:
			break;
	}
	


	[self.view removeFromSuperview];
}

- (IBAction) CancelSelected:(id)sender{
	
	[self.view removeFromSuperview];
}

- (void) setShowImageName:(NSString*)fileName{
	
	[showImage setImage:[UIImage imageNamed:fileName]];
	buySlider.value = 0.0;
	describeLabel.frame = CGRectMake(200, 165, 160, 60);
	
	switch (m_ntabFlag) {
		case BUY_ANIMAL:
			[self buyAnimals];
			break;
			
		case BUY_FOODS:
			[self buyFoods];
			break;
			
		case BUY_GOODS:
			[self buyGoods];
			break;
			
			// Add By Hunk
		case SALE_COMMONEGGS:
		{
			[self saleCommonEggs];
		}
			break;
		case SALE_ZYGOTEEGGS:
		{
			[self saleZogyteEggs];
		}
			break;
		case Mate_Before_Marry:
			[self antsChoose];
			break;
		case Mate_After_Marry:
			[self antsChoose];
			break;
		default:
			break;
	}
	
}

-(void)antsChoose
{	
	//选择蚂蚁面板的初始化
	buySlider.hidden = NO;
	countLabel.hidden = NO;
	// Title
	UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 100, 80, 40)];
	[titleLabel setBackgroundColor:[UIColor clearColor]];
	titleLabel.text = @"配种";
	[self.view addSubview:titleLabel];
	[titleLabel release];
	titleLabel = nil;
	
	myAntsCurrency = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.antsCurrency;
	myGoldenEgg = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.goldenEgg;
	
	//get data
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	//NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	//DataModelOriginalAnimal *originAnimal; 
	//NSArray *_animalArrayTemp = [originAnimalDic allKeys];
	//originAnimal = [originAnimalDic objectForKey:[_animalArrayTemp objectAtIndex:itemId]];
//	
//	buyAniId = originAnimal.originalAnimalId;
//	tempCount = 1;
//	tempPrice = originAnimal.antsPrice;
	
	NSString* describeString = @"   性别：";
	
	if(m_ntabFlag == Mate_Before_Marry)
		mixCount = 9;
	else
		mixCount = 50;
	
	[iconImage setImage:[UIImage imageNamed:@"金蚂蚁.png"]];
	tempPrice = 1;
	if (tempPrice > myAntsCurrency) 
	{
		wrongLabel.hidden = NO;
		OKButton.enabled = NO;
	}
	else 
	{
		wrongLabel.hidden = YES;
		OKButton.enabled = YES;
	}
	
	//上面名字的显示
	nameLabel.text = @"";
	
	//价格的显示
	if(m_ntabFlag == Mate_Before_Marry)
		priceLabel.text = @"0";
	else
		priceLabel.text = @"1";
	
	describeString = @"选择当前产蛋周期下公蛋的概率";
	describeLabel.numberOfLines = 3;
	describeLabel.text = describeString;
	if(m_ntabFlag == Mate_Before_Marry)
		countLabel.text = @"下公蛋的概率:0%";
	else
		countLabel.text = @"下公蛋的概率:2%";
}


-(void) resultCallback:(NSObject *)value
{
	switch (m_npopViewType) {
		case SHOP_POPVIEW:{
			
			NSDictionary* dic = (NSDictionary*)value;
			NSInteger code = [[dic objectForKey:@"code"] intValue];
			switch (code) {
				case 0:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"无道具信息!"];
					break;
				case 1:
				{
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你购买物品成功!"];
					
					if (tempPrice > 0) 
						((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg -= tempPrice * tempCount;
					else
						((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).antsCurrency -= tempPrice * tempCount;
	
					[[GameMainScene sharedGameMainScene] updateUserInfo];
				}
					break;
				case 2:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"余额不足!"];
					break;
				case 3:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作正在进行，不能短时间连续购买!"];
					break;
				case 4:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不能再买了!"];
					break;
				default:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作失败"];
					break;
			}
		}
			break;
			
		case EGG_WAREHOUSE_POPVIEW:
		{
			NSDictionary *result = (NSDictionary *)value;
			NSInteger code = [[result objectForKey:@"code"] intValue];
			switch (code) {
				case 0:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有蛋可卖"];
					break;
				case 1:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你出售成功!"];
					
					NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
											[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
											[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
					
					NSLog(@"%@\n", params);
					[self updateFarmInfoExeCute:params];
					
					break;
				case 2:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"卖蛋不成功!"];
					break;
				case 3:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛋已经拍卖!"];
					break;
				case 4:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛋已经孵化!"];
					break;
				default:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作异常!"];
					break;
			}

			[[NSNotificationCenter defaultCenter] postNotificationName:SaleEggs object:nil];
		}
				break;
		case ANIMAL_ANTSCHOOSE_POPVIEW:
		{
			switch (m_ntabFlag) {
			//婚前交配的回调
		case Mate_Before_Marry:
				{
					NSDictionary *dic = (NSDictionary *)value;
					NSInteger code = [[dic objectForKey:@"code"] intValue];
					switch (code) {
						case 0:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物已经配对"];
							break;
						case 2:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物已经配对"];
							break;
						case 4:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的公动物,不能配对"];
							break;
						case 5:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的公动物,不能配对"];
							break;
						case 7:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"配对失败"];
							break;
						case 9:
						{
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配成功，产生一个受精蛋"];
							
							// Add by Hunk on 2010-09-27 for updating farm information
							NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
													[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
							[self updateFarmInfoExeCute:params];
						}
							break;
						case 10:
						{
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配成功，没能产生受精蛋"];
							// Add by Hunk on 2010-09-27 for updating farm information
							NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
													[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
							[self updateFarmInfoExeCute:params];
						}
							break;
						case 11:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物交配时间未到"];
							break;
						case 12:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配失败"];
							break;
						default:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作异常"];
							break;
					}
				}
					break;
					//婚后交配的回调
				case Mate_After_Marry:
				{
					NSDictionary *dic = (NSDictionary *)value;
					NSInteger code = [[dic objectForKey:@"code"] intValue];
					switch (code) {
						case 0:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物已经配对"];
							break;
						case 5:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"动物没有结婚"];
							break;
						case 7:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"配对失败"];
							break;
						case 8:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"近亲不能结婚"];
							break;
						case 9:
						{
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配成功，产生一个受精蛋"];
							
							// Add by Hunk on 2010-09-27 for updating farm information
							NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
													[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
							[self updateFarmInfoExeCute:params];
						}
							break;
						case 10:
						{
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配成功，没能产生受精蛋"];
							
							// Add by Hunk on 2010-09-27 for updating farm information
							NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
													[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
							[self updateFarmInfoExeCute:params];
						}
							break;
						case 11:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物交配时间未到"];
							break;
						case 12:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配失败"];
							break;
						default:
							[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作异常"];
							break;
					}			
				}
					break;
			}
			break;
			
		default:
			break;
		}
	}
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

#pragma mark -
#pragma mark OtherFunctions
- (void) buyAnimals{
	
	buySlider.hidden = NO;
	countLabel.hidden = NO;
	
	myAntsCurrency = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.antsCurrency;
	myGoldenEgg = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.goldenEgg;
	
	//get data
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	DataModelOriginalAnimal *originAnimal; 
	originAnimal = [originAnimalDic objectForKey:[animalArrayTemp objectAtIndex:itemId]];
	
	buyAniId = originAnimal.originalAnimalId;
	tempCount = 1;
	tempPrice = originAnimal.antsPrice;
	
	NSString* describeString = @"   性别：";
	mixCount = 0;
	int income = 0;
	
	//show
	if (tempPrice == 0) {
		[iconImage setImage:[UIImage imageNamed:@"金蛋.png"]];
		int basePrice = originAnimal.basePrice;
		priceLabel.text = [NSString stringWithFormat:@"%d", basePrice];
		describeString = [describeString stringByAppendingString:@"母\n   价格："];
		describeString = [describeString stringByAppendingString:priceLabel.text];
		describeString = [describeString stringByAppendingString:@"个金蛋"];
		describeString = [describeString stringByAppendingString:@"\n总收益："];
		
		if (basePrice > myGoldenEgg) {
			wrongLabel.hidden = NO;
			OKButton.enabled = NO;
		}
		else {
			mixCount = myGoldenEgg/basePrice;
			wrongLabel.hidden = YES;
			OKButton.enabled = YES;
		}
		
	}
	else {
		[iconImage setImage:[UIImage imageNamed:@"金蚂蚁.png"]];
		priceLabel.text = [NSString stringWithFormat:@"%d", tempPrice];
		describeString = [describeString stringByAppendingString:@"公\n   价格："];
		describeString = [describeString stringByAppendingString:priceLabel.text];
		describeString = [describeString stringByAppendingString:@"个蚂蚁币"];
		describeString = [describeString stringByAppendingString:@"\n总收益："];
		if (tempPrice > myAntsCurrency) {
			wrongLabel.hidden = NO;
			OKButton.enabled = NO;
		}
		else {
			mixCount = myAntsCurrency/tempPrice;
			wrongLabel.hidden = YES;
			OKButton.enabled = YES;
		}
	}
	
	nameLabel.text = originAnimal.scientificNameCN;
	
	describeString = [describeString stringByAppendingString:[NSString stringWithFormat:@"%d", income]];
	describeString = [describeString stringByAppendingString:@"个金蛋"];
	describeLabel.numberOfLines = 3;
	describeLabel.text = describeString;
	countLabel.text = @"选择了0个动物";
}

- (void) buyFoods{
	
	buySlider.hidden = NO;
	countLabel.hidden = NO;
	
	myAntsCurrency = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.antsCurrency;
	myGoldenEgg = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.goldenEgg;
	
	//get data
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *foodsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
	DataModelFood *foods; 
	NSArray *foodArrayTemp = [foodsDic allKeys];
	foods = [foodsDic objectForKey:[foodArrayTemp objectAtIndex:itemId]];
	
	buyAniId = foods.foodId;
	tempCount = 1;
	tempPrice = foods.antsRequired;
	
	int  power = [foods.foodPower intValue];
	NSString* describeString;
	if(power == 255)
	{
		describeString = @"效果：动物基本饲料";
	}
	else if(power == 1)
	{
		describeString = @"效果：产蛋时间缩短1小时";
	}
	else if(power == 2)
	{
		describeString = @"效果：产蛋时间缩短2小时";
	}
	else if(power == 5)
	{
		describeString = @"效果：产蛋时间缩短5小时";
	}
	else if(power == 30)
	{
		describeString = @"效果：提高30%产蛋量";
	}
	
	mixCount = 0;
	
	//show
	if (tempPrice == 0) {
		[iconImage setImage:[UIImage imageNamed:@"金蛋.png"]];
		int basePrice = foods.foodPrice;
		priceLabel.text = [NSString stringWithFormat:@"%d", basePrice];
		describeString = [describeString stringByAppendingString:[NSString stringWithFormat:@"\n单价：%@／千克",priceLabel.text]];
		
		if (basePrice > myGoldenEgg) {
			wrongLabel.hidden = NO;
			OKButton.enabled = NO;
		}
		else {
			mixCount = myGoldenEgg/basePrice;
			wrongLabel.hidden = YES;
			OKButton.enabled = YES;
		}
		
	}
	else {
		[iconImage setImage:[UIImage imageNamed:@"金蚂蚁.png"]];
		priceLabel.text = [NSString stringWithFormat:@"%d", tempPrice];
		describeString = [describeString stringByAppendingString:[NSString stringWithFormat:@"\n单价：%@／份",priceLabel.text]];
		if (tempPrice > myAntsCurrency) {
			wrongLabel.hidden = NO;
			OKButton.enabled = NO;
		}
		else {
			mixCount = myAntsCurrency/tempPrice;
			wrongLabel.hidden = YES;
			OKButton.enabled = YES;
		}
	}
	
	nameLabel.text = foods.foodName;
	
	describeLabel.numberOfLines = 3;
	describeLabel.text = describeString;
	countLabel.text = @"选择了0个商品";
	
	if (mixCount > 500) {
		mixCount = 500;
	}
}

- (void) buyGoods{
	
	buySlider.hidden = YES;
	countLabel.hidden = YES;
	
	//data
	myAntsCurrency = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.antsCurrency;
	myGoldenEgg = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.goldenEgg;
	
	//get data
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *goodsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
	DataModelGood *goods; 
	NSArray *goodArrayTemp = [goodsDic allKeys];
	goods = [goodsDic objectForKey:[goodArrayTemp objectAtIndex:itemId]];
	
	buyAniId = goods.goodsId;
	tempCount = 1;
	tempPrice = goods.goodsAntsPrice;
	
	[iconImage setImage:[UIImage imageNamed:@"金蚂蚁.png"]];
	priceLabel.text = [NSString stringWithFormat:@"%d", tempPrice];
	nameLabel.text = goods.goodsName;
	describeLabel.numberOfLines = 5;
	describeLabel.text = goods.goodsDescription;
	
	if ([buyAniId compare:@"2"] == NSOrderedSame){
		describeLabel.frame = CGRectMake(200, 165, 160, 100);
	}
	
	if (tempPrice > myAntsCurrency) {
		wrongLabel.hidden = NO;
		OKButton.enabled = NO;
	}
	else {
		wrongLabel.hidden = YES;
		OKButton.enabled = YES;
	}
}

#pragma mark -
#pragma mark saleCommonEggs
-(void)saleCommonEggs
{
	buySlider.hidden = NO;
	countLabel.hidden = NO;
	buySlider.value = 1.0f;
	
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
	DataModelStorageEgg *storageEgg; 
	NSArray *storageEggArrayTemp = [storageEggDic allKeys];
	storageEgg = [storageEggDic objectForKey:[storageEggArrayTemp objectAtIndex:itemId]];
	
	nameLabel.text = storageEgg.eggName;
	priceLabel.text = [NSString stringWithFormat:@"%d", storageEgg.eggPrice];
	
	NSString* describeStr;
	describeStr = @"单个售价:";
	describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"%d金蛋\n", storageEgg.eggPrice]];
	describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"总计收入:%d金蛋", storageEgg.numOfProduct*storageEgg.eggPrice]];
	describeLabel.numberOfLines = 2;
	describeLabel.text = describeStr;
	
	countLabel.text = [NSString stringWithFormat:@"%d", storageEgg.numOfProduct];
	
	mixCount = storageEgg.numOfProduct;
}
-(void)saleZogyteEggs
{
	buySlider.hidden = YES;
	countLabel.hidden = YES;
	
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *storageZygoteEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
	DataModelStorageZygoteEgg *storageZygoteEgg; 
	NSArray *storageZygoteEggArrayTemp = [storageZygoteEggDic allKeys];
	storageZygoteEgg = [storageZygoteEggDic objectForKey:[storageZygoteEggArrayTemp objectAtIndex:itemId]];
	
	nameLabel.text = storageZygoteEgg.eggName;
	priceLabel.text = [NSString stringWithFormat:@"%d", storageZygoteEgg.eggPrice];
	
	NSString* describeStr;
	describeStr = @"受精蛋售价:";
	describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"%d金蛋\n", storageZygoteEgg.zygotePrice]];
	describeStr = [describeStr stringByAppendingString:[NSString stringWithFormat:@"受精蛋预计产量:%d个\n", storageZygoteEgg.baseYield]];
	
	if(0 == storageZygoteEgg.zygoteGender)
	{
		describeStr = [describeStr stringByAppendingString:@"性别:母"];
	}
	else if(1 == storageZygoteEgg.zygoteGender)
	{
		describeStr = [describeStr stringByAppendingString:@"性别:公"];
	}
	describeLabel.numberOfLines = 3;
	describeLabel.text = describeStr;
	
	// 孵化
	UIButton* hatchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[hatchBtn setBackgroundImage:[UIImage imageNamed: @"黄色按钮.png"] forState:UIControlStateNormal];
	[hatchBtn setTitle:@"孵化" forState:UIControlStateNormal];
	hatchBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
	[hatchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	CGRect btnFrame = CGRectMake(210, 250, 60, 30);
	hatchBtn.frame = btnFrame;
	[hatchBtn addTarget:self action:@selector(hatchBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:hatchBtn];
}

-(void)hatchBtnSelected:(id)sender
{
	if(nil == m_hatchView)
	{
		m_hatchView = [[hatchView alloc]initWithNibName:@"hatchView" bundle:nil];
	}
	
	
	farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *storageZygoteEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
	DataModelStorageZygoteEgg *storageZygoteEgg; 
	NSArray *storageZygoteEggArrayTemp = [storageZygoteEggDic allKeys];
	storageZygoteEgg = [storageZygoteEggDic objectForKey:[storageZygoteEggArrayTemp objectAtIndex:itemId]];
	
	if(storageZygoteEgg.zygoteGender < 50)
	{
		[m_hatchView setM_nGoldenEggs: (3 * storageZygoteEgg.zygotePrice)];
		[m_hatchView setM_nAnts:((3 * storageZygoteEgg.zygotePrice) / 500)];
	}
	else
	{
		[m_hatchView setM_nGoldenEggs: (6 * storageZygoteEgg.zygotePrice)];
		[m_hatchView setM_nAnts:((6 * storageZygoteEgg.zygotePrice) / 500)];		
	}

	[m_hatchView setM_strFarmerID:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId];
	[m_hatchView setM_strFarmID:[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId];
	[m_hatchView setM_strStorageZyID:storageZygoteEgg.zygoteStorageId];
	
	
	[self.view addSubview:m_hatchView.view];
}

-(void)updateFarmInfoExeCute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	NSLog(@"%@\n", param);
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"updateFarmInfoResultCallback:" AndFailedSel:@"faultCallback:"];
}


-(void)updateFarmInfoResultCallback:(NSObject*)value
{
	[[GameMainScene sharedGameMainScene] updateUserInfo];
}


@end
