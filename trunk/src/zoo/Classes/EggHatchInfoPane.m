//
//  EggHatchInfoPane.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EggHatchInfoPane.h"
#import "DataModelEgg.h"
@implementation EggHatchInfoPane


-(id) initWithItem:(NSString *)farmerid farmID:(NSString *) farmid storageZyID:(NSString *) storageZyId  storageZyGender: (int)gender storageZyPrice: (int)price setTarget:(id)target; 
{
	if ((self = [super init])) {
		
				
		FARMER_ID = farmerid;
		FARM_ID = farmid;
		STORAGEZY_ID = storageZyId;
		m_gender = gender;
		nPrice = price;
		myTarget = target;
				
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		title = @"孵 化";
		
		[self addTitle];
		[self addHatchInfo];
		[self addButton];

		
	}
	return self;
}
-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:20];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2 -10);
	[self addChild:titleLbl z:10];
}



-(void)addHatchInfo
{
	CCSprite* kuang = [CCSprite spriteWithFile:@"问号.png"];
	kuang.position = ccp(self.contentSize.width/2 , self.contentSize.height-60);
	[self addChild:kuang z:10];
	
	//discribe
	if(m_gender < 50)
	{
		NSInteger nGoldEgg = nPrice*3;
		NSString *infoHatchStr1 = [NSString stringWithFormat: @"母受精卵孵化需要%d个金蛋,",nGoldEgg];
//		NSString *infoHatchStr1 = @"母受精卵孵化需要4356个金蛋，";
		lab_hatchEggInfo1 = [CCLabel labelWithString:infoHatchStr1 fontName:@"Arial" fontSize:15];
		[lab_hatchEggInfo1 setColor:ccc3(0, 0, 0)];
		lab_hatchEggInfo1.position = ccp(self.contentSize.width/2 , self.contentSize.height - 90);
		[self addChild:lab_hatchEggInfo1 z:10];
		
		
		float new = [[NSString stringWithFormat:@"%1.0f", nGoldEgg/500.0] floatValue];
//		NSLog(@"%f",new);
		NSInteger nAntEgg = new;
		NSString *infoHatchStr2 = [NSString stringWithFormat: @"或者%d个蚂蚁币。",nAntEgg];
//		NSString *infoHatchStr2 = @"或者9个蚂蚁币。";
		lab_hatchEggInfo2 = [CCLabel labelWithString:infoHatchStr2 fontName:@"Arial" fontSize:15];
		[lab_hatchEggInfo2 setColor:ccc3(0, 0, 0)];
		lab_hatchEggInfo2.position = ccp(self.contentSize.width/2 , self.contentSize.height - 110);
		[self addChild:lab_hatchEggInfo2 z:10];
	}
	else 
	{
		NSInteger nGoldEgg = nPrice*6;
		NSString *infoHatchStr1 = [NSString stringWithFormat: @"公受精卵孵化需要%d个金蛋,",nGoldEgg];
//		NSString *infoHatchStr1 = @"公受精卵孵化需要8712个金蛋，";
		lab_hatchEggInfo1 = [CCLabel labelWithString:infoHatchStr1 fontName:@"Arial" fontSize:15];
		[lab_hatchEggInfo1 setColor:ccc3(0, 0, 0)];
		lab_hatchEggInfo1.position = ccp(self.contentSize.width/2 , self.contentSize.height - 90);
		[self addChild:lab_hatchEggInfo1 z:10];

		float new = [[NSString stringWithFormat:@"%1.0f", nGoldEgg/500.0] floatValue];
//		NSLog(@"%f",new);
		NSInteger nAntEgg = new;
		NSString *infoHatchStr2 = [NSString stringWithFormat: @"或者%d个蚂蚁币。",nAntEgg];
//		NSString *infoHatchStr2 = @"或者17个蚂蚁币。";
		lab_hatchEggInfo2 = [CCLabel labelWithString:infoHatchStr2 fontName:@"Arial" fontSize:15];
		[lab_hatchEggInfo2 setColor:ccc3(0, 0, 0)];
		lab_hatchEggInfo2.position = ccp(self.contentSize.width/2 , self.contentSize.height - 110);
		[self addChild:lab_hatchEggInfo2 z:10];
	}
	

	NSString *infoHatchStr3 = @"您确定要孵化吗？"; 
	lab_hatchEggInfo3 = [CCLabel labelWithString:infoHatchStr3 fontName:@"Arial" fontSize:15];
	[lab_hatchEggInfo3 setColor:ccc3(0, 0, 0)];
	lab_hatchEggInfo3.position = ccp(self.contentSize.width/2 , self.contentSize.height - 140);
	[self addChild:lab_hatchEggInfo3 z:10];
	
	
//	lab_notice = [CCLabel labelWithString:@"ertwertwrtwrt" fontName:@"Arial" fontSize:15];
//	[lab_notice setColor:ccc3(0, 0, 0)];
//	lab_notice.position = ccp(self.contentSize.width/2 , self.contentSize.height - 150);
//	[self addChild:lab_notice z:10];
	
}



