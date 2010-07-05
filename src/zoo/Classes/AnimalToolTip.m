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
		NSInteger animalSex = animal.gender;
		nRemainTime = animal.remain;
		NSInteger nAllTime = animal.stageEndTime;
		
		NSInteger nStatus = animal.birdStage;
		NSInteger nlevel = animal.level;
		[animal release];
		
		if(animalSex == 0)
		{
			animalTop = [animalName stringByAppendingString:@"  母"];
		}
		else if(animalSex == 1)
		{
			animalTop = [animalName stringByAppendingString:@"  公"];
		}
				
		nameLbl = [CCLabel labelWithString:animalTop fontName:@"Arial" fontSize:15];
		[nameLbl setColor:ccc3(0, 0, 0)];
		nameLbl.position = ccp(nameLbl.contentSize.width/2+17, self.contentSize.height-15);
		[self addChild:nameLbl z:6];
		
		
		animalUp = [NSString stringWithFormat:@"%d",nAllTime];
		
		//0＝受精蛋；1＝幼年；2＝青年；3＝成年；4＝老年；
		NSString *strLevel = [NSString stringWithFormat:@"%d",nlevel];
		if(nStatus == 0)
		{
			animalDown = @"受精蛋";
		}
		else if(nStatus == 1)
		{
			animalDown = @"幼年";
		}
		else if(nStatus == 2)
		{
			animalDown = @"青年";
		}
		else if(nStatus == 3)
		{
			if(animalSex == 0)
			{
				NSString *animalName = @"成年 产蛋数:";
				animalDown = [animalName stringByAppendingString:strLevel];
			}
			else if(animalSex == 1)
			{
				animalDown = @"成年";
			}
		}
		else if(nStatus == 4)
		{
			animalDown = @"老年";
		}
//
//		if(animalSex == 0)
//		{
//			sexLbl = [CCLabel labelWithString:@"公" fontName:@"Arial" fontSize:15];
//		}
//		else if(animalSex == 1)
//		{
//			sexLbl = [CCLabel labelWithString:@"母" fontName:@"Arial" fontSize:15];
//		}
//		[sexLbl setColor:ccc3(0, 0, 0)];
//		sexLbl.position = ccp(sexLbl.contentSize.width/2+30, self.contentSize.height);
//		
//		
////		NSString *currentDate = [NSString stringWithFormat:@"%@",[NSDate date]];
//		NSString *currentDate = [NSString stringWithFormat:@"%d",nRemainTime];
//		
//		timeLbl = [CCLabel labelWithString:currentDate fontName:@"Arial" fontSize:15];
//		[timeLbl setColor:ccc3(255, 0, 0)];
//		timeLbl.position = ccp(timeLbl.contentSize.width/2, self.contentSize.height - nameLbl.contentSize.height);
//		
		
//		
//		[self addChild:sexLbl z:6];
//		[self addChild:timeLbl z:6];
		//黄色进度条
		CCSprite *load_yellow_left = [CCSprite spriteWithFile:@"LeftOrgBla.png"];
		CCSprite *load_yellow_middle = [CCSprite spriteWithFile:@"processORG2.png"];
		CCSprite *load_yellow_right = [CCSprite spriteWithFile:@"rightOrg2.png"];
		CCSprite *load_yellow_Cololeft = [CCSprite spriteWithFile:@"leftOrg.png"];
		CCSprite *load_yellow_Colomiddle = [CCSprite spriteWithFile:@"processOrg.png"];
		CCSprite *load_yellow_Coloright = [CCSprite spriteWithFile:@"rightOrg.png"];
		
		LoadingBar *load_yellow = [[LoadingBar alloc] initWithCCSprite:animalUp setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
														 setSpriteLeft:load_yellow_left setSpriteMidele: load_yellow_middle setSpriteRight: load_yellow_right
													 setSpriteColoLeft: load_yellow_Cololeft setSpriteColoMidele: load_yellow_Colomiddle setSpriteColoRight: load_yellow_Coloright
															   offsetX:80 offsetY:0 setpercent:0 setLength:1 setTextLegth:-5 - 80*2 setTextHight:14];
		load_yellow.position = ccp(self.contentSize.width/2-40 , 60);
		[self addChild:load_yellow z:10];
		
		//蓝色进度条
		CCSprite *load_left = [CCSprite spriteWithFile:@"rightBlue2.png"];
		CCSprite *load_middle = [CCSprite spriteWithFile:@"blueBg.png"];
		CCSprite *load_right = [CCSprite spriteWithFile:@"right.png"];
		CCSprite *load_Cololeft = [CCSprite spriteWithFile:@"leftBlue.png"];
		CCSprite *load_Colomiddle = [CCSprite spriteWithFile:@"processBlue.png"];
		CCSprite *load_Coloright = [CCSprite spriteWithFile:@"rightBlue.png"];
		
		LoadingBar *load = [[LoadingBar alloc] initWithCCSprite:animalDown setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
												  setSpriteLeft:load_left setSpriteMidele: load_middle setSpriteRight: load_right
											  setSpriteColoLeft: load_Cololeft setSpriteColoMidele: load_Colomiddle setSpriteColoRight: load_Coloright
														offsetX:80 offsetY:0 setpercent:0 setLength:1 setTextLegth:-5 - 80*2 setTextHight:14];
		load.position = ccp(self.contentSize.width/2-40 , 20);
		[self addChild:load z:10];
		
		
		
		
//		processorBar = [CCSprite spriteWithFile:@"inner.png"];
//		processorFrame = [CCSprite spriteWithFile:@"outer.png"];
//		processorBar.scaleX = remainTime/totalTime;
//		NSLog(@"-----%d",remainTime/totalTime);
//		processorFrame.position = ccp(processorFrame.contentSize.width/2 , self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
//		processorBar.position = ccp(processorBar.contentSize.width/2 * remainTime/totalTime, self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
		
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
