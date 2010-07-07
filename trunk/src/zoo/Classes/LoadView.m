//
//  LoadView.m
//  zoo
//
//  Created by jiang ziwei on 10-6-10.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "LoadView.h"
#import "GameMainScene.h"

@implementation LoadView

-(void) MyLoadingView
{
	numberLbl = [CCLabel labelWithString:[NSString stringWithFormat:@" "] fontName:@"Arial" fontSize:20];
//	[numberLbl setString:[NSString stringWithFormat:@"%@", nStep]];
	[numberLbl setColor:ccc3(255, 0, 0)];
	numberLbl.position = ccp(100, 100);

	load = [CCSprite spriteWithFile:@"house.png"];
	load.position = ccp(100,100);
		
	[[GameMainScene sharedGameMainScene] addDialogToScreen:numberLbl z:14];
	[[GameMainScene sharedGameMainScene] addDialogToScreen:load z:4];
}


-(void) SetLabelString:(NSString*) nStep
{
	[numberLbl setString:[NSString stringWithFormat:@"%@", nStep]];
}


-(void) RemoveView 
{
	[[GameMainScene sharedGameMainScene] removeDialogFromScreen:numberLbl ];
	[[GameMainScene sharedGameMainScene] removeDialogFromScreen:load ];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
//	[numberLbl release];
//	[load release];
	
	[super dealloc];
}


@end
