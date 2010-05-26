//
//  CollisionHelper.h
//  zoo
//
//  Created by Niu Darcy on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CollisionHelper : NSObject
{
}

+(void)initCollisionMap;
+(int)getMapType:(CGPoint)point;

@end
