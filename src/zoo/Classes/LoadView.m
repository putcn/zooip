//
//  LoadView.m
//  zoo
//
//  Created by jiang ziwei on 10-6-10.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "LoadView.h"
#import "GameMainScene.h"
#import "LoadingBar.h"
@implementation LoadView

-(void) MyLoadingView
{
	CCTexture2D *loadImg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"house.png" ofType:nil]]];
	CGRect rect = CGRectZero;
	rect.size = loadImg.contentSize;
	[self setTexture: loadImg];
	[self setTextureRect: rect];
	[loadImg release];
	
	self.position = ccp(100,100);
	numberLbl = [CCLabel labelWithString:[NSString stringWithFormat:@" "] fontName:@"Arial" fontSize:20];
//	[numberLbl setString:[NSString stringWithFormat:@"%@", nStep]];
	[numberLbl setColor:ccc3(255, 0, 0)];
	numberLbl.position = self.position;
	[self addChild:numberLbl z:14]; 	
}


-(void) SetLabelString:(NSString*) nStep
{
	[numberLbl setString:[NSString stringWithFormat:@"%@", nStep]];
	
	CCSprite *load_left = [CCSprite spriteWithFile:@"loading_左圆角.png"];
	CCSprite *load_middle = [CCSprite spriteWithFile:@"loading_中间.png"];
	CCSprite *load_right = [CCSprite spriteWithFile:@"loading_右圆角.png"];
	CCSprite *load_Cololeft = [CCSprite spriteWithFile:@"loading_进度_左圆角.png"];
	CCSprite *load_Colomiddle = [CCSprite spriteWithFile:@"loading_进度_中间.png"];
	CCSprite *load_Coloright = [CCSprite spriteWithFile:@"loading_进度_右圆角.png"];
	int itemPrice = 70*nStep.intValue/10.0;
	
	int nlong = 1;
	if(itemPrice <= 1)
	{
		nlong = 0;
	}
	else if(itemPrice >= 70)
	{
		nlong = 2;
	}
	
	
	LoadingBar *load = [[LoadingBar alloc] initWithCCSprite:@"" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:35 setTarget:self 
											  setSpriteLeft:load_left setSpriteMidele: load_middle setSpriteRight: load_right
										  setSpriteColoLeft: load_Cololeft setSpriteColoMidele: load_Colomiddle setSpriteColoRight: load_Coloright
													offsetX:70 offsetY:itemPrice setpercent:nlong setLength:2 setTextLegth:15 setTextHight:-2];
	load.position = ccp(self.contentSize.width/2-70 , 50);
	[self addChild:load z:14];
	
}

//
//-(void) RemoveView 
//{
//	[[GameMainScene sharedGameMainScene] removeDialogFromScreen:numberLbl ];
//	[[GameMainScene sharedGameMainScene] removeDialogFromScreen:load ];
//}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
//	[numberLbl release];
//	[load release];
	
	[super dealloc];
}


@end
