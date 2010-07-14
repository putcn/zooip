//
//  ImageResources.m
//  zoo
//
//  Created by Rainbow on 7/14/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ImageResources.h"


@implementation ImageResources

static ImageResources *_resource = nil;

+ (ImageResources *)sharedImageResources
{
	@synchronized(self){
		if (_resource == nil) {
			_resource = [[self alloc] init];
		}
	}
	return _resource;
}

-(id)init
{
	if (_resource != nil) {}
	else if((self = [super init])){
		_resource = self;
		[self restore];
	}
	return _resource;
}

-(CCSpriteSheet *)getImageResouce:(NSString *)imagePath
{
	if ([imagePath isEqualToString:@"_babycrane.png"]) {
		if (babyCraneImg == nil) {
			babyCraneImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyCraneImg;
	}
	else if ([imagePath isEqualToString:@"_babyduck.png"]){
		if (babyDuckImg == nil) {
			babyDuckImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyDuckImg;
	}
	else if ([imagePath isEqualToString:@"_babyhen.png"]){
		if (babyHenImg == nil) {
			babyHenImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyHenImg;
	}
	else if ([imagePath isEqualToString:@"_babymagpie.png"]){
		if (babyMagpieImg == nil) {
			babyMagpieImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyMagpieImg;
	}
	else if ([imagePath isEqualToString:@"_babypeacock.png"]){
		if (babyPeacockImg == nil) {
			babyPeacockImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyPeacockImg;
	}
	else if ([imagePath isEqualToString:@"_babypiegon.png"]){
		if (babyPiegonImg == nil) {
			babyPiegonImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyPiegonImg;
	}
	else if ([imagePath isEqualToString:@"_babyswan.png"]){
		if (babySwanImg == nil) {
			babySwanImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babySwanImg;
	}
	else if ([imagePath isEqualToString:@"_babywildgoose.png"]){
		if (babyWildgooseImg == nil) {
			babyWildgooseImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return babyWildgooseImg;
	}
	else if ([imagePath isEqualToString:@"_mallard_1.png"]){
		if (mallardImg_1 == nil) {
			mallardImg_1 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return mallardImg_1;
	}
	else if ([imagePath isEqualToString:@"_mallard_2.png"]){
		if (mallardImg_2 == nil) {
			mallardImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return mallardImg_2;
	}
	else if ([imagePath isEqualToString:@"_wildgoose_1.png"]){
		if (wildgooseImg_1 == nil) {
			wildgooseImg_1 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return wildgooseImg_1;
	}
	else if ([imagePath isEqualToString:@"_wildgoose_2.png"]){
		if (wildgooseImg_2 == nil) {
			wildgooseImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return wildgooseImg_2;
	}
	else if ([imagePath isEqualToString:@"_wildgoose_3.png"]){
		if (wildgooseImg_3 == nil) {
			wildgooseImg_3 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return wildgooseImg_3;
	}
	else if ([imagePath isEqualToString:@"_chinemy.png"]){
		if (chinemyImg == nil) {
			chinemyImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return chinemyImg;
	}
	else if ([imagePath isEqualToString:@"_crane_1.png"]){
		if (craneImg_1 == nil) {
			craneImg_1= [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return craneImg_1;
	}
	else if ([imagePath isEqualToString:@"_crane_2.png"]){
		if (craneImg_2 == nil) {
			craneImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return craneImg_2;
	}
	else if ([imagePath isEqualToString:@"_dog.png"]){
		if (dogImg == nil) {
			dogImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return dogImg;
	}
	else if ([imagePath isEqualToString:@"_duck.png"]){
		if (duckImg == nil) {
			duckImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return duckImg;
	}
	else if ([imagePath isEqualToString:@"_goose.png"]){
		if (gooseImg == nil) {
			gooseImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return gooseImg;
	}
	else if ([imagePath isEqualToString:@"_hen.png"]){
		if (henImg == nil) {
			henImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return henImg;
	}
	else if ([imagePath isEqualToString:@"_magpie_1.png"]){
		if (magpieImg_1 == nil) {
			magpieImg_1 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return magpieImg_1;
	}
	else if ([imagePath isEqualToString:@"_magpie_2.png"]){
		if (magpieImg_2 == nil) {
			magpieImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return magpieImg_2;
	}
	else if ([imagePath isEqualToString:@"_malemandarinduck.png"]){
		if (maleMandarinDuckImg == nil) {
			maleMandarinDuckImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return maleMandarinDuckImg;
	}
	else if ([imagePath isEqualToString:@"_malepheasant.png"]){
		if (malePheasantImg == nil) {
			malePheasantImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return malePheasantImg;
	}
	else if ([imagePath isEqualToString:@"_mandarinduck.png"]){
		if (mandarinDuckImg == nil) {
			mandarinDuckImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return mandarinDuckImg;
	}
	else if ([imagePath isEqualToString:@"_parrot_1.png"]){
		if (parrotImg_1 == nil) {
			parrotImg_1 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return parrotImg_1;
	}
	else if ([imagePath isEqualToString:@"_parrot_2.png"]){
		if (parrotImg_2 == nil) {
			parrotImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return parrotImg_2;
	}
	else if ([imagePath isEqualToString:@"_peacock.png"]){
		if (peacockImg == nil) {
			peacockImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return peacockImg;
	}
	else if ([imagePath isEqualToString:@"_peahen.png"]){
		if (peahenImg == nil) {
			peahenImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return mandarinDuckImg;
	}
	else if ([imagePath isEqualToString:@"_pheasant.png"]){
		if (pheasantImg == nil) {
			pheasantImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return pheasantImg;
	}
	else if ([imagePath isEqualToString:@"_pigeon.png"]){
		if (pigeonImg == nil) {
			pigeonImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return pigeonImg;
	}
	else if ([imagePath isEqualToString:@"_rooster.png"]){
		if (roosterImg == nil) {
			roosterImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return roosterImg;
	}
	else if ([imagePath isEqualToString:@"_snake.png"]){
		if (snakeImg == nil) {
			snakeImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return snakeImg;
	}
	else if ([imagePath isEqualToString:@"_swan_1.png"]){
		if (swanImg_1 == nil) {
			swanImg_1 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return swanImg_1;
	}
	else if ([imagePath isEqualToString:@"_swan_2.png"]){
		if (swanImg_2 == nil) {
			swanImg_2 = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return swanImg_2;
	}
	else if ([imagePath isEqualToString:@"_turkey.png"]){
		if (turkeyImg == nil) {
			turkeyImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return turkeyImg;
	}
	else if ([imagePath isEqualToString:@"_turkeycock.png"]){
		if (turkeycockImg == nil) {
			turkeycockImg = [CCSpriteSheet spriteSheetWithFile:imagePath];
		}
		return turkeycockImg;
	}else {
		
	}
	return nil;
}

-(void)restore
{
	babyCraneImg = nil;
	babyDuckImg = nil;
	babyHenImg = nil;
	babyMagpieImg = nil;
	babyMallardImg = nil;
	babyPeacockImg = nil;
	babyPiegonImg = nil;
	babySwanImg = nil;
	babyWildgooseImg = nil;
	mallardImg_1 = nil;
	mallardImg_2 = nil;
	wildgooseImg_1 = nil;
	wildgooseImg_2 = nil;
	wildgooseImg_3 = nil;
	chinemyImg = nil;
	craneImg_1 = nil;
	craneImg_2 = nil;
	dogImg = nil;
	duckImg = nil;
	gooseImg = nil;
	henImg = nil;
	magpieImg_1 = nil;
	magpieImg_2 = nil;
	maleMandarinDuckImg = nil;
	malePheasantImg = nil;
	mandarinDuckImg = nil;
	parrotImg_1 = nil;
	parrotImg_2 = nil;
	peacockImg = nil;
	peahenImg = nil;
	pheasantImg = nil;
	pigeonImg = nil;
	roosterImg = nil;
	snakeImg = nil;
	swanImg_1 = nil;
	swanImg_2 = nil;
	turkeyImg = nil;
	turkeycockImg = nil; 
}


@end
