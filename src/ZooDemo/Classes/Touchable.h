//
//  Touchable.h
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-6.
//  Copyright 2010 Apple Inc. All rights reserved.
//


@protocol Touchable

-(void) fireTouchBegan;
// 移进
-(void) fireTouchMovedIn;
// 移出
-(void) fireTouchMovedOut;
-(void) fireTouchEnded;
// TODO 必要时解除 fireTouchCanceled 的注释
//-(void) fireTouchCanceled;

@end
