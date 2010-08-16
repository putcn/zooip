//
//  DisapartView.h
//  zoo
//
//  Created by AlexLiu on 8/16/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecPopViewController.h"


@interface DisapartView : UIViewController {
	UIScrollView* animalScrollView;
	UIImageView* rightUpImageView;
	
	UIImageView* leftUpImageView;
	
	int	prevButtonIndex;
	int	m_nprevButtonIndex;	
	
	NSMutableArray* m_arrPic;
	
	int m_nSelectedAniIndex;
	
	int m_nSexIndex;
	
	NSString* leftAnimalID;
	NSString* rightAnimalID;
	NSString* tempLeft;
	NSString* tempRight;
	
	NSMutableArray* m_arrANIMALID;
	SecPopViewController *secPopView;
}

@property(nonatomic, retain) NSString* leftAnimalID;
@property(nonatomic, retain) NSString* rightAnimalID;
@property(nonatomic, retain) NSMutableArray* m_arrANIMALID;

-(void)selectButtonAtIndex:(NSUInteger)index;

-(void)addUpAnimal:(NSString*)upAnimalName sex:(int)sexIndex;


@end
