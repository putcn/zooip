//
//  popViewManager.m
//  zoo
//
//  Created by shen lancy on 10-7-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "popViewManager.h"
#import "DataModelStorageEgg.h"
#import "DataModelStorageZygoteEgg.h"
#import "FeedbackDialog.h"
#import "GameMainScene.h"
#import "DataModelStorageAnimal.h"

//static popViewManager *sharedPopView = nil;

@interface popViewManager (OtherFunctions)
- (void) addTitleButtons:(NSArray *)arrayPic;
- (void) selectButtonAtIndex:(NSUInteger)index;

- (void) backBtnSelected:(id)sender;
- (void) sellAllBtnSelected:(id)sender;

- (void) resultAllEggCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;
- (void)updateFarmInfoExeCute:(NSDictionary *)value;
- (void)updateFarmInfoResultCallback:(NSObject*)value;
@end

@implementation popViewManager

@synthesize m_ppopView;
@synthesize m_npopViewType, m_nlistCount, tabFlag;
@synthesize buyTypeArray, priceArray, sexArray, storageEggArray, storageAniArray;

@synthesize touchIndex;

@synthesize stoAnimalsArray;

- (id)init{

	if ( (self = [super init]) ) {
		
		// Marray view
		m_pMarryView = [[MarryView alloc]init];
		
		
		
		serviceInstance = [ServiceHelper sharedService];
		picFileNameArray = [[NSMutableArray alloc] init];
		topBtnArray = [[NSMutableArray alloc] init];
		m_nlistCount = 1;
		secPopView = [[SecPopViewController alloc] initWithNibName:@"SecPopViewController" bundle:nil];
		
		[self.view setFrame:CGRectMake(0.f,0.f,320.f,480.f)];
		[self.view setBackgroundColor:[UIColor clearColor]];
		UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		img.backgroundColor = [UIColor blackColor];
		img.alpha = 0.5;
		[self.view addSubview:img];
		[img release];
		img = nil;
		
		UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 320, 200)];
		[backgroundImage setImage:[UIImage imageNamed:@"BG_buy.png"]];
		[self.view addSubview:backgroundImage];
		[backgroundImage release];
		backgroundImage = nil;
		
		UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[backBtn setImage:[UIImage imageNamed: @"exitButton.png"] forState:UIControlStateNormal];
		backBtn.frame = CGRectMake(376, 276, 30, 30);
		[backBtn addTarget:self action:@selector(backBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:backBtn];
		
		stoAnimalsArray = [[NSMutableArray alloc]init];
	}
	return self;
}

