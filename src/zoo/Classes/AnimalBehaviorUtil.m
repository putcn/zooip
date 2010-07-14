//
//  AnimalBehaviorUtil.m
//  zoo
//
//  Created by Rainbow on 7/13/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnimalBehaviorUtil.h"
#import "AnimalImageProperty.h"

@implementation AnimalBehaviorUtil

static AnimalBehaviorUtil *behaviroUtil = nil;

+ (AnimalBehaviorUtil *)sharedAnimalBehaviorUtil
{
	@synchronized(self){
		if (behaviroUtil == nil) {
			behaviroUtil = [[self alloc] init];
		}
	}
	return behaviroUtil;
}

-(id)init
{
	if (behaviroUtil != nil) {}
	else if((self = [super init])){
		behaviroUtil = self;
		[self restore];
	}
	return behaviroUtil;
}

-(NSDictionary *)getBabyCrane{
	if(babyCrane == nil)
	{
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyCrane = [imageProp animationTable:@"_BabyCrane.png" plistName:@"_BabyCrane.plist"];
	}
	return babyCrane;
}
-(NSDictionary *)getBabyDuck{
	if (babyDuck == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyDuck = [imageProp animationTable:@"_babyduck.png" plistName:@"_babyduck.plist"];
	}
	return babyDuck;
}
-(NSDictionary *)getBabyHen{
	if (babyHen == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyHen = [imageProp animationTable:@"_BabyHen.png" plistName:@"_BabyHen.plist"];
	}
	return babyHen;
}
-(NSDictionary *)getBabyMagpie{
	if (babyMagpie == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyMagpie = [imageProp animationTable:@"_BabyMagpie.png" plistName:@"_BabyMagpie.plist"];
	}
	return babyMagpie;
}
-(NSDictionary *)getBabyMallard{
	if (babyMallard == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyMallard = [imageProp animationTable:@"_BabyMallard.png" plistName:@"_BabyMallard.plist"];
	}
	return babyMallard;
}
-(NSDictionary *)getBabyPeacock{
	if (babyPeacock == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyPeacock = [imageProp animationTable:@"_BabyPeacock.png" plistName:@"_BabyPeacock.plist"];
	}
	return babyPeacock;
}
-(NSDictionary *)getBabyPiegon{
	if (babyPiegon == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyPiegon = [imageProp animationTable:@"_BabyPigeon.png" plistName:@"_BabyPigeon.plist"];
	}
	return babyPiegon;
}
-(NSDictionary *)getBabySwan{
	if (babySwan == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babySwan = [imageProp animationTable:@"_BabySwan.png" plistName:@"_BabySwan.plist"];
	}
	return babySwan;
}
-(NSDictionary *)getBabyWildgoose{
	if (babyWildgoose == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		babyWildgoose = [imageProp animationTable:@"_BabyWildgoose.png" plistName:@"_BabyWildgoose.plist"];
	}
	return babyWildgoose;
}
-(NSDictionary *)getMallard{
	if (mallard == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Mallard_1.png" plistName:@"_Mallard_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Mallard_2.png" plistName:@"_Mallard_2.plist"]];
		mallard = tempDic;
	}
	return mallard;
}
-(NSDictionary *)getWildgoose{
	if (wildgoose == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_wildgoose_1.png" plistName:@"_wildgoose_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_wildgoose_2.png" plistName:@"_wildgoose_2.plist"]];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_wildgoose_3.png" plistName:@"_wildgoose_3.plist"]];
		wildgoose = tempDic;
	}
	return wildgoose;
}
-(NSDictionary *)getChinemy{
	if (chinemy == nil) {
		AnimalImageProperty *imageProperty = [[AnimalImageProperty alloc] init];
		chinemy = [[imageProperty animationTable:@"_chinemy.png" plistName:@"_chinemy.plist"] retain];
	}
	return chinemy;
}
-(NSDictionary *)getCrane{
	if (crane == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Crane_1.png" plistName:@"_Crane_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Crane_2.png" plistName:@"_Crane_2.plist"]];
		crane = tempDic;
	}
	return crane;
}
-(NSDictionary *)getDog{
	if (dog == nil) {
		AnimalImageProperty *imageProperty = [[AnimalImageProperty alloc] init];
		dog = [[imageProperty animationTable:@"_dog.png" plistName:@"_dog.plist"] retain];
	}
	return dog;
}
-(NSDictionary *)getDuck{
	if (duck == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		duck = [imageProp animationTable:@"_duck.png" plistName:@"_duck.plist"];
	}
	return [duck retain];
}
-(NSDictionary *)getGoose{
	if (goose == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		goose = [imageProp animationTable:@"_Goose.png" plistName:@"_Goose.plist"];
	}
	return goose;
}
-(NSDictionary *)getHen{
	if (hen == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		hen = [imageProp animationTable:@"_Hen.png" plistName:@"_Hen.plist"]; 
	}
	return hen;
}
-(NSDictionary *)getMagpie{
	if (magpie == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Magpie_1.png" plistName:@"_Magpie_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Magpie_2.png" plistName:@"_Magpie_2.plist"]];
		magpie = tempDic;
	}
	return magpie;
}
-(NSDictionary *)getMaleMandarinDuck{
	if (maleMandarinDuck == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		maleMandarinDuck = [imageProp animationTable:@"_MaleMandarinDuck.png" plistName:@"_MaleMandarinDuck.plist"];

	}
	return maleMandarinDuck;
}
-(NSDictionary *)getMalePheasant{
	if (malePheasant == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		malePheasant = [imageProp animationTable:@"_MalePheasant.png" plistName:@"_MalePheasant.plist"];
	}
	return malePheasant;
}
-(NSDictionary *)getMandarinDuck{
	if (mandarinDuck == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		mandarinDuck = [imageProp animationTable:@"_MandarinDuck.png" plistName:@"_MandarinDuck.plist"];
	}
	return mandarinDuck;
}
-(NSDictionary *)getParrot{
	if (parrot == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Parrot_1.png" plistName:@"_Parrot_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Parrot_2.png" plistName:@"_Parrot_2.plist"]];
		parrot = tempDic;
	}
	return parrot;
}
-(NSDictionary *)getPeacock{
	if (peacock == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Peacock_1.png" plistName:@"_Peacock_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Peacock_2.png" plistName:@"_Peacock_2.plist"]];
		peacock = tempDic;
	}
	return peacock;
}
-(NSDictionary *)getPeahen{
	if (peahen == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		peahen = [imageProp animationTable:@"_Peahen.png" plistName:@"_Peahen.plist"];
	}
	return peahen;
}
-(NSDictionary *)getPheasant{
	if (pheasant == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		pheasant = [imageProp animationTable:@"_Pheasant.png" plistName:@"_Pheasant.plist"];
	}
	return pheasant;
}
-(NSDictionary *)getPigeon{
	if (pigeon == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		pigeon = [imageProp animationTable:@"_Pigeon.png" plistName:@"_Pigeon.plist"];
	}
	return pigeon;
}
-(NSDictionary *)getRooster{
	if (rooster == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		rooster = [imageProp animationTable:@"_Rooster.png" plistName:@"_Rooster.plist"];
	}
	return rooster;
}
-(NSDictionary *)getSnake{
	if (snake == nil) {
		
	}
	return snake;
}
-(NSDictionary *)getSwan{
	if (swan == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		NSMutableDictionary *tempDic = [imageProp animationTable:@"_Swan_1.png" plistName:@"_Swan_1.plist"];
		[tempDic addEntriesFromDictionary:[imageProp animationTable:@"_Swan_2.png" plistName:@"_Swan_2.plist"]];
		swan = tempDic;
	}
	return swan;
}
-(NSDictionary *)getTurkey{
	if (turkey == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		turkey = [imageProp animationTable:@"_Turkey.png" plistName:@"_Turkey.plist"];
	}
	return turkey;
}
-(NSDictionary *)getTurkeycock{
	if (turkeycock == nil) {
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		turkeycock = [imageProp animationTable:@"_Turkeycock.png" plistName:@"_Turkeycock.plist"];
	}
	return turkeycock;
}

-(void)restore
{
	babyCrane = nil;
	babyDuck= nil;
	babyHen= nil;
	babyMagpie= nil;
	babyMallard= nil;
	babyPeacock= nil;
	babyPiegon= nil;
	babySwan= nil;
	babyWildgoose= nil;
	mallard= nil;
	wildgoose= nil;
	chinemy= nil;
	crane= nil;
	dog= nil;
	duck= nil;
	goose= nil;
	hen= nil;
	magpie= nil;
	maleMandarinDuck= nil;
	malePheasant= nil;
	mandarinDuck= nil;
	parrot= nil;
	peacock= nil;
	peahen= nil;
	pheasant= nil;
	pigeon= nil;
	rooster= nil;
	snake= nil;
	swan= nil;
	turkey= nil;
	turkeycock= nil; 
}


@end
