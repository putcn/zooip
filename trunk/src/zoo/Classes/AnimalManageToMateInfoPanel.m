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



//列出来一个主角，男左，女右。列出来下边可以选择的对象。点击下面的对象。配角进行变换。
//还有结婚和交配按钮。
//实现逻辑:
//generateButtons 生成点击按钮和事件。
//generateOne 生成左侧的。
//Another 生成右侧的。
//Others 列出所有相关的。
//关闭之后重新生成。
//点左边右边的没有变化，点下边的，根据需要，替换到左边或者右边。

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
animalID,
buttonsOfList;

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
		[self addTitle];
		//priceLbl = [[CCLabel alloc] retain];
		//****[self updateInfo:itId type:itType setTarget:target];
		
		//********
		
		currentPageNum = 1;
		leftAnimalID = @"";
		rightAnimalID = @"";
		
		// add button.
		[self generateButtons];
		
		//generate one button. Generate other button list.
		[self generateOne];
		[self generateOthers];
		
		
//		self.scale = 300.0f/1024.0f;
	}
	return self;
}

-(void)OverIconHandler
{
	
	self.position = ccp(1000, 1880);
}



//生成结婚和交配按钮
-(void)generateButtons
{
	Button *toMateBtn = [[Button alloc] initWithLabel:@"交配" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"红色按钮.png" setTarget:self setSelector:@selector(toMate:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	Button *toMarryBtn = [[Button alloc] initWithLabel:@"结婚" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"黄色按钮.png" setTarget:self setSelector:@selector(toMarry:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	//toMarryBtn.flipX = YES;
	toMateBtn.position = ccp(self.contentSize.width/2 + 100, 25);
	toMarryBtn.position = ccp(self.contentSize.width/2 - 100, 25);
	[self addChild:toMateBtn z:8 tag:666];
	[self addChild:toMarryBtn z:8 tag:777];
	
	Button *statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"X.png" setTarget:self
										   setSelector:@selector(OverIconHandler) setPriority:30 offsetX:-1 offsetY:2 scale:1.0f];
	statusIcon.position = ccp(300, 190);
	[self addChild:statusIcon z:7 tag:555];
	//[statusIcon release];
	
	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:35];
	transBackground.scale = 5.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:-1 tag:444];
}

//生成左边的动物，公的 tag:1%8
-(void)generateOne
{
	if(firstType == @"left")
	{
		//Gen the one clicked at the right postion.
		[self removeChildByTag:oneTag cleanup:YES];
	}
	else {
		[self removeChildByTag:anotherTag cleanup:YES];
	}

	DataModelAnimal *serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:animalID];
	NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
	NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
	NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];
	
	NSString *tabFlag = @"animals";
	AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:leftAnimalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];	

	//MALE
	if (serverAnimalData2.gender == 1) {
		leftAnimalID = animalID;
		firstType = @"left";
		//For Test
		itemButton.position = ccp(130,130);
	
		oneTag = 888;
		anotherTag = 999;

	}
	//FEMALE
	else {
		firstType = @"right";
		rightAnimalID = animalID;
			
		itemButton.position = ccp(220,130);
		oneTag = 888;
		anotherTag = 999;
		//For Test
//		NSString *tabFlag = @"animals";
//		AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:rightAnimalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.5f];
		
//		[self addChild:itemButton z:8 tag:1%8];
	}
		[self addChild:itemButton z:8 tag:oneTag];
}

//生成右边的动物，母的 tag 1%9
-(void)generateAnother
{
	DataModelAnimal *serverAnimalDataAnother;
	if (firstType == @"left") {
		[self removeChildByTag:anotherTag cleanup:YES];
		serverAnimalDataAnother = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID];
	}
	else {
		[self removeChildByTag:anotherTag cleanup:YES];
		serverAnimalDataAnother = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID];
	}
	
	NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalDataAnother.scientificNameCN];
	NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalDataAnother.picturePrefix];
	NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalDataAnother.originalAnimalId];
	
	NSString *tabFlag = @"animals";
	AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:animalID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:nil setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];
	if(firstType == @"right")
	{
		//left
		itemButton.position = ccp(130,130);
	}
	else {
		//right
		itemButton.position = ccp(220,130);
		
	}
	[self addChild:itemButton z:8 tag:anotherTag];
}

//生成下面的可选列表
-(void)generateOthers
{
	//Gen the list of can be mate/marry.
	NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
	DataModelOriginalAnimal *originAnimal;
	NSString *aniID;
	int endNumber = currentPageNum * 8;
//	if (endNumber >= [[DataEnvironment sharedDataEnvironment].animalIDs count]) {
		endNumber = [[DataEnvironment sharedDataEnvironment].animalIDs count];
//	}
	
	DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:animalID];
	
