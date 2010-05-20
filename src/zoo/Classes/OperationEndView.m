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
	CCTexture2D *optionBg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"operationEnd.png" ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = optionBg.contentSize;
	[self setTexture: optionBg];
	[self setTextureRect: rect];
	[optionBg release];
	[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:6];
	self.position = position;
	
	CCLabel *experienceLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"Experience: %d",experience] fontName:@"Arial" fontSize:15];
	[experienceLbl setColor:ccc3(255, 0, 0)];
	experienceLbl.position = ccp(experienceLbl.contentSize.width/2, self.contentSize.height);
	[self addChild:experienceLbl z:6];
	if (number != 0) {
		CCLabel *numberLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"Number: %d",number] fontName:@"Arial" fontSize:15];
		[numberLbl setColor:ccc3(255, 0, 0)];
		numberLbl.position = ccp(numberLbl.contentSize.width/2, self.contentSize.height - experienceLbl.contentSize.height);
		[self addChild:numberLbl z:6];
	}	
	CCMoveTo *moveTo = [CCMoveTo actionWithDuration:2.0 position:ccp(position.x, position.y + 100)];
	CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:2.0];
	CCSpawn *spawn = [CCSpawn actions:moveTo,fadeOut,nil];
	CCCallFuncN *actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)]; 
	CCSequence *sequence = [CCSequence actions:spawn, actionMoveDone,nil];
	[self runAction:sequence];
	return self;
}

-(void)spriteShowFinished:(id)sender
{
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:self];
}

@end
