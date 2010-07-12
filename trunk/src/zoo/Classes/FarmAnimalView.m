//
//  FarmAnimalView.m
//  zoo
//
//  Created by Rainbow on 7/5/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FarmAnimalView.h"


@implementation FarmAnimalView

-(id) init
{
	if ( (self=[super init]) )
	{
		//uiController = [[UIController sharedUIController] alloc];
		NSArray *dirkeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
		NSArray *dirvalues = [NSArray arrayWithObjects:@"up",@"rightUp",@"right",@"rightDown",@"down",@"leftDown",@"left",@"leftUp",nil];
		dirctions = [[NSDictionary dictionaryWithObjects:dirvalues forKeys:dirkeys] retain];
		
		NSArray *stakeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
		NSArray *stavalues = [NSArray arrayWithObjects:@"stop",@"eat",@"ill",@"sleep",@"stand",@"walk",@"fly",@"swimming",@"spread",@"crow",@"transition",@"landing",nil];
		statuses = [[NSDictionary dictionaryWithObjects:stavalues forKeys:stakeys] retain];
		
		animationTable = [[[NSMutableDictionary alloc] init] retain];
		// 在子类中实现这个方法
		// 根据传入的prefix初始化8个方向的动画，
		// 比如prefix是bird，向上走的动画第一帧图片可能就是bird_walk_up_001
		// 初始化后存储到animationTable中
		// [animationTable setObject:动画对象 forKey:键];
		// 使用时通过 [animationTable objectForKey:键] 得到动画对象，之后播发即可
	}
	return self;
}

@end
