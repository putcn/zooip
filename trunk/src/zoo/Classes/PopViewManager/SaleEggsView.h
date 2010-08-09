//
//  SaleEggsView.h
//  zoo
//
//  Created by Hunk on 10-8-6.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "popViewManager.h"
#import "Common.h"


@interface SaleEggsView : NSObject 
{
	popViewManager* myPopView;
	
	int tabFlag;
	
	NSString* m_strCommonEggs;
	NSString* m_strZygoteEggs;
	
	NSArray* eggEnNameArray;
	
	int m_nViewTabFlag;
}

@property(nonatomic, assign)int tabFlag;

- (id) init;

- (void) saleEggsButtonHandler;

- (void) resultCallback:(NSObject *)value;

- (void) faultCallback:(NSObject *)value;

- (void)initWithBtn:(NSArray *)arrayBtn Title:(NSArray*)arrayTitle;

@end
