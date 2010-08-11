//
//  AnimalToMateAntsChoose.m
//  zoo
//
//  Created by Alex Liu on 6/3/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import "AnimalManageToMateAntsChoose.h"
#import "TransBackground.h"
#import "ScalerPane.h"
#import "RandomHelper.h"


//选择蚂蚁需要的弹出窗口
@implementation AnimalManageToMateAntsChoose
@synthesize 
title,
itemId,
itemType,
itemBuyType,
count,
paramsDict,
maledIdBeforeMarry,
femaledIdBeforeMarry,
animalIDAfterMarry,
antsCount;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	if ((self = [super init])) {
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ItemInfoPane.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.title = @"配种";
		priceLbl = [[CCLabel alloc] retain];
		//***[self updateInfo:itId type:itType setTarget:target];
	}
	return self;
}

//initWithParam:params setTarget:self setLeftAnimalId:leftAnimalID setRightAnimalId:rightAnimalID];

-(id)initWithParam:(NSDictionary *)param setTarget:(id)target setLeftAnimalId:(NSString *)leftAnimalID setRightAnimalId:(NSString *) rightAnimalID
{
	if((self =[super init]))
	{		
		maledIdBeforeMarry = leftAnimalID;
		femaledIdBeforeMarry = rightAnimalID;
		animalIDAfterMarry = rightAnimalID;
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.title = @"配种";
		priceLbl = [[CCLabel alloc] retain];
		[self updateButtonsAndRates:target];
		//****[self updateInfo:itId type:itType setTarget:target];
		
		Button *statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"X.png" setTarget:self
											   setSelector:@selector(OverIconHandler) setPriority:20 offsetX:-1 offsetY:2 scale:1.0f];
		statusIcon.position = ccp(300, 190);
		[self addChild:statusIcon z:7 ];
		[statusIcon release];
	}
	return self;
}

-(void)OverIconHandler
{
	self.position = ccp(1000, 1880);
}

-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:20];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2-100, self.contentSize.height - titleLbl.contentSize.height/2-7);
	[self addChild:titleLbl z:10];
}
-(void)updateButtonsAndRates:(id)target
{	
	[self removeAllChildrenWithCleanup:YES];
	[self addTitle];
	
	Button *confirmBtn = [[Button alloc] initWithLabel:@"确定" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:20 setBackground:@"确定.png" setTarget:target setSelector:@selector(MateAnimals:) setPriority:20 offsetX:0 offsetY:0 scale:1.0f];
//	Button *cancelBtn = [[Button alloc] initWithLabel:@"取消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:20 setBackground:@"取消.png" setTarget:target setSelector:@selector(cancleMate:) setPriority:25 offsetX:0 offsetY:0 scale:1.0f];
	
	//为Button绑定购买的对象,最终传入到[ManageContainer buyItem]中作为参数发送到服务端
//	confirmBtn.target = self;
	confirmBtn.position = ccp(self.contentSize.width/2 , 25);
//	cancelBtn.position = ccp(self.contentSize.height/2 , 50);
	[self addChild:confirmBtn z:10];
//	[self addChild:cancelBtn z:10];
	
	//
	CCLabel *titleLbl = [CCLabel labelWithString:@"选择当前产蛋周期下公蛋的概率：" fontName:@"Arial" fontSize:15];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2-20, self.contentSize.height - titleLbl.contentSize.height/2 -40);
	[self addChild:titleLbl z:10];
	
	
	if(itemType != @"goods")
	{
		ScalerPane *scalerPane = [[ScalerPane alloc] initWithCounter:1 max:8 delta:1 target:self price:itemPrice z:39 Priority:10 setPathname:@"加减显示框_2.png" setlength:40];
		scalerPane.position = ccp(self.contentSize.width/2-70, self.contentSize.height/2-30);
		[self addChild:scalerPane z:10];
	}
	
	CCLabel *titleLbl_2 = [CCLabel labelWithString:@"生公蛋的概率：" fontName:@"Arial" fontSize:15];
	[titleLbl_2 setColor:ccc3(0, 0, 0)];
	titleLbl_2.position = ccp(self.contentSize.width/2-50, self.contentSize.height - titleLbl_2.contentSize.height/2 -100);
	[self addChild:titleLbl_2 z:10];
	
