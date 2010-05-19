//
//  EggViewFactory.h
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggView.h"
#import "CraneEggView.h"
#import "DuckEggView.h"
#import "GooseEggView.h"
#import "HenEggView.h"
#import "MagpieEggView.h"
#import "MallardEggView.h"
#import "MandarinduckEggView.h"
#import "ParrotEggView.h"
#import "PeahenEggView.h"
#import "PheasantEggView.h"
#import "PigeonEggView.h"
#import "SwanEggView.h"
#import "TurkeyEggView.h"
#import "WildgooseEggView.h"


@interface EggViewFactory : NSObject {

}
+(EggView *)createEggView: (int)type;

@end
