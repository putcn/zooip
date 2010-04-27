//
//  AnimalViewFactory.h
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimalView.h"
#import "LittleDuckView.h"
#import "DuckView.h"
#import "GooseView.h"
#import "ChickenView.h"
#import "CockView.h"
#import "HenView.h"
#import "MaleTurkeyView.h"
#import "BabyDoveView.h"
#import "DoveView.h"
#import "BabyMagpieView.h"
#import "MagpieView.h"
#import "BabyPeacockView.h"
#import "PeacockView.h"
#import "LittleMallardView.h"
#import "MaleMandarinDuckView.h"
#import "RedCrowneView.h"
#import "ChinemyView.h"
#import "SnakeView.h"
#import "TibentanMastiffView.h"
#import "MallardView.h"

@interface AnimalViewFactory : NSObject
{
	
}

+(AnimalView *) createAnimalView:(NSString *) type;

@end
