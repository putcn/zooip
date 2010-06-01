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
@synthesize title;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	if ((self = [super init])) {
		itemId = itId;
		itemType = itType;
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ItemInfoPane.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		self.title = @"出售卵";
		[self addTitle];
		[self addInfo:target];
	}
	return self;
}
-(void)addTitle
{
	NSLog(@"%@",title);
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

//-(void)addInfo:(id)target
//{
//	NSDictionary *dic;
//	if (itemType == @"egg") {
//		dic = [(NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs retain];
//		DataModelStorageEgg *storageEgg = [dic objectForKey:itemId];
//		
//		int buyType = 0;
//		NSString *price = [NSString stringWithFormat:@"%d",originalAnimal.basePrice];
//		if (originalAnimal.antsPrice > 0) {
//			buyType = 1;
//			price = [NSString stringWithFormat:@"%d",originalAnimal.antsPrice];
//		}
//		
//		
//		NSString *picName = [NSString stringWithFormat:@"%@",storageEgg.eggNameEN];
//		//NSString *eggName = [NSString stringWithFormat:@"%@",storageEgg.eggNameEN];
//		//NSString *eggTotal = [NSString stringWithFormat:@"%d",storageEgg.numOfProduct];
//		NSArray *eNameArr = [picName componentsSeparatedByString:@" "];
//		
//		NSString *picFileName = [NSString stringWithFormat:@"%@Egg.png",[eNameArr objectAtIndex:0] ];		
//		[self setImg:picFileName setBuyType:buyType setPrice:price];
//		
//		CCLabel *nameLbl = [CCLabel labelWithString:originalAnimal.scientificNameCN fontName:@"Arial" fontSize:30];
//		[nameLbl setColor:ccc3(0, 0, 0)];
//		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
//		[self addChild:nameLbl z:10];
//		[originalAnimal release];
//	}
//	if (itemType == @"eggs") {
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
//	
//	
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


-(void)updateInfo:(NSString *) itId type: (NSString *) itType setTarget:(id)target
{
	[self removeAllChildrenWithCleanup:YES];
	[self addTitle];
	itemId = itId;
	itemType = itType;
	itemBuyType = @"goldEgg";
	itemPrice = 0;
	NSDictionary *dic;
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
	if (itemType == @"food") {
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
		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
		[self addChild:nameLbl z:10];
		[food release];
	}
	if (itemType == @"goods") {
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
		nameLbl.position = ccp(self.contentSize.width/2 + 200, self.contentSize.height - 100);
		[self addChild:nameLbl z:10];
		[goods release];
	}
	[dic release];
	Button *confirmBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Confirm.png" setTarget:target setSelector:@selector(buyItem:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"Cancel.png" setTarget:target setSelector:@selector(cancel:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	//为Button添加绑定的参数列表
	confirmBtn.target = self;
	//confirmBtn.params = [NSDictionary dictionaryWithObjectsAndKeys:itemId, @"itemId", itemType, @"itemType", [NSString stringWithFormat:@"%d",itemBuyType], @"itemBuyType",nil];
	confirmBtn.position = ccp(self.contentSize.width/2 - 200, 50);
	cancelBtn.position = ccp(self.contentSize.height/2 + 200, 50);
	[self addChild:confirmBtn z:10];
	[self addChild:cancelBtn z:10];
	
	ScalerPane *scalerPane = [[ScalerPane alloc] initWithCounter:1 max:10 delta:1 target:self price:itemPrice z:7 Priority:0];
	scalerPane.position = ccp(200,200);
	[self addChild:scalerPane z:5];
	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:5];
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
		buyImg = [CCSprite spriteWithFile:@"goldegg.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"goldant.png"];
	}
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(item.contentSize.width/2 + 150, self.contentSize.height  - item.contentSize.height /2 - 150);
	buyImg.position = ccp(item.position.x - 60, 300);
	priceLbl.position = ccp(item.position.x + 20 , 300);
	buyImg.scale = 1.5f;
	priceLbl.scale = 1.5f;
	
	[self addChild:item z:7];
	[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
}							  

-(void) updatePrice:(NSDictionary *)values
{
	count = [[values objectForKey:@"count"] intValue];
	[priceLbl setString:[NSString stringWithFormat:@"%d", count * itemPrice]];
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end