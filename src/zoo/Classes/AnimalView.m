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

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	NSArray *dirkeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
	NSArray *dirvalues = [NSArray arrayWithObjects:@"up",@"rightUp",@"right",@"rightDown",@"down",@"leftDown",@"left",@"leftUp",nil];
	NSDictionary *dirctions = [NSDictionary dictionaryWithObjects:dirvalues forKeys:dirkeys];
	
	NSArray *stakeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
	NSArray *stavalues = [NSArray arrayWithObjects:@"stop",@"eat",@"ill",@"sleep",@"stand",@"walk",@"fly",@"swimming",@"trasition",@"landing",@"spread",@"crow",nil];
	NSDictionary *statuses = [NSDictionary dictionaryWithObjects:stavalues forKeys:stakeys];
	
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	NSString *status = [statuses objectForKey: [NSString stringWithFormat:@"%d", currStatusValue]];
	
	CCTexture2D *bg;
	CGRect rect;
	if ([direction isEqualToString:@"right"]) 
	{
		self.flipX =YES;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"rightUp"]) {
		self.flipX =YES;
		direction = @"leftUp";
	}
	else if ([direction isEqualToString:@"rightDown"]){
		self.flipX =YES;
		direction = @"leftDown";
	}
	else 
	{
		self.flipX = NO;
	}
	
	NSString *showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];

	// 在状态改变时该函数会被调用，根据currDirectionValue找到相应的动画对象进行播放即可
	// currDirection:
	//	up 正上
	//	rightUp 右上
	//	right 右
	//	rightDown 右下
	//	down 下
	//	leftDown 左下
	//	left 左
	//	leftRight 左上
	
	// currStatusValue 表示当前状态，游泳、飞行、走路或者静止，目前先不实现，作为预留接口
	//	stop 静止
	//	eat 吃食
	//	ill 生病
	//	sleep 休息
	//	stand 站立
	//	walk 行走
	//	fly 飞行
	//	swimming 游泳
	//	transition 起飞
	//	landing 着陆
	//	spread 开屏
	//	crow 打鸣
	NSLog(@"当前的动物状态为 ***** %@ *****", showKey);
	if ([status isEqualToString:@"stop"]||[status isEqualToString:@"ill"] || [status isEqualToString:@"sleep"] || [status isEqualToString:@"stand"])
	{
		[self stopAllActions];
		bg = [animationTable objectForKey:showKey];
		rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
	}
	else {
		[self stopAllActions];
		[self runAction:[animationTable objectForKey:showKey]];
	}

}

-(void) dealloc
{
	[animationTable release];
	[super dealloc];
}

@end




