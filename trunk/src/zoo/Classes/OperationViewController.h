//
//  OperationViewController.h
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "GameMainScene.h"
#import "NetView.h"
#import "NormalFoodView.h"
#import "PesticideView.h"
#import "PickupView.h"
#import "PowerFoodView.h"
#import "ProductYieldFoodView.h"
#import "PutAntView.h"
#import "PutSnakeView.h"
#import "SpecialFoodView.h"
#import "SummonView.h"
#import "CleaningView.h"
#import "EfficientFoodView.h"
#import "FirecrackerView.h"
#import "InfusionView.h"


@interface OperationViewController : NSObject {

	NetView *netview;
	NormalFoodView *normalFoodView;
	PesticideView *pesticideView;
	PickupView *pickupView;
	PowerFoodView *powerFoodView;;
	ProductYieldFoodView *productYieldFoodView;
	PutAntView *putAntView;
	PutSnakeView *putSnakeView;
	SpecialFoodView *specialFoodView;
	SummonView *summonView;
	CleaningView *cleaningView;
	EfficientFoodView *efficientFoodView;
	FirecrackerView *firecrackerView;
	InfusionView *infusionView;
}
+(OperationViewController *) sharedOperationViewController;
-(void)play: (NSString *)type setPosition:(CGPoint) position;
@end
