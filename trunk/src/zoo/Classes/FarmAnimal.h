//
//  FarmAnimal.h
//  zoo
//
//  Created by Rainbow on 7/5/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "FarmAnimalView.h"


@interface FarmAnimal : NSObject
{
	FarmAnimalView *view;
	
	NSString *name;
	NSString *type;
	CGFloat speed;
	
	int currDirection;
	int currStatus;
	int standRemain;
	
	CGPoint targetPosition;
	CGPoint currSpeed;
	
	CGRect limitRect;
}

-(id) initWithView:(CCSprite*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue;

@end

@interface FarmAnimal (Private)

-(void) findTarget;
-(void) calculateSpeed;
-(void) findDirection;

@end
