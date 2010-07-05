//
//  SellinfoPane.m
//  zoo
//
//  Created by admin on R.O.C. 99/5/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SellinfoPane.h"
#import "TransBackground.h"
#import "ScalerPane.h"

@implementation SellinfoPane
@synthesize title,itemId,itemType,itemBuyType,count,eggTotalNum;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	if ((self = [super init])) {
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		/*		
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ItemInfoPane.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		 
		 
		[self setTextureRect: rect];
		[bg release];
		 */
		self.title = @"出 售";
		priceLbl = [[CCLabel alloc] retain];
		
		[self addTitle];
		
		[self updateInfo:itId type:itType setTarget:target];

		
	}
	return self;
}
-(void)addTitle
{
	
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:20];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2-80, self.contentSize.height + 80);
	[self addChild:titleLbl z:10];
}



-(void)updateInfo:(NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	
	[self removeAllChildrenWithCleanup:YES];
	
	itemId = itId;
	itemType = itType;
	itemPrice = 0;
	NSDictionary *dic;
	if (itemType == @"普通蛋") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs retain];
		DataModelStorageEgg *storageEggs = [dic objectForKey:itemId];
		itemPrice = storageEggs.eggPrice;
		
		NSString *eggNameEn = [NSString stringWithFormat: @"%@",storageEggs.eggNameEN];
		NSArray *eggNameArr = [eggNameEn componentsSeparatedByString:@" "];
		
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice]; 
		NSString *picFileName = [NSString stringWithFormat:@"%@Egg.png",[eggNameArr objectAtIndex:0] ];
//		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		
		CCLabel *nameLbl = [CCLabel labelWithString:storageEggs.eggName fontName:@"Arial" fontSize:25];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2, self.contentSize.height -20);
		[self addChild:nameLbl z:10];
		
		
		NSString *signPrice = [NSString stringWithFormat:@"单个售价 : %d  金蛋",itemPrice];
		CCLabel *signPriceLbl = [CCLabel labelWithString:signPrice fontName:@"Arial" fontSize:20];
		[signPriceLbl setColor:ccc3(0, 0, 0)];
		signPriceLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - 60);
		[self addChild:signPriceLbl z:10];
		
		eggTotalNum  = storageEggs.numOfProduct + storageEggs.numOfStolen;
		NSString *eggTotalNumStr = [NSString stringWithFormat:@" 总  数 :  %d",eggTotalNum];
		
		CCLabel *toalEggNumLbl = [CCLabel labelWithString:eggTotalNumStr fontName:@"Arial" fontSize:20];
		[toalEggNumLbl setColor:ccc3(0, 0, 0)];
		toalEggNumLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - 90);
		[self addChild:toalEggNumLbl z:10];
		
		
		NSString *sumPrice = [NSString stringWithFormat:@"总计收入 : %d  金蛋",itemPrice * eggTotalNum];
		CCLabel *sumPriceLbl = [CCLabel labelWithString:sumPrice fontName:@"Arial" fontSize:20];
		[sumPriceLbl setColor:ccc3(0, 0, 0)];
		sumPriceLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - 120);
		[self addChild:sumPriceLbl z:10];
		
		Button *confirmBtn = [[Button alloc] initWithLabel:@"出售" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"确定.png" setTarget:target setSelector:@selector(sellEggItem:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
		Button *cancelBtn = [[Button alloc] initWithLabel:@"取消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"取消.png" setTarget:target setSelector:@selector(cancel:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
		
		//为Button添加绑定的参数列表
		confirmBtn.target = self;
		confirmBtn.position = ccp(self.contentSize.width/2 - 60, 35);
		cancelBtn.position = ccp(self.contentSize.height/2 + 120, 35);
		[self addChild:confirmBtn z:10];
		[self addChild:cancelBtn z:10];
		
		//数目选择孔件
//		ScalerPane *scalerPane = [[ScalerPane alloc] initWithCounter:1 max:eggTotalNum delta:1 target:self price:itemPrice z:7 Priority:0];
//		scalerPane.position = ccp(self.contentSize.width/2, self.contentSize.height - 80);
//		[self addChild:scalerPane z:5];
	}
	
	if (itemType == @"受精蛋") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs retain];
		DataModelStorageZygoteEgg *modelZygoteEggs = [dic objectForKey:itemId];
		itemPrice = modelZygoteEggs.eggPrice;
		
		//=========
		NSString *picName = [NSString stringWithFormat:@"%@",modelZygoteEggs.eggId];
		NSString *eggName = [NSString stringWithFormat:@"%@",modelZygoteEggs.eggNameEN];
		NSString *eggTotal = [NSString stringWithFormat:@"555"];
		NSArray *eNameArr = [picName componentsSeparatedByString:@" "];
		
		NSString *picFileName = [NSString stringWithFormat:@"zygote%@.png",picName];
		
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice]; 
		NSString *priceStr = [NSString stringWithFormat:@"受精卵售价 : %d 金蛋",itemPrice];
		
