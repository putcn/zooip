//
//  OperationViewController.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "OperationViewController.h"


@implementation OperationViewController

static OperationViewController *_sharedOperationViewController = nil;

+(OperationViewController *)sharedOperationViewController
{
	@synchronized([OperationViewController class])
	{
		if (!_sharedOperationViewController) {
			_sharedOperationViewController = [[OperationViewController alloc] init];
		}
		return _sharedOperationViewController;
	}
	return nil;
}

-(id) init
{
	if ((self = [super init])) {
		netview = [[NetView alloc] init];
		
		normalFoodView = [[NormalFoodView alloc] init];
		pesticideView = [[PesticideView alloc] init];
		pickupView = [[PickupView alloc] init];
		powerFoodView = [[PowerFoodView alloc] init];
		productYieldFoodView = [[ProductYieldFoodView alloc] init];
		putAntView= [[PutAntView alloc] init];
		putSnakeView = [[PutSnakeView alloc] init];
		specialFoodView = [[SpecialFoodView alloc] init];
		summonView = [[SummonView alloc] init];
		cleaningView = [[CleaningView alloc] init];
		efficientFoodView = [[EfficientFoodView alloc] init];
		firecrackerView = [[FirecrackerView alloc] init];	
		infusionView = [[InfusionView alloc] init];
		
		[normalFoodView setAnchorPoint:ccp(0,0)];
		[pesticideView setAnchorPoint:ccp(0,0)];
		//[pickupView setAnchorPoint:ccp(0.5,0.5)];
		[powerFoodView setAnchorPoint:ccp(0,0)];
		[productYieldFoodView setAnchorPoint:ccp(0,0)];
		//[putAntView setAnchorPoint:ccp(0,0)];
		[putSnakeView setAnchorPoint:ccp(0,0)];
		[specialFoodView setAnchorPoint:ccp(0,0)];
		[summonView setAnchorPoint:ccp(0,0)];
		[cleaningView setAnchorPoint:ccp(0,0)];
		[efficientFoodView setAnchorPoint:ccp(0,0)];
		//[firecrackerView setAnchorPoint:ccp(0,0)];
		[infusionView setAnchorPoint:ccp(0,0)];
		
		[[GameMainScene sharedGameMainScene] addSpriteToStage:normalFoodView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:pesticideView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:pickupView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:powerFoodView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:productYieldFoodView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:putAntView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:putSnakeView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:specialFoodView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:summonView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:cleaningView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:efficientFoodView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:firecrackerView z:6];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:infusionView z:6];
	}
	return self;
}

-(void)play:(NSString *)type setPosition:(CGPoint)position
{
	if (type == @"cleaning") 
	{
		if ([cleaningView numberOfRunningActions] > 0) {
			return;
		}
		cleaningView.position = position;
		[cleaningView play];
	}
	else if(type == @"efficient_food")
	{
		if ([efficientFoodView numberOfRunningActions] > 0) {
			return;
		}
		efficientFoodView.position = position;
		[efficientFoodView play];
	}
	else if(type == @"firecracker")
	{
		if ([firecrackerView numberOfRunningActions] > 0) {
			return;
		}
		firecrackerView.position = position;
		[firecrackerView play];
	}
	else if(type == @"infusion")
	{
		if ([infusionView numberOfRunningActions] > 0) {
			return;
		}
		infusionView.position = position;
		[infusionView play];
	}
	else if(type == @"net")
	{
		if ([netview numberOfRunningActions] > 0) {
			return;
		}
		netview.position = position;
		[netview play];
	}
	else if(type == @"normal_food")
	{
		if ([normalFoodView numberOfRunningActions] > 0) {
			return;
		}
		normalFoodView.position = position;
		[normalFoodView play];
	}
	else if(type == @"pesticide")
	{
		if ([pesticideView numberOfRunningActions] > 0) {
			return;
		}
		pesticideView.position = position;
		[pesticideView play];
	}
	else if(type == @"pickup")
	{
		if ([pickupView numberOfRunningActions] > 0) {
			return;
		}
		pickupView.position = position;
		[pickupView play];
	}
	else if(type == @"power_food")
	{
		if ([powerFoodView numberOfRunningActions] > 0) {
			return;
		}
		powerFoodView.position = position;
		[powerFoodView play];
	}
	else if(type == @"product_yield_food")
	{
		if ([productYieldFoodView numberOfRunningActions] > 0) {
			return;
		}
		productYieldFoodView.position = position;
		[productYieldFoodView play];
	}
	else if(type == @"put_ant")
	{
		if ([putAntView numberOfRunningActions] > 0) {
			return;
		}
		putAntView.position = position;
		[putAntView play];
	}
	else if(type == @"put_snake")
	{
		if ([putSnakeView numberOfRunningActions] > 0) {
			return;
		}
		putSnakeView.position = position;
		[putSnakeView play];
	}
	else if(type == @"special_food")
	{
		if ([specialFoodView numberOfRunningActions] > 0) {
			return;
		}
		specialFoodView.position = position;
		[specialFoodView play];
	}
	else if(type == @"summon")
	{
		if ([summonView numberOfRunningActions] > 0) {
			return;
		}
		summonView.position = position;
		[summonView play];
	}
	else {
		return;
	}

}


// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[netview release];
	[normalFoodView release];
	[pesticideView release];
	[pickupView release];
	[powerFoodView release];
	[productYieldFoodView release];
	[putAntView release];
	[putSnakeView release];
	[specialFoodView release];
	[summonView release];
	[cleaningView release];
	[efficientFoodView release];
	[firecrackerView release];
	[infusionView release];
	
	[super dealloc];
}

@end
