//
//  EggHatchInfoPane.m
//  zoo
//
//  Created by admin on R.O.C. 99/6/7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EggHatchInfoPane.h"

@implementation EggHatchInfoPane






-(id) initWithItem:(NSString *)farmerid farmID:(NSString *) farmid storageZyID:(NSString *) storageZyId setTarget:(id)target; 
{
	if ((self = [super init])) {
		
				
		FARMER_ID = farmerid;
		FARM_ID = farmid;
		STORAGEZY_ID = storageZyId;
		myTarget = target;
				
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ItemInfoPane.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		title = @"孵 化";
		
		[self addTitle];
		[self addHatchInfo];
		[self addButton];

		//[self updateInfo:itId type:itType setTarget:target];
		
		
	}
	return self;
}
-(void)addTitle
{
	
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}



-(void)addHatchInfo
{
	//discribe
	NSString *infoHatchStr1 = @"母受精卵孵化需要4356个金蛋，或者9个蚂蚁币。";
	NSString *infoHatchStr2 = @"公受精卵孵化需要8712个金蛋，或者17个蚂蚁币。";
	NSString *infoHatchStr3 = @"您确定要孵化吗？";
	
	
	lab_hatchEggInfo1 = [CCLabel labelWithString:infoHatchStr1 fontName:@"Arial" fontSize:30];
	[lab_hatchEggInfo1 setColor:ccc3(0, 0, 0)];
	lab_hatchEggInfo1.position = ccp(self.contentSize.width/2 + 100, self.contentSize.height - 100);
	[self addChild:lab_hatchEggInfo1 z:10];
	
	lab_hatchEggInfo2 = [CCLabel labelWithString:infoHatchStr2 fontName:@"Arial" fontSize:30];
	[lab_hatchEggInfo2 setColor:ccc3(0, 0, 0)];
	lab_hatchEggInfo2.position = ccp(self.contentSize.width/2 + 100, self.contentSize.height - 150);
	[self addChild:lab_hatchEggInfo2 z:10];
	
	lab_hatchEggInfo3 = [CCLabel labelWithString:infoHatchStr3 fontName:@"Arial" fontSize:30];
	[lab_hatchEggInfo3 setColor:ccc3(0, 0, 0)];
	lab_hatchEggInfo3.position = ccp(self.contentSize.width/2 + 100, self.contentSize.height - 200);
	[self addChild:lab_hatchEggInfo3 z:10];
	
	
	//lab_notice
	
	//[lab_notice setString:timeString];
	
	lab_notice = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:30];
	[lab_notice setColor:ccc3(0, 0, 0)];
	lab_notice.position = ccp(self.contentSize.width/2 + 100, self.contentSize.height - 300);
	[self addChild:lab_notice z:10];
	
}







-(void)addButton
{
	
	Button *useMoneyBtn = [[Button alloc] initWithLabel:@"使用金币" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(hatChEggHandler:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	
	Button *useAntBtn = [[Button alloc] initWithLabel:@"使用蚂蚁" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(anthatChEggHandler:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	
	Button *cancelBtn = [[Button alloc] initWithLabel:@"取 消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"TabButton2.png" setTarget:myTarget setSelector:@selector(cancelHandler:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	
	cancelBtn.target = self;
	
	useMoneyBtn.position = ccp(self.contentSize.width/2 - 200, 50);
	
	useAntBtn.position = ccp(self.contentSize.height/2 + 100, 50);
	
	cancelBtn.position = ccp(self.contentSize.height/2 + 250, 50);
	
	[self addChild:useMoneyBtn z:10];
	[self addChild:useAntBtn z:10];
	[self addChild:cancelBtn z:10];
	
		
	
}



-(void) cancelHandler:(Button *)button
{
	
	
}




-(void) hatChEggHandler:(Button *)button
{
	NSLog(@"hatch egg info------");
	
	//payment
	NSString *pay = [NSString stringWithFormat:@"goldenEgg"];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:FARMER_ID,@"farmerId",FARM_ID,@"farmId",STORAGEZY_ID,@"zygoteStorageId",pay,@"payment",nil];
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		
	
}

-(void) anthatChEggHandler:(Button *)button
{
	NSLog(@"hatch egg info------");
	
	//payment
	NSString *pay = [NSString stringWithFormat:@"ant"];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:FARMER_ID,@"farmerId",FARM_ID,@"farmId",STORAGEZY_ID,@"zygoteStorageId",pay,@"payment",nil];
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoIncubatingEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAntHatchCallback:" AndFailedSel:@"faultCallback:"];
	
	
}








-(void) resultCallback:(NSObject *)value
{
	//[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你孵化成功!"];
	
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	if (code == 0) {
		infoStr = [NSString stringWithFormat:@"没有受精卵或受精卵已经孵出"];
		
	}
	
	if (code == 1) {
		infoStr = [NSString stringWithFormat:@"孵化成功"];
	}
	
	if (code == 2) {
		infoStr = [NSString stringWithFormat:@"受精卵在拍卖"];
	}
	
	if (code == 3) {
		infoStr = [NSString stringWithFormat:@"孵化不成功"];
	}
	
	if (code == 4) {
		infoStr = [NSString stringWithFormat:@"农场容量不够"];
	}
	
	
	if (code == 5) {
		infoStr = [NSString stringWithFormat:@"没有可以用来孵化的母鸡"];
	}
	
	if (code == 6) {
		infoStr = [NSString stringWithFormat:@"余额不足"];
	}
	
	if (code == 7) {
		infoStr = [NSString stringWithFormat:@"已喂过"];
	}
	
	if (code == 8) {
		infoStr = [NSString stringWithFormat:@"公动物不能喂食物"];
	}
	
	[[FeedbackDialog sharedFeedbackDialog] addMessage:infoStr];
	
	[lab_notice setString:infoStr];
	
		
	
}




-(void) resultAntHatchCallback:(NSObject *)value
{
	//[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你孵化成功!"];
	
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	if (code == 0) {
		infoStr = [NSString stringWithFormat:@"没有受精卵或受精卵已经孵出"];
	}
	
	if (code == 1) {
		infoStr = [NSString stringWithFormat:@"孵化成功"];
	}
	
	if (code == 2) {
		infoStr = [NSString stringWithFormat:@"受精卵在拍卖"];
	}
	
	if (code == 3) {
		infoStr = [NSString stringWithFormat:@"孵化不成功"];
	}
	
	if (code == 4) {
		infoStr = [NSString stringWithFormat:@"农场容量不够"];
	}
	
	
	if (code == 5) {
		infoStr = [NSString stringWithFormat:@"没有可以用来孵化的母鸡"];
	}
	
	if (code == 6) {
		infoStr = [NSString stringWithFormat:@"没有足够的蚂蚁"];
	}
	
	if (code == 7) {
		infoStr = [NSString stringWithFormat:@"已喂过"];
	}
	
	if (code == 8) {
		infoStr = [NSString stringWithFormat:@"公动物不能喂食物"];
	}
	
	[[FeedbackDialog sharedFeedbackDialog] addMessage:infoStr];
	
	[lab_notice setString:infoStr];
	
	
	
}










-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}









@end