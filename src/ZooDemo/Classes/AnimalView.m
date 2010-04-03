//
//  AnimalView.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnimalView.h"


@implementation AnimalView

-(id) initWithPrefix:(NSString*)prefix
{
	if ( (self=[super init]) )
	{
		animationTable = [[NSMutableDictionary alloc] init];
		
		// 在子类中实现这个方法
		// 根据传入的prefix初始化8个方向的动画，
		// 比如prefix是bird，向上走的动画第一帧图片可能就是bird_walk_up_001
		// 初始化后存储到animationTable中
		// [animationTable setObject:动画对象 forKey:键];
		// 使用时通过 [animationTable objectForKey:键] 得到动画对象，之后播发即可
	}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	// 在状态改变时该函数会被调用，根据currDirectionValue找到相应的动画对象进行播放即可
	// currDirection:
	//	0 正上
	//	1 右上
	//	2 右
	//	3 右下
	//	4 下
	//	5 左下
	//	6 左
	//	7 左上
	
	// currStatusValue 表示当前状态，游泳、飞行、走路或者静止，目前先不实现，作为预留接口
}

-(void) dealloc
{
	[animationTable release];
	[super dealloc];
}

@end
