//
//  AnimalManageToMateInfoPanel.m
//  zoo
//
//  Created by AlexLiu on 6/2/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import "AnimalManageToMateInfoPanel.h"
#import "TransBackground.h"
#import "ScalerPane.h"
#import "FeedbackDialog.h"

@implementation AnimalManageToMateInfoPanel
@synthesize 
title,
itemId,
itemType,
itemBuyType,
count,
infoMessagePanelTest,
leftAnimalID,
rightAnimalID,
animalID;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType animalID:(NSString *) aniID setTarget:(id)target
{
	if ((self = [super init])) {
		itemId = itId;
		parentTarget = target;
		animalID = aniID;
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.title = @"动物结婚";
		priceLbl = [[CCLabel alloc] retain];
		//****[self updateInfo:itId type:itType setTarget:target];
		
		//********
		
		currentPageNum = 1;
		
		// add button.
		[self generateButtons];
		
		//generate one button. Generate other button list.
		[self generateOne];
		[self generateOthers];
		
//		self.scale = 300.0f/1024.0f;
	}
	return self;
}

//生成结婚和交配按钮
-(void)generateButtons
{
	Button *toMateBtn = [[Button alloc] initWithLabel:@"交配" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"红色按钮.png" setTarget:self setSelector:@selector(toMate:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	Button *toMarryBtn = [[Button alloc] initWithLabel:@"结婚" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"黄色按钮.png" setTarget:self setSelector:@selector(toMarry:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	//toMarryBtn.flipX = YES;
	toMateBtn.position = ccp(self.contentSize.width/2 + 100, 25);
	toMarryBtn.position = ccp(self.contentSize.width/2 - 100, 25);
	[self addChild:toMateBtn z:8];
	[self addChild:toMarryBtn z:8];
}

//生成左边的动物，公的
-(void)generateOne
{
	//Gen the one clicked at the right postion.

	DataModelAnimal *serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:animalID];
	NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
	NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
	NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];
	if (serverAnimalData2.gender == 1) {
		leftAnimalID = animalID;
		//For Test
		NSString *tabFlag = @"animals";
		AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:leftAnimalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];
		itemButton.position = ccp(220,115);
		[self addChild:itemButton z:8 tag:1%8];
		
		CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
		kuang.position = ccp(220,135);
		kuang.scale = 0.7f;
		[self addChild:kuang z:8];
	}
	else {
		rightAnimalID = animalID;
		//For Test
		NSString *tabFlag = @"animals";
		AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:rightAnimalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];
		itemButton.position = ccp(130,115);
		[self addChild:itemButton z:8 tag:1%8];
		
		CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
		kuang.position = ccp(130,135);
		kuang.scale = 0.7f;
		[self addChild:kuang z:8];
	}

	
}

//生成右边的动物，母的
-(void)generateAnother
{
	DataModelAnimal *serverAnimalDataAnother;
	if (leftAnimalID == animalID) {
		serverAnimalDataAnother = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID];
	}
	else {
		serverAnimalDataAnother = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID];
	}
	
	NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalDataAnother.scientificNameCN];
	NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalDataAnother.picturePrefix];
	NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalDataAnother.originalAnimalId];
	
	NSString *tabFlag = @"animals";
	AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:animalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];
	if(serverAnimalDataAnother.gender == 1)
	{
		itemButton.position = ccp(220,115);
		
		CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
		kuang.position = ccp(220,135);
		kuang.scale = 0.7f;
		[self addChild:kuang z:8];
		
	}
	else {
		itemButton.position = ccp(100,115);
		
		CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
		kuang.position = ccp(100,135);
		kuang.scale = 0.7f;
		[self addChild:kuang z:8];
	}
	
	[self addChild:itemButton z:8 tag:1%8];
	
	
}

