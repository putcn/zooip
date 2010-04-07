//
//  Animal.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "AnimalView.h"


@interface Animal : NSObject
{
	AnimalView *view;
	
	NSString *name;
	NSString *type;
	CGFloat speed;
	
	int currDirection;
	int currStatus;
	
	CGPoint targetPosition;
	CGPoint currSpeed;
	
	CGRect limitRect;
}

-(id) initWithView:(AnimalView*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue;

@end

@interface Animal (Private)

-(void) findTarget;
-(void) calculateSpeed;
-(void) findDirection;

@end