//
//  FriendsListSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-6.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FriendsListSprite.h"

@interface FriendSprite : CCSprite
{
	CCLabel* nameLabel;
	CCSprite* photoSprite;
	CCSprite* rankSprite;
}

// TODO 添加 spriteWith ... 从NS或者是CC的图形对象创建
+(id) spriteWithPhotoSprite:(CCSprite*)_photoSprite name:(NSString*) name rank:(int) rank;

@end


@implementation FriendsListSprite

-(id) init
{
	if (self = [super initWithFile:@"好友列表背景框_short.png"]) {
		// TODO need previous image
		//CCSprite* previous = [CCSprite spriteWithFile:@""];
		CCSprite* nextSprite = [CCSprite spriteWithFile:@"好友的翻页.png"];
		nextSprite.position = ccp(390, 50);
		[self addChild:nextSprite];
		CCSprite* refreshSprite = [CCSprite spriteWithFile:@"好友列表刷新按钮.png"];
		refreshSprite.position = ccp(385, 105);
		[self addChild:refreshSprite];
		for (int i = 0; i < 5; i++) {
			CCSprite* photoSprite = [CCSprite spriteWithFile:@"冠军勋章.png"];
			FriendSprite* friendSprite = [FriendSprite spriteWithPhotoSprite:photoSprite name:[NSString stringWithFormat:@"大头%d", i] rank:i];
			friendSprite.position = ccp(50 + i * 73, 50);
			[self addChild:friendSprite];
		}
	}
	return self;
}

@end


@implementation FriendSprite

+(id) spriteWithPhotoSprite:(CCSprite*)_photoSprite name:(NSString*) name rank:(int) rank
{
	FriendSprite* friendSprite = [FriendSprite spriteWithFile:@"好友头像背景.png"];
	CCLabel* nameLabel = [CCLabel labelWithString:name fontName:@"Arial" fontSize:12];
	nameLabel.position = ccp(30, 10);
	[friendSprite addChild:nameLabel];
	photoSprite = _photoSprite;
	photoSprite.position = ccp(30, 50);
	[friendSprite addChild:photoSprite];
	
	// TODO 添加 rankSprite等;
	return friendSprite;
}

@end