//生成下面的可选列表
-(void)generateOthers
{
	//Gen the list of can be mate/marry.
	NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
	DataModelOriginalAnimal *originAnimal;
	NSString *aniID;
	int endNumber = currentPageNum * 8;
	if (endNumber >= [[DataEnvironment sharedDataEnvironment].animalIDs count]) {
		endNumber = [[DataEnvironment sharedDataEnvironment].animalIDs count];
	}
	
	DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:animalID];
	
	currentNum = endNumber - (currentPageNum -1 ) *8 ;
//	if(endNumber > 4)
//		endNumber = 4;
	for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
		originAnimal = [animalIDs objectAtIndex:i];
		aniID = [animalIDs objectAtIndex:i];
		DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
		if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender && aniID != leftAnimalID && aniID != rightAnimalID)
		{
			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalList.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalList.picturePrefix];
			NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalList.originalAnimalId];
			//For Test
			NSString *tabFlag = @"animals";
			AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:aniID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:@selector(updateInfoPanel:) setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.4f];
			itemButton.position = ccp(60 * (i%4) + 70/**this uesed to be 120 pixel***/, self.contentSize.height - 55 * ((i-8*(currentPageNum-1))/4) - 140);
//			itemButton.scale = 200.0f/1024.0f;
			[self addChild:itemButton z:8 tag:i%8];
		}
		
		CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
		kuang.position = ccp(60 * (i%4) + 70,  self.contentSize.height - 55 * ((i-8*(currentPageNum-1))/4) - 120);
		kuang.scale = 0.7f;
		[self addChild:kuang z:8];
	}
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}



-(void) toMate:(Button *)button
{
	//判断是否首次加载物
	if (toMateRateChoose == nil) {
		toMateRateChoose = [[AnimalManageToMateAntsChoose alloc] initWithParam:nil setTarget:self setLeftAnimalId:leftAnimalID setRightAnimalId:rightAnimalID];
		toMateRateChoose.position = ccp(self.contentSize.width/2, toMateRateChoose.contentSize.height/2);
		[self addChild:toMateRateChoose z:20 tag:1999];
	}
	else {		
		//****[toMateRateChoose updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
		toMateRateChoose.position = ccp(self.contentSize.width/2, toMateRateChoose.contentSize.height/2);
	}
}

//Mate confirm button.
//婚前交配，需要farmId，maleID，FemaleId，action(marry or mate)
-(void)MateAnimals:(Button *)button
{
	AnimalManageToMateAntsChoose *antChoose = (AnimalManageToMateAntsChoose *)button.target;
	
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",antChoose.femaledIdBeforeMarry,@"animalId",[NSString stringWithFormat:@"%d",antChoose.count],@"ants",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoMateAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackMateBeforeMarry:" AndFailedSel:@"faultCallback:"];
}

//Mate cancle button.
-(void)cancleMate:(Button *)button
{
	toMateRateChoose.position = ccp(10000, toMateRateChoose.contentSize.height/2);
	//NSLog(@"取消");
}

-(void)resultCallbackMateBeforeMarry:(NSObject *)value
{
	//处理婚前交配结果。
	
	[[FeedbackDialog sharedFeedbackDialog] addMessage:@"交配失败"];
}


-(void) resultCallbackMa:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];

		switch (code) {
			case 1:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚成功"];
				break;
			default:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚失败"];
				break;
		}
	//MessageDialog *dialog = [[MessageDialog alloc] initDialog:@"ItemInfoPane.png" setTarget:self setSelector:nil];
	NSLog(@"操作已成功!");
}


-(void) toMarry:(Button *)button
{
	//TODO: Imp the marry func
	//POP up the Animal management success or not info panel.
	
	NSString *action = @"marry";
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;

	DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID];

	if(leftAnimalID == nil || rightAnimalID == nil)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"选择异性"];
	}
	else {
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",leftAnimalID,@"maleId",rightAnimalID,@"femaleId",action,@"action",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoMateAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackMa:" AndFailedSel:@"faultCallback:"];
		serverAnimalDataOne.coupleAnimalId = rightAnimalID;
		DataModelAnimal *serverAnimalDataRight = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID];
		serverAnimalDataRight.coupleAnimalId = leftAnimalID;
	}
}



-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

