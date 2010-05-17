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


@interface ItemController : NSObject {

}

+(ItemController *)sharedItemController;

-(void) addItem: (NSString *)itemType;

@end
