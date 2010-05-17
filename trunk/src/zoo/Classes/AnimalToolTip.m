//
//  AnimalToolTip.m
//  zoo
//
//  Created by Rainbow on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnimalToolTip.h"
#import "DataModelAnimal.h"

@implementation AnimalToolTip

-(id) initWithAnimalId: (NSString *)aniId
{
	if ((self = [super init])) {
		totalTime = 100;
		remainTime = 20;
		CCTexture2D *InfoBg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"AnimalInfo.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = InfoBg.contentSize;
		[self setTexture: InfoBg];
		[self setTextureRect: rect];
		[InfoBg release];
		DataModelAnimal *animal = [[[DataEnvironment sharedDataEnvironment] animals] objectForKey:aniId];
		NSString *animalName = animal.scientificNameCN;
		[animal release];
		nameLbl = [CCLabel labelWithString:animalName fontName:@"Arial" fontSize:15];
		[nameLbl setColor:ccc3(0, 0, 0)];
		NSString *currentDate = [NSString stringWithFormat:@"%@",[NSDate date]];
		timeLbl = [CCLabel labelWithString:currentDate fontName:@"Arial" fontSize:15];
		[timeLbl setColor:ccc3(255, 0, 0)];
		nameLbl.position = ccp(nameLbl.contentSize.width/2, self.contentSize.height);
		timeLbl.position = ccp(timeLbl.contentSize.width/2, self.contentSize.height - nameLbl.contentSize.height);
		
		processorBar = [CCSprite spriteWithFile:@"inner.png"];
		processorFrame = [CCSprite spriteWithFile:@"outer.png"];
		processorBar.scaleX = remainTime/totalTime;
		NSLog(@"-----%d",remainTime/totalTime);
		processorFrame.position = ccp(processorFrame.contentSize.width/2 , self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
		processorBar.position = ccp(processorBar.contentSize.width/2 * remainTime/totalTime, self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);
		[self addChild:nameLbl z:6];
		[self addChild:timeLbl z:6];
		[self addChild:processorBar z:6];
		[self addChild:processorFrame z:6];
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:) interval:1.0]];
		self.visible = false;
		
	}
	return self;
}

-(void) tick: (ccTime)dt
{
	[timeLbl setString:[NSString stringWithFormat:@"%@", [NSDate date]]];
	//remainTime = remainTime - 1;
	processorBar.scaleX = remainTime/totalTime;
	processorBar.position = ccp(processorBar.contentSize.width/2 * remainTime/totalTime, self.contentSize.height - nameLbl.contentSize.height-timeLbl.contentSize.height);

}

-(void)dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}
@end