//This to update the panel. Re-generate the one to mate and all the list of its pair.
//Move the clicked one to the right position and re-generate the list.
//List all and remove the one just clicked.

-(void)updateInfoPanel:(AnimalManagementButtonItem *)buttonItem
{
	[self removeAllChildrenWithCleanup:YES];
	[self addTitle];
	
	DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:buttonItem.animalID];
	if(serverAnimalList.gender == 1)
	{
		leftAnimalID = buttonItem.animalID;
		rightAnimalID = animalID;
	}
	else {
		leftAnimalID = animalID;
		rightAnimalID = buttonItem.animalID;
	}
	
	[self generateOne];
	[self generateAnother];
	[self generateOthers];
	[self generateButtons];
}

-(void)updateInfo:(NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	[self removeAllChildrenWithCleanup:YES];
	[self addTitle];
	itemId = itId;
	itemType = itType;
	itemBuyType = @"goldEgg";
	itemPrice = 0;
	NSDictionary *dic;	
	//判断商品的类型,显示不同的物品信息到不同的信息框中
	if (itemType == @"animal") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals retain];
		DataModelOriginalAnimal *originalAnimal = [dic objectForKey:itemId];
		itemPrice = originalAnimal.basePrice;
		if (originalAnimal.antsPrice > 0) {
			itemBuyType = @"ant";
			itemPrice = originalAnimal.antsPrice;
		}
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice]; 
		NSString *picFileName = [NSString stringWithFormat:@"%@.png",originalAnimal.picturePrefix];
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		
		CCLabel *nameLbl = [CCLabel labelWithString:originalAnimal.scientificNameCN fontName:@"Arial" fontSize:30];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
		[self addChild:nameLbl z:10];
		[originalAnimal release];
	}
	[dic release];
	
	//添加确认和取消按钮,回调函数分别为[ManageContainer buyItem] 和[ManageContainer Cancel]
	Button *confirmBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Confirm.png" setTarget:target setSelector:@selector(buyItem:) setPriority:39 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Cancel.png" setTarget:target setSelector:@selector(cancel:) setPriority:39 offsetX:0 offsetY:0 scale:1.0f];
	
	//为Button绑定购买的对象,最终传入到[ManageContainer buyItem]中作为参数发送到服务端
	confirmBtn.target = self;
	confirmBtn.position = ccp(self.contentSize.width/2 - 200, 50);
	cancelBtn.position = ccp(self.contentSize.height/2 + 200, 50);
	[self addChild:confirmBtn z:10];
	[self addChild:cancelBtn z:10];
	if(itemType != @"goods")
	{
		ScalerPane *scalerPane = [[ScalerPane alloc] initWithCounter:1 max:8 delta:1 target:self price:itemPrice z:39 Priority:0 setPathname:@"加减显示器.png" setlength:0];
		scalerPane.position = ccp(200,200);
		[self addChild:scalerPane z:5];
	}
//	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:45];
//	transBackground.scale = 17.0f;
//	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
//	[self addChild:transBackground z:5];
}

-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;

	[item setTexture: itemImg];
	[item setTextureRect: rect];
	item.scale = 150.0/1024.0f;
	[itemImg release];
	CCSprite *buyImg;
	if (buyType == @"goldEgg") {
		buyImg = [CCSprite spriteWithFile:@"金蛋ico.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
	}
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(item.contentSize.width/2 + 150, self.contentSize.height  - item.contentSize.height /2 - 150);
	buyImg.position = ccp(item.position.x - 60, 300);
	priceLbl.position = ccp(item.position.x + 20 , 300);
//	buyImg.scale = 1.5f;
//	priceLbl.scale = 1.5f;
	
	[self addChild:item z:7];
	[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
}							  


-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	[title release];
	[itemId release];
	[itemType release];
	[itemBuyType release];
	[priceLbl release];

	[parentTarget release];
	[leftAnimalID release];
	[rightAnimalID release];
	[animalID release];
	[toMateRateChoose release];
	[infoMessagePanelTest release];
	[super dealloc];
}

@end