-(void)addButton
{
	Button *useMoneyBtn = [[Button alloc] initWithLabel:@"使用金币" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"确定.png" setTarget:self setSelector:@selector(hatChEggHandler:) setPriority:20 offsetX:0 offsetY:0 scale:1.0f];	
	Button *useAntBtn = [[Button alloc] initWithLabel:@"使用蚂蚁" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"确定.png" setTarget:self setSelector:@selector(anthatChEggHandler:) setPriority:20 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"取 消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"取消.png" setTarget:myTarget setSelector:@selector(cancelHandler:) setPriority:20 offsetX:0 offsetY:0 scale:1.0f];
	
	cancelBtn.target = self;
	useMoneyBtn.position = ccp(self.contentSize.width/2 -100, 35);
	useAntBtn.position = ccp(self.contentSize.height/2 +60, 35);
	cancelBtn.position = ccp(self.contentSize.height/2 + 160, 35);
	
	[self addChild:useMoneyBtn z:10];
	[self addChild:useAntBtn z:10];
	[self addChild:cancelBtn z:10];
}


-(void) hatChEggHandler:(Button *)button
{
	NSString *pay = [NSString stringWithFormat:@"goldenEgg"];	
	payType = @"goldenEgg";	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:FARMER_ID,@"farmerId",FARM_ID,@"farmId",STORAGEZY_ID,@"zygoteStorageId",pay,@"payment",nil];	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		
}

-(void) anthatChEggHandler:(Button *)button
{
	NSString *pay = [NSString stringWithFormat:@"ant"];
	payType = @"ant";
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:FARMER_ID,@"farmerId",FARM_ID,@"farmId",STORAGEZY_ID,@"zygoteStorageId",pay,@"payment",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAntHatchCallback:" AndFailedSel:@"faultCallback:"];
	
}



-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];	
	[self selectResultInfo:code setPayType:payType ];		
}



-(void) resultAntHatchCallback:(NSObject *)value
{	
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	[self selectResultInfo:code setPayType:payType ];
}



-(void)selectResultInfo:(NSInteger) code  setPayType:(NSString *)  payType
{
	switch (code) {
		case 0:
			infoStr = [NSString stringWithFormat:@"没有受精卵或受精卵已经孵出"];
			break;
		case 1:
			infoStr = [NSString stringWithFormat:@"孵化成功"];
			break;	
			
		case 2:
			infoStr = [NSString stringWithFormat:@"受精卵在拍卖"];
			
			break;
		case 3:
			infoStr = [NSString stringWithFormat:@"孵化不成功"];
			break;
			
		case 4:
			infoStr = [NSString stringWithFormat:@"农场容量不够"];
			break;
			
		case 5:
			infoStr = [NSString stringWithFormat:@"没有可以用来孵化的母鸡"];
			break;
			
		case 6:
			if (payType == @"goldenEgg") {
				infoStr = [NSString stringWithFormat:@"没有足够的金币"];
			}else {
				infoStr = [NSString stringWithFormat:@"没有足够的蚂蚁"];
			}
			break;			
		case 7:
			infoStr = [NSString stringWithFormat:@"已喂过"];
			break;			
		case 8:
			infoStr = [NSString stringWithFormat:@"公动物不能喂食物"];
			break;
		default:
			break;
	}
	
	[[FeedbackDialog sharedFeedbackDialog] addMessage:infoStr];
	[lab_notice setString:infoStr];
}


-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}


-(void) dealloc
{
	
	[title             release];
	[lab_notice        release];
	[FARMER_ID         release];
	[FARM_ID           release];
	[STORAGEZY_ID	   release];
	[infoStr           release];
	[payType           release];
	[lab_hatchEggInfo1 release];
	[lab_hatchEggInfo2 release];
	[lab_hatchEggInfo3 release];
	[lab_notice        release];
	[myTarget          release];
	
	[super dealloc];
}

@end