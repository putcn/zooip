//
//  AnimalBehaviorUtil.h
//  zoo
//
//  Created by Rainbow on 7/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AnimalBehaviorUtil : NSObject {
	NSDictionary *babyCrane;
	NSDictionary *babyDuck;
	NSDictionary *babyHen;
	NSDictionary *babyMagpie;
	NSDictionary *babyMallard;
	NSDictionary *babyPeacock;
	NSDictionary *babyPiegon;
	NSDictionary *babySwan;
	NSDictionary *babyWildgoose;
	NSDictionary *mallard;
	NSDictionary *wildgoose;
	NSDictionary *chinemy;
	NSDictionary *crane;
	NSDictionary *dog;
	NSDictionary *duck;
	NSDictionary *goose;
	NSDictionary *hen;
	NSDictionary *magpie;
	NSDictionary *maleMandarinDuck;
	NSDictionary *malePheasant;
	NSDictionary *mandarinDuck;
	NSDictionary *parrot;
	NSDictionary *peacock;
	NSDictionary *peahen;
	NSDictionary *pheasant;
	NSDictionary *pigeon;
	NSDictionary *rooster;
	NSDictionary *snake;
	NSDictionary *swan;
	NSDictionary *turkey;
	NSDictionary *turkeycock;
	
}
+ (AnimalBehaviorUtil *)sharedAnimalBehaviorUtil;
- (void)restore;

-(NSDictionary *)getBabyCrane;
-(NSDictionary *)getBabyDuck;
-(NSDictionary *)getBabyHen;
-(NSDictionary *)getBabyMagpie;
-(NSDictionary *)getBabyMallard;
-(NSDictionary *)getBabyPeacock;
-(NSDictionary *)getBabyPiegon;
-(NSDictionary *)getBabySwan;
-(NSDictionary *)getBabyWildgoose;
-(NSDictionary *)getMallard;
-(NSDictionary *)getWildgoose;
-(NSDictionary *)getChinemy;
-(NSDictionary *)getCrane;
-(NSDictionary *)getDog;
-(NSDictionary *)getDuck;
-(NSDictionary *)getGoose;
-(NSDictionary *)getHen;
-(NSDictionary *)getMagpie;
-(NSDictionary *)getMaleMandarinDuck;
-(NSDictionary *)getMalePheasant;
-(NSDictionary *)getMandarinDuck;
-(NSDictionary *)getParrot;
-(NSDictionary *)getPeacock;
-(NSDictionary *)getPeahen;
-(NSDictionary *)getPheasant;
-(NSDictionary *)getPigeon;
-(NSDictionary *)getRooster;
-(NSDictionary *)getSnake;
-(NSDictionary *)getSwan;
-(NSDictionary *)getTurkey;
-(NSDictionary *)getTurkeycock;


@end
