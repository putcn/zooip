//
//  OperationEndView.m
//  zoo
//
//  Created by Rainbow on 5/20/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "OperationEndView.h"


@implementation OperationEndView

-(id)initWithExperience:(NSInteger)experience setPosition:(CGPoint)position setNumber:(NSInteger)number
{
	[self initWithFile:@"operationEnd.png"];
	self.position = position;
	[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:6];
	CCLabel *experienceLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"Experience: %d",experience] fontName:@"Arial" fontSize:15];
	[experienceLbl setColor:ccc3(255, 0, 0)];
	experienceLbl.position = ccp(experienceLbl.contentSize.width/2, self.contentSize.height);
	[self addChild:experienceLbl z:7];
	if (number != 0) {
		CCLabel *numberLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"Number: %d",number] fontName:@"Arial" fontSize:15];
		[numberLbl setColor:ccc3(255, 0, 0)];
		numberLbl.position = ccp(numberLbl.contentSize.width/2, self.contentSize.height - experienceLbl.contentSize.height);
		[self addChild:numberLbl z:7];
	}
	CCMoveTo *moveTo = [CCMoveTo actionWithDuration:1.0 position:ccp(position.x, position.y + 50)];
	CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1.0];
	CCSpawn *spawn = [CCSpawn actions:moveTo,fadeOut,nil];
	CCCallFuncN *actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteShowFinished:)]; 
	CCSequence *sequence = [CCSequence actions:spawn, actionMoveDone,nil];
	[self runAction:sequence];
	return self;
}

-(void)spriteShowFinished:(id)sender
{
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:self];
	[self release];
}
// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	[super dealloc];
}
@end
