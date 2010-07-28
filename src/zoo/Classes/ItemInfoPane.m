//
//  ItemInfoPane.m
//  zoo
//
//  Created by Rainbow on 5/26/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ItemInfoPane.h"
#import "TransBackground.h"
//#import "ScalerPane.h"
#define degreesToRadian(x) (M_PI * (x) / 180.0)
@implementation ItemInfoPane
@synthesize 
title,
itemId,
itemType,
itemBuyType,
itemPrice,
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


-(void)updateInfo:(NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	[self removeAllChildrenWithCleanup:YES];
	CCSprite *gunlunDown = [CCSprite spriteWithFile:@"滚轮下.png"];
	gunlunDown.position = ccp( self.contentSize.width/2, 11 );
	[self addChild:gunlunDown z:10];
	
	wheel = [CCSprite spriteWithFile:@"滚轮数字轮盘.png"];
	wheel.position = ccp( self.contentSize.width/2-5, self.contentSize.height/2-65 );
	[self addChild:wheel z:10];
	
	CCSprite *gunlunUp = [CCSprite spriteWithFile:@"滚轮上.png"];
	gunlunUp.position = ccp( self.contentSize.width/2, self.contentSize.height/2+10 );
	[self addChild:gunlunUp z:10];
	
	[self addTitle];
	
	totalAnt = ((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).antsCurrency;
	totalGold = ((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg;
	
	
	numberField = [[NumberField alloc] initWithCounter:0 target:target z:10 Priority:30 ];
	numberField.position = ccp( self.contentSize.width/2-5, self.contentSize.height/2-63 );
	[self addChild:numberField z:10];
	
	
	
	CCSprite *left = [CCSprite spriteWithFile:@"滚轮数字减.png"];
	left.position = ccp( self.contentSize.width/2-55, self.contentSize.height/2-75 );
	[self addChild:left z:10];
	
	CCSprite *right = [CCSprite spriteWithFile:@"滚轮数字加.png"];
	right.position = ccp( self.contentSize.width/2+50, self.contentSize.height/2-75 );
	[self addChild:right z:10];
	
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
		
		//动物性别
		CCLabel *sexLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:16];
		[sexLbl setColor:ccc3(0, 0, 0)];
		sexLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 80);
		[self addChild:sexLbl z:10];

		if(itemPrice > 0)
		{
			maxCount = totalGold/itemPrice;
			[sexLbl setString:@"性别：母"];
		}
		if (originalAnimal.antsPrice > 0) {
			itemBuyType = @"ant";
			itemPrice = originalAnimal.antsPrice;
			maxCount = totalAnt/itemPrice;
			[sexLbl setString:@"性别：公"];
		}
		
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice*maxCount]; 
		NSString *picFileName = [NSString stringWithFormat:@"%@.png",originalAnimal.picturePrefix];
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		
		//名称
		CCLabel *nameLbl = [CCLabel labelWithString:originalAnimal.scientificNameCN fontName:@"Arial" fontSize:25];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];		
				
		//产蛋次数
		CCLabel *eggCountLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"产蛋次数：%d次",originalAnimal.baseCycle] fontName:@"Arial" fontSize:16];
		[eggCountLbl setColor:ccc3(0, 0, 0)];
		eggCountLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 100);
		[self addChild:eggCountLbl z:10];
		
		//基本产量
		CCLabel *baseCountLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"基本产量：%d个",originalAnimal.baseYield] fontName:@"Arial" fontSize:16];
		[baseCountLbl setColor:ccc3(0, 0, 0)];
		baseCountLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 120);
		[self addChild:baseCountLbl z:10];
	}
	if (itemType == @"饲料") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].foods retain];
		DataModelFood *food = [dic objectForKey:itemId];
		itemPrice = food.foodPrice;
		
		//单价
		CCLabel *foodpriceLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:16];
		[foodpriceLbl setColor:ccc3(0, 0, 0)];
		foodpriceLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 120);
		[self addChild:foodpriceLbl z:10];
		
		if(itemPrice > 0)
		{
			maxCount = totalGold/itemPrice;
			[foodpriceLbl setString:[NSString stringWithFormat:@"单价：%d／千克",itemPrice]];
		}
		if (food.antsRequired > 0) {
			itemBuyType = @"ant";
			itemPrice = food.antsRequired;
			maxCount = totalAnt/itemPrice;
			[foodpriceLbl setString:[NSString stringWithFormat:@"单价：%d／份",itemPrice]];
		}
		
		//效果
		CCLabel *effectLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:16];
		[effectLbl setColor:ccc3(0, 0, 0)];
		effectLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 100);
		[self addChild:effectLbl z:10];
		if([food.foodPower intValue] == 255)
		{
			[effectLbl setString:@"效果：动物基本饲料"];
		}
		else if([food.foodPower intValue] == 1)
		{
			[effectLbl setString:@"效果：产蛋时间缩短1小时"];
		}
		else if([food.foodPower intValue] == 2)
		{
			[effectLbl setString:@"效果：产蛋时间缩短2小时"];
		}
		else if([food.foodPower intValue] == 5)
		{
			[effectLbl setString:@"效果：产蛋时间缩短5小时"];
		}
		else if([food.foodPower intValue] == 30)
		{
			[effectLbl setString:@"效果：提高30%产蛋量"];
		}
		
		
		
		NSString *price = [NSString stringWithFormat:@"%d",itemPrice*maxCount]; 
		NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",food.foodImg];
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		CCLabel *nameLbl = [CCLabel labelWithString:food.foodName fontName:@"Arial" fontSize:25];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];
	}
	if (itemType == @"道具") {
		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].goods retain];
		DataModelGood *goods = [dic objectForKey:itemId];
		itemPrice = goods.goodsGoldenPrice;
		if(itemPrice > 0)
			maxCount = totalGold/itemPrice;
		if (goods.goodsAntsPrice > 0){
			itemBuyType = @"ant";
			itemPrice = goods.goodsAntsPrice;
			maxCount = totalAnt/itemPrice;
		}
		
		NSString *price = [NSString stringWithFormat:@"%d", itemPrice*maxCount];
		NSString *picFileName;
		if ([goods.goodsPicture intValue]== 1) {
			picFileName = @"tibentanmastiff_rest_01.png";
		}
		else if([goods.goodsPicture intValue]== 2)
		{	
			picFileName = @"chinemy_walk_left_01.png";
		}
		[self setImg:picFileName setBuyType:itemBuyType setPrice:price];
		
		CCLabel *nameLbl = [CCLabel labelWithString:goods.goodsName	fontName:@"Arial" fontSize:25];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(self.contentSize.width/2 + 50, self.contentSize.height - 50);
		[self addChild:nameLbl z:10];
		
	}
	[dic release];
	[numberField setCount:maxCount];
	count = maxCount; 
