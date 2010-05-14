//
//  AnimalViewFactory.h
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalView.h"
#import "BabyDuckView.h"
#import "BabyHenView.h"
#import "BabyPigeonView.h"
#import "BabyMallardView.h"
#import "BabyMagpieView.h"
#import "BabySwanView.h"
#import "BabyWildgooseView.h"
#import "BabyPeacockView.h"
#import "BabyCraneView.h"
#import "DuckView.h"
#import "HenView.h"
#import "GooseView.h"
#import "PigeonView.h"
#import "MallardView.h"
#import "TurkeyView.h"
#import "MagpieView.h"
#import "SwanView.h"
#import "ParrotView.h"
#import "PheasantView.h"
#import "WildgooseView.h"
#import "MandarinDuckView.h"
#import "PeahenView.h"
#import "CraneView.h"
#import "RoosterView.h"
#import "TurkeycockView.h"
#import "MalePheasant.h"
#import "MaleMandarinDuckView.h"
#import "PeacockView.h"

@interface AnimalViewFactory : NSObject
{
	
}

+(AnimalView *) createAnimalView:(NSInteger) type birdStage:(NSInteger) stage;

@end
