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
	NSMutableDictionary *animationTable;
	NSDictionary *dirctions;
	NSDictionary *statuses;
	NSString *dogId;
}

@property (nonatomic, retain)NSString *dogId;
-(id) init;
-(void) update:(int)currDirectionValue status:(int)currStatusValue;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
