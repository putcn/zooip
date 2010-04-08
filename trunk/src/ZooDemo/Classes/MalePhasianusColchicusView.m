//
//  MalePhasianusColchicusView.m
//  ZooDemo
//
//  Created by Rainbow on 4/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MalePhasianusColchicusView.h"


@implementation MalePhasianusColchicusView

-(id) initWithPrefix:(NSString *)prefix
{	
	if ((self = [super initWithPrefix:prefix])) {
		
		CCAnimation* animation0 = [CCAnimation animationWithName:@"Up" delay:0.02f];
		CCAnimation* animation1 = [CCAnimation animationWithName:@"RightUp" delay:0.02f];
		CCAnimation* animation2 = [CCAnimation animationWithName:@"Right" delay:0.02f];
		CCAnimation* animation3 = [CCAnimation animationWithName:@"RightDown" delay:0.02f];
		CCAnimation* animation4 = [CCAnimation animationWithName:@"Down" delay:0.02f];
		CCAnimation* animation5 = [CCAnimation animationWithName:@"LeftDown" delay:0.02f];
		CCAnimation* animation6 = [CCAnimation animationWithName:@"Left" delay:0.02f];
		CCAnimation* animation7 = [CCAnimation animationWithName:@"LeftUp" delay:0.02f];
		
		for (int i = 1; i<=25; i++) {
			[animation0 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_B_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation0]] forKey:@"up"];
		
		for (int i = 1; i<=25; i++) {
			[animation1 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_BL_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation1]] forKey:@"rightUp"];
		
		for (int i = 1; i<=25; i++) {
			[animation2 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_L_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation2]] forKey:@"right"];
		
		for (int i = 1; i<=25; i++) {
			[animation3 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_FL_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation3]] forKey:@"rightDown"];
		
		for (int i = 1; i<=25; i++) {
			[animation4 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_F_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation4]] forKey:@"down"];
		
		for (int i = 1; i<=25; i++) {
			[animation5 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_FL_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation5]] forKey:@"leftDown"];
		
		for (int i = 1; i<=25; i++) {
			[animation6 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_L_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation6]] forKey:@"left"];
		
		for (int i = 1; i<=25; i++) {
			[animation7 addFrameWithFilename:[NSString stringWithFormat:@"malePhasianusColchicus_walk_BL_%d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation7]] forKey:@"leftUp"];
		
	}
	return self;
	
}


-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	switch (currDirectionValue) {
		case 0:
			[self stopAllActions];
			self.flipX = NO;
			[self runAction:[animationTable objectForKey:@"up"]]; 
			break;
		case 1:
			[self stopAllActions];
			self.flipX = YES;
			[self runAction:[animationTable objectForKey:@"rightUp"]]; 
			break;
		case 2:
			[self stopAllActions];
			self.flipX = YES;
			[self runAction:[animationTable objectForKey:@"right"]]; 
			break;
		case 3:
			[self stopAllActions];
			self.flipX = YES;
			[self runAction:[animationTable objectForKey:@"rightDown"]]; 
			break;
		case 4:
			[self stopAllActions];
			self.flipX = NO;
			[self runAction:[animationTable objectForKey:@"down"]];
			break;
		case 5:
			[self stopAllActions];
			self.flipX = NO;
			[self runAction:[animationTable objectForKey:@"leftDown"]]; 
			break;
		case 6:
			[self stopAllActions];
			self.flipX = NO;
			[self runAction:[animationTable objectForKey:@"left"]]; 
			break;
		case 7:
			[self stopAllActions];
			self.flipX = NO;
			[self runAction:[animationTable objectForKey:@"leftUp"]]; 
			break;
		default:
			break;
			
	}
}

-(void) dealloc
{
	//[animationTable release];
	[super dealloc];
}

@end
