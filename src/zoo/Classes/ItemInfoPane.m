//
//  ItemInfoPane.m
//  zoo
//
//  Created by Rainbow on 5/26/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ItemInfoPane.h"
#import "TransBackground.h"
#import "ScalerPane.h"

@implementation ItemInfoPane
@synthesize 
title,
itemId,
itemType,
itemBuyType,
count;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	if ((self = [super init])) {
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_buy.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.title = @"购买动物";
		priceLbl = [[CCLabel alloc] retain];
		[self updateInfo:itId type:itType setTarget:target];
//		self.scale = 300.0f/1024.0f;
	}
	return self;
}
-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:20];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2-80, self.contentSize.height/2+80);
	[self addChild:titleLbl z:10];
}

//-(void)addInfo:(id)target
//{
//	NSDictionary *dic;
//	if (itemType == @"animal") {
//		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals retain];
//		DataModelOriginalAnimal *originalAnimal = [dic objectForKey:itemId];
//		
//		int buyType = 0;
//		NSString *price = [NSString stringWithFormat:@"%d",originalAnimal.basePrice];
//		if (originalAnimal.antsPrice > 0) {
//			buyType = 1;
//			price = [NSString stringWithFormat:@"%d",originalAnimal.antsPrice];
//		}
//		NSString *picFileName = [NSString stringWithFormat:@"%@.png",originalAnimal.picturePrefix];
//		[self setImg:picFileName setBuyType:buyType setPrice:price];
//		
//		CCLabel *nameLbl = [CCLabel labelWithString:originalAnimal.scientificNameCN fontName:@"Arial" fontSize:30];
//		[nameLbl setColor:ccc3(0, 0, 0)];
//		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
//		[self addChild:nameLbl z:10];
//		[originalAnimal release];
//	}
//	if (itemType == @"food") {
//		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].foods retain];
//		DataModelFood *food = [dic objectForKey:itemId];
//		int buyType = 0;
//		NSString *price = [NSString stringWithFormat:@"%d",food.foodPrice];
//		if (food.antsRequired > 0) {
//			buyType = 1;
//			price = [NSString stringWithFormat:@"%d",food.antsRequired];
//		}
//		NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",food.foodImg];
//		[self setImg:picFileName setBuyType:buyType setPrice:price];
//		CCLabel *nameLbl = [CCLabel labelWithString:food.foodName fontName:@"Arial" fontSize:30];
//		[nameLbl setColor:ccc3(0, 0, 0)];
//		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
//		[self addChild:nameLbl z:10];
//		[food release];
//	}
//	if (itemType == @"goods") {
//		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].goods retain];
//		DataModelGood *goods = [dic objectForKey:itemId];
//		[goods release];
//	}
//	[dic release];
//	Button *confirmBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Confirm.png" setTarget:target setSelector:@selector(buyItem:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
//	Button *cancelBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Cancel.png" setTarget:target setSelector:@selector(cancel:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
//	//为Button添加绑定的参数列表
//	confirmBtn.params = [NSDictionary dictionaryWithObjectsAndKeys:itemId, @"itemId", itemType, @"itemType", itemBuyType, @"itemBuyType",nil];
//	confirmBtn.position = ccp(self.contentSize.width/2 - 200, 50);
//	cancelBtn.position = ccp(self.contentSize.height/2 + 200, 50);
//	[self addChild:confirmBtn z:10];
//	[self addChild:cancelBtn z:10];
//}
//	

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
	if (itemType == @"动物") {
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
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];
		[originalAnimal release];
	}
	if (itemType == @"饲料") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].foods retain];
		DataModelFood *food = [dic objectForKey:itemId];
		itemPrice = food.foodPrice;
		if (food.antsRequired > 0) {
			itemBuyType = @"ant";
			itemPrice = food.antsRequired;
		}
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice]; 
		NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",food.foodImg];
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		CCLabel *nameLbl = [CCLabel labelWithString:food.foodName fontName:@"Arial" fontSize:30];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];
		[food release];
	}
	if (itemType == @"道具") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].goods retain];
		DataModelGood *goods = [dic objectForKey:itemId];
		itemPrice = goods.goodsGoldenPrice;
		if (goods.goodsAntsPrice > 0){
			itemBuyType = @"ant";
			itemPrice = goods.goodsAntsPrice;
		}
		NSString *price = [NSString stringWithFormat:@"%d", itemPrice];
		NSString *picFileName;
		if ([goods.goodsPicture intValue]== 1) {
			picFileName = @"tibentanmastiff_rest_01.png";
		}
		else if([goods.goodsPicture intValue]== 2)
		{	
			picFileName = @"chinemy_walk_left_01.png";
		}
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		CCLabel *nameLbl = [CCLabel labelWithString:goods.goodsName	fontName:@"Arial" fontSize:30];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];
		[goods release];
	}
	[dic release];
	
	CCLabel *nameLbl = [CCLabel labelWithString:@"输入购买数量(1－500)" fontName:@"Arial" fontSize:13];
	[nameLbl setColor:ccc3(0, 0, 0)];
	nameLbl.position = ccp(self.contentSize.width/2 - 75, 25);
	[self addChild:nameLbl z:10];
	
	//添加确认和取消按钮,回调函数分别为[ManageContainer buyItem] 和[ManageContainer Cancel]
	Button *confirmBtn = [[Button alloc] initWithLabel:@"确定" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:20 setBackground:@"确定.png" setTarget:target setSelector:@selector(buyItem:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"取消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:20 setBackground:@"取消.png" setTarget:target setSelector:@selector(cancel:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	
	//为Button绑定购买的对象,最终传入到[ManageContainer buyItem]中作为参数发送到服务端
	confirmBtn.target = self;
	confirmBtn.position = ccp(self.contentSize.width/2 + 30, 35);
	cancelBtn.position = ccp(self.contentSize.height/2 + 170, 35);
	[self addChild:confirmBtn z:10];
	[self addChild:cancelBtn z:10];
	if(itemType != @"道具")
	{
		ScalerPane *scalerPane;
		if(itemType == @"动物")
			scalerPane = [[ScalerPane alloc] initWithCounter:1 max:10 delta:1 target:self price:itemPrice z:39 Priority:30 setPathname:@"加减显示器.png" setlength:0];
		else if(itemType == @"饲料")
			scalerPane = [[ScalerPane alloc] initWithCounter:500 max:10000 delta:500 target:self price:itemPrice z:39 Priority:30 setPathname:@"加减显示器.png" setlength:0];
		scalerPane.position = ccp(0,0);
		[self addChild:scalerPane z:10];
	}
	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:40];
	transBackground.scale = 5.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:-1];
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
	CCSprite *buyImg;
	if (buyType == @"goldEgg") {
		buyImg = [CCSprite spriteWithFile:@"金蛋ico.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
	}
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(item.contentSize.width/2 +40, self.contentSize.height  - item.contentSize.height /2-40);
	buyImg.position = ccp(item.position.x - 40, self.contentSize.height  - item.contentSize.height /2-80);
	priceLbl.position = ccp(item.position.x + 20 , self.contentSize.height  - item.contentSize.height /2-80);
//	buyImg.scale = 1.5f;
//	priceLbl.scale = 1.5f;
	
	[self addChild:item z:7];
	[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
}							  


//从计数器ScalerPance回调的价格计算函数, 传入参数values封装了要买的数量
-(void) updatePrice:(NSDictionary *)values
{
	count = [[values objectForKey:@"count"] intValue];
	[priceLbl setString:[NSString stringWithFormat:@"%d", count * itemPrice]];
}

-(void) dealloc
{
	[title release];
	[itemId release];
	[itemType release];
	[itemBuyType release];
	[priceLbl release];
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
