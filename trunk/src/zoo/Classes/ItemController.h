//
//  ItemController.h
//  zoo
//
//  Created by Rainbow on 5/17/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeView.h"
#import "AntView.h"
#import "ChinemyView.h"
#import "DogView.h"
#import "BowlsView.h"
#import	"DejectaView.h"
#import "Animal.h"
#import "GameMainScene.h"
#import "DataModelDog.h"

@interface ItemController : NSObject {
	NSMutableDictionary *allItems;
}

+(ItemController *)sharedItemController;

-(void) addItem: (NSString *)itemType;

-(void) clearItems;

@end
