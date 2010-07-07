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
		NSString *animalName = animal.scientificNameCN;//动物类别
		NSInteger animalSex = animal.gender;//动物性别
		nRemainTime = animal.remain;//剩余时间
		NSInteger nMiddleTime = animal.baseInterval*3600;//孵化周期
		
		NSString * name = animal.animalName;//名字
		
		NSInteger nStatus = animal.birdStage;//动物状态
		NSInteger nlevel = animal.level;//动物现在产蛋次数
		NSInteger nCycle = animal.baseCycle;//动物总产蛋次数
		[animal release];
		
		if(animalSex == 0)
		{
			animalTop = [animalName stringByAppendingString:@":"];
			animalTop = [animalTop stringByAppendingString:name];
			animalTop = [animalTop stringByAppendingString:@"(母)"];
		}
		else if(animalSex == 1)
		{
			animalTop = [animalName stringByAppendingString:@":"];
			animalTop = [animalTop stringByAppendingString:name];
			animalTop = [animalTop stringByAppendingString:@"(公)"];
		}
				
		nameLbl = [CCLabel labelWithString:animalTop fontName:@"Arial" fontSize:15];
		[nameLbl setColor:ccc3(0, 0, 0)];
		if(animalSex == 0)
		{
			nameLbl.position = ccp(nameLbl.contentSize.width/2+15, self.contentSize.height-15);
		}
		else if(animalSex == 1)
		{
			nameLbl.position = ccp(nameLbl.contentSize.width/2+15, self.contentSize.height-40);
		}
		
		[self addChild:nameLbl z:6];
		
		
		NSInteger nHour = nRemainTime/3600;
		NSInteger nCent = nRemainTime%3600/60;
		NSInteger nSecond = nRemainTime%3600%60;
		float fTime = 0;
		int nyellowChoose = 0;
		
		
		if(animalSex == 0)
		{
			if(nHour > 0)
			{
				animalUp = [NSString stringWithFormat:@"距产蛋:%d小时",nHour];
			}
			else if(nCent > 0)
			{
				animalUp = [NSString stringWithFormat:@"距产蛋:%d分",nCent];
			}
			else if(nSecond > 0)
			{
				animalUp = [NSString stringWithFormat:@"距产蛋:%d秒",nSecond];
			}
			
			fTime = 80 - 80.0*nRemainTime/nMiddleTime;
			if(fTime != 0)
			{
				nyellowChoose = 1;
			}
			if(80 - fTime < 1)
			{
				nyellowChoose = 2;
			}
		}
		
		
		//0＝受精蛋；1＝幼年；2＝青年；3＝成年；4＝老年；
		float nPcent = 80.0*nlevel/nCycle;
		NSString *strLevel = [NSString stringWithFormat:@"%d/%d",nlevel,nCycle];
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
//			if(animalSex == 0)
//			{
				NSString *animalName = @"成年 产蛋:";
				animalDown = [animalName stringByAppendingString:strLevel];
//			}
//			else if(animalSex == 1)
//			{
//				animalDown = @"成年";
//			}
		}
		else if(nStatus == 4)
		{
			animalDown = @"老年";
		}

		if(animalSex == 0)
		{
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
																   offsetX:80 offsetY:fTime setpercent:nyellowChoose setLength:1 setTextLegth:-9 - 80*2 setTextHight:14];
			load_yellow.position = ccp(self.contentSize.width/2-40 , 60);
			[self addChild:load_yellow z:10];
			
		}
				
		
		
		int nTOChoose = 0;
		if(nPcent != 0)
		{
			nTOChoose = 1;
		}
		if(80 - nPcent < 1)
		{
			nTOChoose = 2;
		}
		
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
														offsetX:80 offsetY:nPcent setpercent:nTOChoose setLength:1 setTextLegth:-9 - 80*2 setTextHight:14];
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