//	currentNum = endNumber - (currentPageNum -1 ) *8 ;

	
	int kTemp = 0;
//	for (int i = (currentPageNum -1)*8; i < endNumber; i ++)
	AnimalManagementButtonItem *itemButton;
	DataModelAnimal *serverAnimalList;
	for (int i = 0; i < endNumber; i ++)
	{
		originAnimal = [animalIDs objectAtIndex:i];
		aniID = [animalIDs objectAtIndex:i];
		serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
		if(serverAnimalDataOne.animalType == serverAnimalList.animalType && serverAnimalList.gender != serverAnimalDataOne.gender && aniID != leftAnimalID && aniID != rightAnimalID)
		{
			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalList.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalList.picturePrefix];
			NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalList.originalAnimalId];
			//For Test
			NSString *tabFlag = @"animals";
			itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:aniID setImagePath:picFileName setAnimalName:animalName setTarget:self setSelector:@selector(updateThisPanel:) setPriority:30 offsetX:1 offsetY:1 setPictureScale:0.7f];
			itemButton.position = ccp(60 * (kTemp%4) + 70/**this uesed to be 120 pixel***/, self.contentSize.height - 55 * ((kTemp-8*(currentPageNum-1))/4) - 130);
//			itemButton.scale = 200.0f/1024.0f;
			[self addChild:itemButton z:8 tag:(kTemp+100)%800];
		
			NSLog(@"***XXX*****XX***%d***XXX*****XX***%d",(kTemp+100),(kTemp+100)%800);
			
			doubleDigits[listCount] = (kTemp+100) % 800;
			listCount ++;
			kTemp++;
		}

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
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	NSString *action = @"marry";
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",antChoose.femaledIdBeforeMarry,@"femaleId",[NSString stringWithFormat:@"%d",antChoose.count],@"ants",action,@"action",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoMateAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackMateBeforeMarry:" AndFailedSel:@"faultCallback:"];
}

//toMateAnimal------action=marry
//toMateAnimal------action=mate 	动物结婚
//动物结婚前的交配 	farmId                    动物园ID
//maleId                    公动物ID
//femaleId                 母动物ID
//
//ants
//蚂蚁数量
//action                    操作行为（marry or mate）

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
			{
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚成功"];
				((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID]).coupleAnimalId = rightAnimalID;
				((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID]).coupleAnimalId = leftAnimalID;
			}
				break;
			case 2:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚成功"];
				break;
			case 4:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的公动物，不能配对"];
				break;
			case 5:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的母动物，不能配对"];
				break;
			case 8:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"近亲不能结婚"];
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
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:25];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2-4);
	[self addChild:titleLbl z:10 tag:333];
}

-(void)updateThisPanel:(AnimalManagementButtonItem *)buttonItem
{
	DataModelAnimal *serverAnimalList = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:buttonItem.animalID];
	if(firstType == @"right")
	{
		leftAnimalID = buttonItem.animalID;
	}
	else {
		rightAnimalID = buttonItem.animalID;
	}

	[self generateAnother];
}

//This to update the panel. Re-generate the one to mate and all the list of its pair.
//Move the clicked one to the right position and re-generate the list.
//List all and remove the one just clicked.

-(void)updateInfoPanel:(AnimalManagementButtonItem *)buttonItem
{
	//[self removeAllChildrenWithCleanup:YES];
	//[self removeAllChildrenWithCleanup:NO];
	
	for(int i =0 ;i<20;i++)
	{
		if(doubleDigits[i] !=0)
		[self removeChildByTag:doubleDigits[i] cleanup:NO];
		NSLog(@"***XXX*****XX***%d",doubleDigits[i]);
	}
	[self removeChildByTag:999 cleanup:NO];
	[self removeChildByTag:888 cleanup:NO];
	[self removeChildByTag:777 cleanup:NO];
	[self removeChildByTag:666 cleanup:NO];
	//[self removeChildByTag:555 cleanup:NO];
	[self removeChildByTag:444 cleanup:NO];
	[self removeChildByTag:333 cleanup:NO];

	animalID =  buttonItem.animalID;
	CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = bg.contentSize;
	[self setTexture:bg];
	[self setTextureRect: rect];
	[bg release];
	self.title = @"动物结婚";
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
	//[self generateAnother];
	[self generateOthers];
	[self generateButtons];
}					  


-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	[title release];
	[itemId release];
	[itemType release];
	[itemBuyType release];
	[priceLbl release];

//	[parentTarget release];
	[leftAnimalID release];
	[rightAnimalID release];
	[animalID release];
	[infoMessagePanelTest release];
	
	[buttonsOfList release];
	[super dealloc];
}

@end

