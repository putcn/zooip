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

//	id					delegate;
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
}

//@property(nonatomic, assign) id <ScrollBarViewDelegate> delegate;
@property(nonatomic, readwrite)int m_npopViewType;
@property(nonatomic, readwrite)int m_nlistCount;

//+ (id) sharedPopView;

- (id) init;

//set scrollView
- (void) addView2Window;
- (void) setPopViewFrame:(CGRect)myFrame;
- (void) setSubSize:(CGSize)size;

//add data
- (void) initWithBtn:(NSArray*)arrayBtn;
- (void) initWithItem:(NSArray*)arrayPic;


@end


//@protocol ScrollBarViewDelegate
//
//- (void) tapDownCell:(int)index;
//
//@end


