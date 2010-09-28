//
//  ShopPopView.h
//  zoo
//
//  Created by shen lancy on 10-8-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "popViewManager.h"
#import "Common.h"

@interface ShopPopView : NSObject {

	popViewManager*		myPopView;
	int					tabFlag;
	
	NSMutableArray*		btnArray;
}

- (id) init;

- (void) btnShopButtonHandler;
- (void) resultCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;

- (void) initWithBtn:(NSArray*)arrayBtn Title:(NSArray*)arrayTitle;
- (void) topBtnSelected:(id)sender;

@end
