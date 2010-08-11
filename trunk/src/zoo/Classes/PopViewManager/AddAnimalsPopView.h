//
//  AddAnimalsPopView.h
//  zoo
//
//  Created by AlexLiu on 8/5/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "popViewManager.h"
#import "Common.h"

extern NSString *AddAnimals;

@interface AddAnimalsPopView : NSObject {

	popViewManager*		myPopView;
	int					tabFlag;
	NSMutableArray*		stoAnimalsArray;
}


- (id) init;

- (void) generatePage;
- (void) btnShopButtonHandler;
- (void) faultCallback:(NSObject *)value;
- (void) initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle;
- (void) topBtnSelected:(id)sender;
- (void) resultCallback:(NSObject *)value;

//add by lancy
- (void) addAimalToFrame:(NSNotification *)aNotification;
@end
