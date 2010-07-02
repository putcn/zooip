//
//  AnimalToolTip.m
//  zoo
//
//  Created by Rainbow on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnimalToolTip.h"
#import "DataModelAnimal.h"
#import "LoadingBar.h"
@implementation AnimalToolTip

-(id) initWithAnimalId: (NSString *)aniId
{
	if ((self = [super init])) {
		totalTime = 100;
		remainTime = 20;
		
		CCTexture2D *InfoBg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Tooltip_BG.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = InfoBg.contentSize;
		[self setTexture: InfoBg];
		[self setTextureRect: rect];
		[InfoBg release];
		
		DataModelAnimal *animal = [[[DataEnvironment sharedDataEnvironment] animals] objectForKey:aniId];
		NSString *animalName = animal.scientificNameCN;
		nRemainTime = animal.remain;
		[animal release];
		
		nameLbl = [CCLabel labelWithString:animalName fontName:@"Arial" fontSize:15];
		[nameLbl setColor:ccc3(0, 0, 0)];
//		NSString *currentDate = [NSString stringWithFormat:@"%@",[NSDate date]];
		NSString *currentDate = [NSString stringWithFormat:@"%d",nRemainTime];
		
		timeLbl = [CCLabel labelWithString:currentDate fontName:@"Arial" fontSize:15];
		[timeLbl setColor:ccc3(255, 0, 0)];
		nameLbl.position = ccp(nameLbl.contentSize.width/2, self.contentSize.height);
		timeLbl.position = ccp(timeLbl.contentSize.width/2, self.contentSize.height - nameLbl.contentSize.height);
		
		//黄色进度条
		CCSprite *load_yellow_left = [CCSprite spriteWithFile:@"LeftOrgBla.png"];
		CCSprite *load_yellow_middle = [CCSprite spriteWithFile:@"processORG2.png"];
		CCSprite *load_yellow_right = [CCSprite spriteWithFile:@"rightOrg2.png"];
		CCSprite *load_yellow_Cololeft = [CCSprite spriteWithFile:@"leftOrg.png"];
		CCSprite *load_yellow_Colomiddle = [CCSprite spriteWithFile:@"processOrg.png"];
		CCSprite *load_yellow_Coloright = [CCSprite spriteWithFile:@"rightOrg.png"];
		
		LoadingBar *load_yellow = [[LoadingBar alloc] initWithCCSprite:@"hehe" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
														 setSpriteLeft:load_yellow_left setSpriteMidele: load_yellow_middle setSpriteRight: load_yellow_right
													 setSpriteColoLeft: load_yellow_Cololeft setSpriteColoMidele: load_yellow_Colomiddle setSpriteColoRight: load_yellow_Coloright
															   offsetX:80 offsetY:0 setpercent:0 setLength:1 setTextLegth:-5 - 80*2 setTextHight:12];
		load_yellow.position = ccp(self.contentSize.width/2-40 , 70);
		[self addChild:load_yellow z:10];
		
		//蓝色进度条
		CCSprite *load_left = [CCSprite spriteWithFile:@"rightBlue2.png"];
		CCSprite *load_middle = [CCSprite spriteWithFile:@"blueBg.png"];
		CCSprite *load_right = [CCSprite spriteWithFile:@"right.png"];
		CCSprite *load_Cololeft = [CCSprite spriteWithFile:@"leftBlue.png"];
		CCSprite *load_Colomiddle = [CCSprite spriteWithFile:@"processBlue.png"];
		CCSprite *load_Coloright = [CCSprite spriteWithFile:@"rightBlue.png"];
		
		LoadingBar *load = [[LoadingBar alloc] initWithCCSprite:@"hehe" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
												  setSpriteLeft:load_left setSpriteMidele: load_middle setSpriteRight: load_right
											  setSpriteColoLeft: load_Cololeft setSpriteColoMidele: load_Colomiddle setSpriteColoRight: load_Coloright
														offsetX:80 offsetY:0 setpercent:0 setLength:1 setTextLegth:-5 - 80*2 setTextHight:12];
		load.position = ccp(self.contentSize.width/2-40 , 25);
		[self addChild:load z:10];
		
		
		
		
//		processorBar = [CCSprite spriteWithFile:@"inner.png"];
//		processorFrame = [CCSprite spriteWithFile:@"outer.png"];
//		processorBar.scaleX = remainTime/totalTime;
//		NSLog(@"-----%d",remainTime/totalTime);
//		processorFrame.position = ccp(processorFrame.contentSize.width/2 , self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
//		processorBar.position = ccp(processorBar.contentSize.width/2 * remainTime/totalTime, self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
		[self addChild:nameLbl z:6];
		[self addChild:timeLbl z:6];
//		[self addChild:processorBar z:6];
//		[self addChild:processorFrame z:6];
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:) interval:1.0]];
		self.visible = false;
		
	}
	return self;
}

-(void) tick: (ccTime)dt
{
	[timeLbl setString:[NSString stringWithFormat:@"%d", nRemainTime]];
	//remainTime = remainTime - 1;
//	processorBar.scaleX = remainTime/totalTime;
//	processorBar.position = ccp(processorBar.contentSize.width/2 * remainTime/totalTime, self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);

}

-(void)dealloc
{
	[nameLbl release];
	[timeLbl release];
//	[processorBar release];
//	[processorFrame release];
	[animalId release];
	
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}
@end
