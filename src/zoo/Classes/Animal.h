//
//  Animal.h
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AnimalView.h"
#import "AnimalViewFactory.h"
#import "DataModelAnimal.h"

@interface Animal : NSObject
{
	AnimalView *view;
	
	DataModelAnimal *animalData;
	CGFloat speed;
	
	int currDirection;
	int currStatus;
	
	CGPoint targetPosition;
	CGPoint currSpeed;
	
	CGRect limitRect;
}

-(id) initWithView:(AnimalView*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue;
-(id) initWithAnimalData:(DataModelAnimal *) data;

@property (nonatomic, copy) DataModelAnimal *animalData;

@end

@interface Animal (Private)

-(void) findTarget;
-(void) calculateSpeed;
-(void) findDirection;

@end