//	CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
//	kuang.position = ccp(60 * (kTemp%4) + 70,  self.contentSize.height - 55 * ((kTemp-8*(currentPageNum-1))/4) - 120);
//	kuang.scale = 0.7f;
//	[self addChild:kuang z:8];
	
	CCSprite *load_left = [CCSprite spriteWithFile:@"进度条_橙_左圆角.png"];
	CCSprite *load_middle = [CCSprite spriteWithFile:@"进度条_橙_中间.png"];
	CCSprite *load_right = [CCSprite spriteWithFile:@"进度条_橙_右圆角.png"];
	CCSprite *load_Cololeft = [CCSprite spriteWithFile:@"进度条_橙_进度_左圆角.png"];
	CCSprite *load_Colomiddle = [CCSprite spriteWithFile:@"进度条_橙_进度_中间.png"];
	CCSprite *load_Coloright = [CCSprite spriteWithFile:@"进度条_橙_进度_右圆角.png"];
	
	float nCent = 70.0*count/8;
	if(nCent >= 70)
	{
		nCent = 70;
	}
	
	numberLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"0.0%%"] fontName:@"Arial" fontSize:15];
	[numberLbl setColor:ccc3(0, 0, 0)];
	numberLbl.position = ccp(self.contentSize.width/2 +105, 60);
	[self addChild:numberLbl z:10];
//	NSString* temp = [NSString stringWithFormat:@"%0.1f\%%", nCent];
//	spercent = temp;
	int nlong = 1;
	if(nCent <= 1)
	{
		nlong = 0;
	}
	else if(nCent >= 70)
	{
		nlong = 2;
	}
	
	
	LoadingBar *load_1 = [[LoadingBar alloc] initWithCCSprite:@"" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
											  setSpriteLeft:load_left setSpriteMidele: load_middle setSpriteRight: load_right
										  setSpriteColoLeft: load_Cololeft setSpriteColoMidele: load_Colomiddle setSpriteColoRight: load_Coloright
													offsetX:70 offsetY:nCent setpercent:nlong setLength:2 setTextLegth:15 setTextHight:-2];
	load_1.position = ccp(self.contentSize.width/2-70 , 50);
	[self addChild:load_1 z:10];
	
	[self setImg:@"" setBuyType:@"" setPrice:@"1"];
}


-(void)updateInfo:(NSString *) itId type: (NSString *) itType setTarget:(id)target
{

	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:25];
	transBackground.scale = 17.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:5];
}

-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	item.scale = 2.0f;
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
	buyImg.scale = 1.5f;
	priceLbl.scale = 1.5f;
	
	//[self addChild:item z:7];
	//[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
}							  

//从计数器ScalerPance回调的价格计算函数, 传入参数values封装了要买的数量
-(void) updatePrice:(NSDictionary *)values
{
	count = [[values objectForKey:@"count"] intValue];
	antsCount = count;
	itemPrice = (count-1) * [RandomHelper getRandomNum:6 to:7] + [RandomHelper getRandomNum:6 to:7];
	if(itemPrice > 50)
		itemPrice = 50;
	[priceLbl setString:[NSString stringWithFormat:@"%d", itemPrice]];
	
	
	CCSprite *load_left = [CCSprite spriteWithFile:@"进度条_橙_左圆角.png"];
	CCSprite *load_middle = [CCSprite spriteWithFile:@"进度条_橙_中间.png"];
	CCSprite *load_right = [CCSprite spriteWithFile:@"进度条_橙_右圆角.png"];
	CCSprite *load_Cololeft = [CCSprite spriteWithFile:@"进度条_橙_进度_左圆角.png"];
	CCSprite *load_Colomiddle = [CCSprite spriteWithFile:@"进度条_橙_进度_中间.png"];
	CCSprite *load_Coloright = [CCSprite spriteWithFile:@"进度条_橙_进度_右圆角.png"];
	
	
	float nCent = 70.0*count/24;
	if(nCent >= 35)
	{
		nCent = 35;
	}
	float fToWrite = 100.0*nCent/70;
//	spercent = [NSString stringWithFormat:@"%0.1f\%%", nCent];
	[numberLbl setString:[NSString stringWithFormat:@"%0.1f\%%", fToWrite]];
	int nlong = 1;
	if(nCent <= 1)
	{
		nlong = 0;
	}
	else if(nCent >= 70)
	{
		nlong = 2;
	}
	
	LoadingBar* load = [[LoadingBar alloc] initWithCCSprite:spercent setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
								  setSpriteLeft:load_left setSpriteMidele: load_middle setSpriteRight: load_right
							  setSpriteColoLeft: load_Cololeft setSpriteColoMidele: load_Colomiddle setSpriteColoRight: load_Coloright
										offsetX:70 offsetY:nCent setpercent:nlong setLength:2 setTextLegth:15 setTextHight:-2];
	load.position = ccp(self.contentSize.width/2-70 , 50);
	[self addChild:load z:10];
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	[title release];
	[itemId  release];
	[itemType  release];
	[itemBuyType release];

	[priceLbl release];
	
	
	//for params;
	[paramsDict release];
	
	[maledIdBeforeMarry release];
	[femaledIdBeforeMarry release];
	[animalIDAfterMarry release];
	[super dealloc];
}

@end
