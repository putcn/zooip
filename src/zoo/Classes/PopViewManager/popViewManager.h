//
//  popViewManager.h
//  zoo
//
//  Created by shen lancy on 10-7-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceHelper.h"
#import "Common.h"

#import "SecPopViewController.h"
#import "MarryView.h"
#import "DisapartView.h"


@protocol ScrollBarViewDelegate;
@interface popViewManager : UIViewController {

	ServiceHelper*		serviceInstance;
	UIScrollView*		m_ppopView;
	int					m_npopViewType;
	int					m_nprevButtonIndex;
	int					m_nlistCount;
	int					m_nrowCount;
	CGSize				subSize;
	
	int					prevButtonIndex;
	int					tabFlag;
	NSMutableArray*		picFileNameArray;
	NSMutableArray*		topBtnArray;
	SecPopViewController*secPopView;
	
	NSMutableArray*		buyTypeArray;
	NSMutableArray*		priceArray;
	NSMutableArray*		sexArray;
	NSMutableArray*		storageEggArray;
	NSMutableArray*		storageAniArray;
	
	UIButton*			saleAllBtn;
	
	int					touchIndex;
	
	NSMutableArray*		stoAnimalsArray;
	NSMutableArray*     stoMarriedArray;
	
	
	// Marray view
	MarryView* m_pMarryView;
	// Disapart view
	DisapartView *m_pDisapartView;
}

@property(nonatomic, retain) UIScrollView* m_ppopView;

@property(nonatomic, readwrite)int m_npopViewType;
@property(nonatomic, readwrite)int m_nlistCount;
@property(nonatomic, readwrite)int tabFlag;
@property(nonatomic, retain)NSMutableArray* buyTypeArray;
@property(nonatomic, retain)NSMutableArray* priceArray;
@property(nonatomic, retain)NSMutableArray* sexArray;
@property(nonatomic, retain)NSMutableArray* storageEggArray;
@property(nonatomic, retain)NSMutableArray* storageAniArray;

@property(nonatomic, readonly)int touchIndex;

@property(nonatomic, retain)NSMutableArray*	stoAnimalsArray;
@property(nonatomic, retain)NSMutableArray* stoMarriedArray;

- (id) init;

//set scrollView
- (void) addView2Window;
- (void) setPopViewFrame:(CGRect)myFrame;
- (void) setSubSize:(CGSize)size;

//add data
//- (void) initWithBtn:(NSArray*)arrayBtn Title:(NSArray*)arrayTitle;
- (void) initWithItem:(NSArray*)arrayPic;

-(void)updateFarmInfoZogyteExeCute:(NSDictionary *)value;
-(void)updateFarmInfoResultZogyteCallback:(NSObject*)value;


@end