- (void)dealloc{
	
	[m_ppopView release];
	m_ppopView = nil;
	[picFileNameArray release];
	picFileNameArray = nil;
	[topBtnArray release];
	topBtnArray = nil;
	[secPopView release];
	secPopView = nil;
	
	[buyTypeArray release];
	buyTypeArray = nil;
	[priceArray release];
	priceArray = nil;
	[sexArray release];
	sexArray = nil;
	[storageEggArray release];
	storageEggArray = nil;
	
	
	[m_pMarryView release];
	
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{	
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark -
#pragma mark Laying out subviews

- (void)addView2Window{
	
	[[[UIApplication sharedApplication]keyWindow] addSubview:self.view];
}

- (void)setPopViewFrame:(CGRect)myFrame{
	
	m_ppopView = [[UIScrollView alloc] initWithFrame:myFrame];
}

#define		INTERVAL_PIX  30.0

- (void) setSubSize:(CGSize)size{
	
	subSize = size;
}

- (void) initWithItem:(NSArray*)arrayPic{
	
	
	m_nprevButtonIndex = -1;
	touchIndex = 0;
	[picFileNameArray removeAllObjects];
	[picFileNameArray addObjectsFromArray:arrayPic];
	
	m_ppopView.userInteractionEnabled = YES;
	m_ppopView.scrollEnabled = YES;
	m_nrowCount = [arrayPic count]/m_nlistCount;
	if ([arrayPic count]%m_nlistCount != 0) {
		m_nrowCount++;
	}
	[m_ppopView setContentSize:CGSizeMake(subSize.width*m_nrowCount + INTERVAL_PIX*(m_nrowCount+1), m_ppopView.frame.size.height)];
	[m_ppopView setBackgroundColor:[UIColor clearColor]];
	m_ppopView.alpha = 1;
	[m_ppopView setShowsHorizontalScrollIndicator:NO];
	[m_ppopView setShowsVerticalScrollIndicator:NO];
	[self.view addSubview:m_ppopView];

	[self addTitleButtons:arrayPic];
}


- (void) addTitleButtons:(NSArray *)arrayPic{
	
	UIButton *btn;	
	for (int i = 0; i < [arrayPic count]; i++) {
		
		//show position
		float row = i/m_nlistCount;
		float list = i%m_nlistCount;
		float rowinterval = subSize.width*row + INTERVAL_PIX*(row + 1);
		float listinterval = subSize.height*list + INTERVAL_PIX*(list + 1);
		
		//background
		UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"边框.png"]];
		img.frame = CGRectMake(rowinterval-10, listinterval-5, subSize.width+20, subSize.height+20);
		[m_ppopView addSubview:img];
		[img release];
		img = nil;
		
		switch (m_npopViewType) {
			case SHOP_POPVIEW:{
			
				//icon
				UIImageView* buyImg = [[UIImageView alloc] init];
				int buyType = [[buyTypeArray objectAtIndex:i] intValue];
				if (buyType == 0) {
					[buyImg setImage:[UIImage imageNamed:@"金蛋ico.png"]];
					buyImg.frame = CGRectMake(rowinterval, listinterval+40, 7, 10);
				}else {
					[buyImg setImage:[UIImage imageNamed:@"蚂蚁ICO.png"]];
					buyImg.frame = CGRectMake(rowinterval, listinterval+40, 10, 10);
				}
				[m_ppopView addSubview:buyImg];
				[buyImg release];
				buyImg = nil;

				//label
				UILabel* showLabel = [[UILabel alloc] init];
				showLabel.text = [priceArray objectAtIndex:i];
				showLabel.frame = CGRectMake(rowinterval+12, listinterval+42, 40, 10);
				showLabel.backgroundColor = [UIColor clearColor];
				showLabel.font = [UIFont fontWithName:@"Arial" size:12];
				[m_ppopView addSubview:showLabel];
				[showLabel release];
				showLabel = nil;
				
			}
				break;
				
			case EGG_WAREHOUSE_POPVIEW:{
				
				switch (tabFlag) {
					case SALE_COMMONEGGS:{
						
						DataModelStorageEgg* storageEgg;
						
						storageEgg = [storageEggArray objectAtIndex:i];
						
						//label
						UILabel* showLabel = [[UILabel alloc] init];
						showLabel.text = [storageEgg.eggName stringByAppendingString:[NSString stringWithFormat:@"%@%d", @":", storageEgg.numOfProduct]];
						showLabel.frame = CGRectMake(rowinterval - 5, listinterval+45, 70, 15);
						showLabel.backgroundColor = [UIColor clearColor];
						showLabel.font = [UIFont fontWithName:@"Arial" size:11];
						[m_ppopView addSubview:showLabel];
						[showLabel release];
						showLabel = nil;
					
					}
						break;
						
					case SALE_ZYGOTEEGGS:{
						
						DataModelStorageZygoteEgg* storageZygoteEgg;
						
						storageZygoteEgg = [storageEggArray objectAtIndex:i];
						
						//label
						UILabel* showLabel = [[UILabel alloc] init];
						showLabel.text = [storageZygoteEgg.eggName stringByAppendingString:[NSString stringWithFormat:@"%@%d", @":", storageZygoteEgg.zygotePrice]];
						showLabel.frame = CGRectMake(rowinterval - 5, listinterval+45, 70, 15);
						showLabel.backgroundColor = [UIColor clearColor];
						showLabel.font = [UIFont fontWithName:@"Arial" size:11];
						[m_ppopView addSubview:showLabel];
						[showLabel release];
						showLabel = nil;
					}
						break;
						
					default:
						break;
				}
				
				saleAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
				[saleAllBtn setBackgroundImage:[UIImage imageNamed: @"确定.png"] forState:UIControlStateNormal];
				[saleAllBtn setTitle:@"全部售出" forState:UIControlStateNormal];
				saleAllBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
				[saleAllBtn setFrame:CGRectMake(300, 250, 60, 30)];
				[saleAllBtn addTarget:self action:@selector(sellAllBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
				
				[self.view addSubview:saleAllBtn];
			}
				break;
				
			case ANIMAL_WAREHOUSE_POPVIEW:{
				
				int sex = [[sexArray objectAtIndex:i] intValue];
				UIImageView *sexImage = [[UIImageView alloc] init];
				switch (sex) {
					case 0:
						[sexImage setImage:[UIImage imageNamed:@"母.png"]];
						break;
						
					case 1:
						[sexImage setImage:[UIImage imageNamed:@"公.png"]];
						 break;
						 
					default:
						break;
				}
				
				[sexImage setFrame:CGRectMake(rowinterval+subSize.width-10, listinterval, 10, 12)];
				[m_ppopView addSubview:sexImage];
				[sexImage release];
				sexImage = nil;
				
				UILabel* countLabel = [[UILabel alloc] initWithFrame:CGRectMake(rowinterval, listinterval+subSize.height-10, 50, 15)];
				countLabel.text = [[storageAniArray objectAtIndex:i] stringValue];
				[m_ppopView addSubview:countLabel];
				[countLabel release];
				countLabel = nil;
			}
				break;
				
			case ANIMAL_MATEORMARRY_POPVIEW:
			{
				int sex = [[sexArray objectAtIndex:i] intValue];
				UIImageView *sexImage = [[UIImageView alloc] init];
				switch (sex) 
				{
					case 0:
						[sexImage setImage:[UIImage imageNamed:@"母.png"]];
						break;
						
					case 1:
						[sexImage setImage:[UIImage imageNamed:@"公.png"]];
						break;
						
					default:
						break;
				}
				
				[sexImage setFrame:CGRectMake(rowinterval+subSize.width-10, listinterval, 10, 12)];
				[m_ppopView addSubview:sexImage];
				[sexImage release];
				sexImage = nil;
				
				UILabel* countLabel = [[UILabel alloc] initWithFrame:CGRectMake(rowinterval, listinterval+subSize.height-10, 50, 15)];
				countLabel.text = [[storageAniArray objectAtIndex:i] stringValue];
				[m_ppopView addSubview:countLabel];
				[countLabel release];
				countLabel = nil;
			}
				break;
				
			default:
				break;
		}
		
		//button
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage* showImage = [UIImage imageNamed: [arrayPic objectAtIndex:i]];
		CGImageRef imgRef =showImage.CGImage;
		CGFloat _width = subSize.width;
		CGFloat _height = subSize.height;
		
		btn.frame = CGRectMake(rowinterval, listinterval, _width, _height);
		
		if ([[buyTypeArray objectAtIndex:i] intValue] == 0) {
			[btn setImage:showImage forState:UIControlStateNormal];
		}
		//图片翻转
		else {
			
			CGAffineTransform transform = CGAffineTransformIdentity;
			CGRect bounds = CGRectMake(0, 0, _width, _height);
			
			transform = CGAffineTransformMakeTranslation(0.0, _height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			
			UIGraphicsBeginImageContext(bounds.size);
			
			CGFloat scaleRatio = bounds.size.width / _width;
			CGFloat scaleRatioheight = bounds.size.height / _height;
			
			CGContextRef context = UIGraphicsGetCurrentContext();
			CGContextScaleCTM(context, -scaleRatio, scaleRatioheight);
			CGContextTranslateCTM(context, -_height, 0);
			CGContextConcatCTM(context, transform);
			
			CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, _width, _height), imgRef);
			UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
			
			[btn setImage:imageCopy forState:UIControlStateNormal];
		}
		
		[btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = i;
		[m_ppopView addSubview:btn];
	}
	
	// Select the first button
	[self selectButtonAtIndex:0];
}

- (void)selectButtonAtIndex:(NSUInteger)index{
	
	prevButtonIndex = index;
}

- (void)deselectButtonAtIndex:(NSUInteger)prevIndex{
	
	m_nprevButtonIndex = -1;
}

- (void)buttonSelected:(id)sender{
	
	UIButton *selectedBtn = (UIButton *)sender;
	NSUInteger index = selectedBtn.tag;
	
	if (index != prevButtonIndex) {
		[self deselectButtonAtIndex:prevButtonIndex];
		[self selectButtonAtIndex:index];
	}

	[secPopView setM_npopViewType:m_npopViewType];
	[secPopView setM_ntabFlag:tabFlag];
	
	switch (m_npopViewType) {
		case SHOP_POPVIEW:{
		
			NSString* fileName = [picFileNameArray objectAtIndex:index];
			[secPopView setItemId:index];
			[self.view addSubview:secPopView.view];
			[secPopView setShowImageName:fileName];
		}
			break;
			
		case EGG_WAREHOUSE_POPVIEW:{
			
			NSString* fileName = [picFileNameArray objectAtIndex:index];
			[secPopView setItemId:index];
			[self.view addSubview:secPopView.view];
			[secPopView setShowImageName:fileName];
		}
			break;
			
		case ANIMAL_WAREHOUSE_POPVIEW:{
			
			touchIndex = index;
			[[NSNotificationCenter defaultCenter] postNotificationName:AddAnimals object:nil];
		}
			break;
		case ANIMAL_MATEORMARRY_POPVIEW:
		{
			// Show marry view
			//[self.view addSubview:m_pMarryView.view];
			
			// 判断是否有动物可以结婚
			BOOL ret = NO;
			NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
			NSString *aniID;
			DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:[stoAnimalsArray objectAtIndex:index]];
			
			
			NSMutableArray* picArray = [[NSMutableArray alloc]init];
			NSMutableArray* animalIDArray = [[NSMutableArray alloc]init];
			
			for (int i = 0; i < [[DataEnvironment sharedDataEnvironment].animalIDs count]; i ++) 
			{
				aniID = [animalIDs objectAtIndex:i];
						
				DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			
				if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender)
				{
					// animal list
					[picArray addObject:[NSString stringWithFormat:@"%@.png",serverAnimalList.picturePrefix]];

					[animalIDArray addObject:serverAnimalList.animalId];
					
					
					ret = YES;
					//break;
				}
			}
			if(!ret) //没有可以结婚的,弹出窗口
			{
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可以结婚的动物!"];
			}
			
			
			if(ret)
			{
				if(serverAnimalDataOne.gender <= 50) // 雌性 - 0
				{
					[m_pMarryView addUpAnimal:[NSString stringWithFormat:@"%@.png",serverAnimalDataOne.picturePrefix] sex:0];
				
					
				}
				else
				{
					[m_pMarryView addUpAnimal:[NSString stringWithFormat:@"%@.png",serverAnimalDataOne.picturePrefix] sex:1];
				
					
				}
				
				[m_pMarryView setLeftAnimalID:serverAnimalDataOne.animalId];
				[m_pMarryView initScrollViewItems:picArray aniID:animalIDArray];
								
				
				[self.view addSubview:m_pMarryView.view];
			}

		}
			break;
			
		default:
			break;
	}

}

