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
}

@property(nonatomic, readwrite)int m_npopViewType;
@property(nonatomic, readwrite)int m_nlistCount;
@property(nonatomic, retain)NSMutableArray* buyTypeArray;
@property(nonatomic, retain)NSMutableArray* priceArray;
@property(nonatomic, retain)NSMutableArray* sexArray;

- (id) init;

//set scrollView
- (void) addView2Window;
- (void) setPopViewFrame:(CGRect)myFrame;
- (void) setSubSize:(CGSize)size;

//add data
- (void) initWithBtn:(NSArray*)arrayBtn;
- (void) initWithItem:(NSArray*)arrayPic;


@end