//	CCLabel *nameLbl = [CCLabel labelWithString:@"输入购买数量(1－500)" fontName:@"Arial" fontSize:13];
//	[nameLbl setColor:ccc3(0, 0, 0)];
//	nameLbl.position = ccp(self.contentSize.width/2 - 75, 25);
//	[self addChild:nameLbl z:10];
	
	//添加确认和取消按钮,回调函数分别为[ManageContainer buyItem] 和[ManageContainer Cancel]
	Button *confirmBtn = [[Button alloc] initWithLabel:@"确定" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:18 setBackground:@"确定.png" setTarget:target setSelector:@selector(buyItem:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"取消" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:18 setBackground:@"取消.png" setTarget:target setSelector:@selector(cancel:) setPriority:30 offsetX:0 offsetY:0 scale:1.0f];	
	//为Button绑定购买的对象,最终传入到[ManageContainer buyItem]中作为参数发送到服务端
	confirmBtn.target = self;
	confirmBtn.position = ccp(self.contentSize.width/2 - 110, 30);
	cancelBtn.position = ccp(self.contentSize.height/2 + 170, 30);
	[self addChild:confirmBtn z:10];
	[self addChild:cancelBtn z:10];
	
	
//	if(itemType != @"道具")
//	{
//		ScalerPane *scalerPane;
//		if(itemType == @"动物")
//		{
//			count = 1;
//			scalerPane = [[ScalerPane alloc] initWithCounter:1 max:10 delta:1 target:self price:itemPrice z:39 Priority:30 setPathname:@"加减显示器.png" setlength:0];
//		}
//		else if(itemType == @"饲料")
//		{
//			count = 1;
//			scalerPane = [[ScalerPane alloc] initWithCounter:1 max:1000 delta:50 target:self price:itemPrice z:39 Priority:30 setPathname:@"加减显示器.png" setlength:0];
//		}
//		scalerPane.position = ccp(0,0);
//		[self addChild:scalerPane z:10];
//	}
	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:40];
	transBackground.scale = 5.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:-1];
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
	CCSprite *buyImg;
	if (buyType == @"goldEgg") {
		buyImg = [CCSprite spriteWithFile:@"金蛋ico.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
	}
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:18];
	[priceLbl setColor:ccc3(0, 0, 0)];
	
	item.position = ccp(item.contentSize.width/2 +40, self.contentSize.height  - item.contentSize.height /2-40);
	buyImg.position = ccp(item.position.x - 35, self.contentSize.height  - item.contentSize.height /2-95);
	priceLbl.position = ccp(item.position.x + 15 , self.contentSize.height  - item.contentSize.height /2-95);
//	buyImg.scale = 1.5f;
//	priceLbl.scale = 1.5f;
	
	[self addChild:item z:10];
	[self addChild:buyImg z:10];
	[self addChild:priceLbl z:10];
}							  


//从计数器ScalerPance回调的价格计算函数, 传入参数values封装了要买的数量
-(void) updatePrice:(NSDictionary *)values
{
	count = [[values objectForKey:@"count"] intValue];
	[priceLbl setString:[NSString stringWithFormat:@"%d", count * itemPrice]];
}

-(void) dealloc
{
	[numberField release];
	[title release];
	[itemId release];
	[itemType release];
	[itemBuyType release];
	[priceLbl release];
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [touch locationInView: [touch window]];
	NSLog(@"location.y :%d",location.y);
	NSLog(@"self.position.x:%d",self.position.x);
	if ( (location.y > 175&&location.y < 300) &&self.position.x < 500)
	{
//		CGPoint location = [touch locationInView: [touch window]];
		startValue = location.y;
		return YES;
	}
	return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [touch locationInView: [touch window]];
	
	//NSLog(@"%f += %f - %f", wheel.rotation, location.x, startValue);
	NSLog(@"numberField getCount:%d",[numberField getCount]);
	float increment = (location.y - startValue);
	
	[numberField addCount:round(increment)];
	
	startValue = location.y;
	
	if ([numberField getCount] >= 0 && [numberField getCount] <= maxCount)
	{
		wheel.rotation +=  degreesToRadian(increment) * -50;
	}
	NSLog(@"numberField getCount:%d",[numberField getCount]);
	
	if ([numberField getCount] < 1) 
		[numberField setCount:1];
	if ([numberField getCount] > maxCount)
		[numberField setCount:maxCount];
	count = [numberField getCount];
	NSString *price = [NSString stringWithFormat:@"%d",itemPrice * [numberField getCount]];
	[priceLbl setString:price];
}
@end