- (void) backBtnSelected:(id)sender{
	
	for (UIView *subview in m_ppopView.subviews) {
		[subview removeFromSuperview];
	}
	[topBtnArray removeAllObjects];
	[saleAllBtn removeFromSuperview];
	[self.view removeFromSuperview];
}

- (void) sellAllBtnSelected:(id)sender{

	NSString *frameId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	
	switch (tabFlag) {
		case SALE_COMMONEGGS:{
			
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
									frameId,	@"farmerId",
									nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellAllProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAllEggCallback:" AndFailedSel:@"faultCallback:"];
		}
			break;
			
		case SALE_ZYGOTEEGGS:{
			
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
									frameId,	@"farmerId",
									nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellAllZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAllZygoteEggCallback:" AndFailedSel:@"faultCallback:"];
		}
			break;
			
		default:
			break;
	}
}

- (void) resultAllEggCallback:(NSObject *)value{
	
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	if (code == 0) {
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可卖的蛋!"];
	}
	
	if (code == 1) {
		
		for (UIView *subview in m_ppopView.subviews) {
			[subview removeFromSuperview];
		}
		
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功卖出所有蛋!"];
		
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",
								nil];
		
		NSLog(@"%@\n", params);
		[self updateFarmInfoExeCute:params];
		
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:SaleEggs object:nil];
}

- (void) faultCallback:(NSObject *)value{
	NSLog(@"Server Connection Fail");
}

- (void)resultAllZygoteEggCallback:(NSObject *)value
{
	
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	if (code == 0) {
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可卖的蛋!"];
	}
	
	if (code == 1) {
		
		for (UIView *subview in m_ppopView.subviews) {
			[subview removeFromSuperview];
		}
		
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功卖出所有蛋!"];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",
								nil];
		[self updateFarmInfoZogyteExeCute:params];
		
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:SaleEggs object:nil];
}

-(void)updateFarmInfoExeCute:(NSDictionary *)value{
	
	NSDictionary *param = (NSDictionary *)value;
	
	NSLog(@"%@\n", param);
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"updateFarmInfoResultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void)updateFarmInfoResultCallback:(NSObject*)value{
	
	[[GameMainScene sharedGameMainScene] updateUserInfo];
}

-(void)updateFarmInfoZogyteExeCute:(NSDictionary *)value{
	
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"updateFarmInfoResultZogyteCallback:" AndFailedSel:@"faultCallback:"];
}

-(void)updateFarmInfoResultZogyteCallback:(NSObject*)value{
	
	[[GameMainScene sharedGameMainScene] updateUserInfo];
}

@end
