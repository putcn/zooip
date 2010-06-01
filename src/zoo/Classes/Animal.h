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

typedef enum
{
	STATE_NORMAL = 0,
	STATE_CALL = 1,
} ZooAnimalState;

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
	
	CGRect landLandingArea;
	CGRect waterLandingArea;
	
	//0x0000, 第一位为天空，第二位为水，第三位为陆地...
	UInt16 moveArea;
	
	int waitRemain;
}

-(id) initWithView:(CCSprite*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue;
-(id) initWithAnimalData:(DataModelAnimal *) data;

@property (nonatomic, copy) DataModelAnimal *animalData;
@property (nonatomic, assign) UInt16 moveArea;

@end

@interface Animal (Private)

-(void) findTarget;
-(void) calculateSpeed;
-(void) findDirection;
-(void) setupMoveArea:(NSInteger) aliveEdge;
-(void) switchNormalState;
-(void) updateSpeed;
-(BOOL) isCanReach:(CGPoint)targetPoint;
@end