//		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		
		CCLabel *nameLbl = [CCLabel labelWithString:modelZygoteEggs.eggName fontName:@"Arial" fontSize:20];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 , self.contentSize.height-20 );
		[self addChild:nameLbl z:10];
		
//		CCLabel *eggPriLbl = [CCLabel labelWithString:priceStr fontName:@"Arial" fontSize:20];
//		[eggPriLbl setColor:ccc3(0, 0, 0)];
//		eggPriLbl.position = ccp(self.contentSize.width/2, self.contentSize.height-20 );
//		[self addChild:eggPriLbl z:10];
		
		CCLabel *zygoteEggPriLbl = [CCLabel labelWithString:priceStr fontName:@"Arial" fontSize:20];
		[zygoteEggPriLbl setColor:ccc3(0, 0, 0)];
		zygoteEggPriLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - 60);
		[self addChild:zygoteEggPriLbl z:10];
		
		CCLabel *eggProduceLbl = [CCLabel labelWithString:@"普通动物产量 ：33" fontName:@"Arial" fontSize:20];
		[eggProduceLbl setColor:ccc3(0, 0, 0)];
		eggProduceLbl.position = ccp(self.contentSize.width/2, self.contentSize.height -90);
		[self addChild:eggProduceLbl z:10];
		
		//modelZygoteEggs
		NSString *zygoYield =[NSString stringWithFormat:@"受精蛋预计产量 ：%d",modelZygoteEggs.baseYield];
	
		CCLabel *zygoteEggProduceLbl = [CCLabel labelWithString:zygoYield fontName:@"Arial" fontSize:20];
		[zygoteEggProduceLbl setColor:ccc3(0, 0, 0)];
		zygoteEggProduceLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - 120);
		[self addChild:zygoteEggProduceLbl z:10];
		
		CCLabel *sexLbl = [CCLabel labelWithString:modelZygoteEggs.zygoteGender fontName:@"Arial" fontSize:20];
		[sexLbl setColor:ccc3(0, 0, 0)];
		sexLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 350);
		[self addChild:sexLbl z:10];
		
		
		//孵化按钮
		Button *hatchBtn = [[Button alloc] initWithLabel:@"孵化" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"确定.png" setTarget:target setSelector:@selector(hatchHandler:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
		hatchBtn.target = self;
		hatchBtn.position = ccp(self.contentSize.height/2-30 , 35);
		[self addChild:hatchBtn z:10];
		
		Button *confirmBtn = [[Button alloc] initWithLabel:@"出售" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"确定.png" setTarget:target setSelector:@selector(sellEggItem:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
		Button *cancelBtn = [[Button alloc] initWithLabel:@"取消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"取消.png" setTarget:target setSelector:@selector(cancel:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
		
		//为Button添加绑定的参数列表
		confirmBtn.target = self;
		confirmBtn.position = ccp(self.contentSize.width/2, 35);
		cancelBtn.position = ccp(self.contentSize.height/2 + 150, 35);
		[self addChild:confirmBtn z:10];
		[self addChild:cancelBtn z:10];
		
		[modelZygoteEggs release];
	}
	[dic release];
	
	
	

	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:35];
	transBackground.scale = 5.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:5];
	
	[transBackground release];

	 
}

-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price
{
	
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
//	item.scale = 2.0f;
	[itemImg release];
	
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(item.contentSize.width/2 + 150, self.contentSize.height  - item.contentSize.height /2 - 150);
	priceLbl.position = ccp(item.position.x + 20 , 200);
//	priceLbl.scale = 1.5f;
	
	[self addChild:item z:7];
	[self addChild:priceLbl z:7];
	 
	 
}							  

-(void) updatePrice:(NSDictionary *)values
{
	
	count = [[values objectForKey:@"count"] intValue];
	[priceLbl setString:[NSString stringWithFormat:@"总计收入 :  %d  金蛋", count * itemPrice]];
	 
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	[title       release];
	[itemId      release];
	[itemType    release];
	[itemBuyType release];
	[priceLbl    release];
	[super dealloc];
}

@end