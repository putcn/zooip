//
//  MarryView.h
//  zoo
//
//  Created by Hunk on 10-8-12.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ScrollBarViewDelegate;
@interface MarryView : UIViewController 
{
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
	
	NSMutableArray* m_arrANIMALID;
}
@property(nonatomic, retain) NSString* leftAnimalID;
@property(nonatomic, retain) NSString* rightAnimalID;
@property(nonatomic, retain) NSMutableArray* m_arrANIMALID;

-(void)selectButtonAtIndex:(NSUInteger)index;

-(void)addUpAnimal:(NSString*)upAnimalName sex:(int)sexIndex;

-(void)initScrollViewItems:(NSMutableArray*)picArray aniID:(NSMutableArray*)idArray;

@end
