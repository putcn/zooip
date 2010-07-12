//
//  DogView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "OperationViewController.h"
#import "FarmAnimalView.h"


@interface DogView : FarmAnimalView {
	NSString *dogId;
}

@property (nonatomic, retain)NSString *dogId;

-(void) update:(int)currDirectionValue status:(int)currStatusValue;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
