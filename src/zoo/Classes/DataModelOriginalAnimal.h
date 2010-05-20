//
//  DataModelOriginalAnimal.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelOriginalAnimal : NSObject {

	NSString* originalAnimalId;
	NSString* scientificNameCN;//	动物学名(中文)
	NSString* scientificNameEN;//	动物学名(英文)
	NSString* productId;	//产品ID
	NSString* picturePrefix;	//素材前缀
	NSString* description;	//动物习性描述
	
	NSInteger hatchTime;	//孵化时间（小时）
	NSInteger babyStage;	//幼年时期（小时）
	NSInteger youthStage;	//青年时期（小时）
	NSInteger adultStage;	//成年时期（产蛋期）
	NSInteger baseYield;	//基准产蛋量
	NSInteger baseCycle;	//基准产蛋周期数
	NSInteger baseInterval;//	基准产蛋间隔(小时)
	NSInteger basePrice;//	金蛋购买价
	NSInteger antsPrice;//	蚂蚁购买价
	NSInteger levelRequired;//	购买级别要求
	NSInteger birdType;//	动物的种类；1＝出壳就能走路；2＝出壳呆在窝里；
	NSInteger aliveEdge;//	动物允许移动的边界 1＝陆地；2＝水面；3＝陆地和水面；4＝陆地和空中；5＝水面和空中；6＝陆地、水面、空中
	NSInteger step;//	步长，动物一步所移动的像素
	NSInteger speed;//	速度，对应动画祯数
	NSInteger flyingStep;//	步长，动物飞行一步所移动的像素
	NSInteger flyingSpeed;//	速度，飞行对应动画祯数
	NSInteger swimmingStep;//	步长，动物游泳一步所移动的像素
	NSInteger swimmingSpeed;//	速度，游泳对应动画祯数
	NSInteger runingStep;//	步长，动物跑步一步所移动的像素
	NSInteger runingSpeed;//	速度，跑步对应动画祯数
	NSInteger walkToEatStep;//	步长，动物去吃饭时一步所移动的像素
	NSInteger walkToEatSpeed;//	速度，动物去吃饭时对应动画祯数
}

@property (nonatomic, retain) NSString* originalAnimalId;
@property (nonatomic, retain) NSString* scientificNameCN;//	动物学名(中文)
@property (nonatomic, retain) NSString* scientificNameEN;//	动物学名(英文)
@property (nonatomic, retain) NSString* productId;	//产品ID
@property (nonatomic, retain) NSString* picturePrefix;	//素材前缀
@property (nonatomic, retain) NSString* description;	//动物习性描述

@property (nonatomic, assign) NSInteger hatchTime;	//孵化时间（小时）
@property (nonatomic, assign) NSInteger babyStage;	//幼年时期（小时）
@property (nonatomic, assign) NSInteger youthStage;	//青年时期（小时）
@property (nonatomic, assign) NSInteger adultStage;	//成年时期（产蛋期）
@property (nonatomic, assign) NSInteger baseYield;	//基准产蛋量
@property (nonatomic, assign) NSInteger baseCycle;	//基准产蛋周期数
@property (nonatomic, assign) NSInteger baseInterval;//	基准产蛋间隔(小时)
@property (nonatomic, assign) NSInteger basePrice;//	金蛋购买价
@property (nonatomic, assign) NSInteger antsPrice;//	蚂蚁购买价
@property (nonatomic, assign) NSInteger levelRequired;//	购买级别要求
@property (nonatomic, assign) NSInteger birdType;//	动物的种类；1＝出壳就能走路；2＝出壳呆在窝里；
@property (nonatomic, assign) NSInteger aliveEdge;//	动物允许移动的边界 1＝陆地；2＝水面；3＝陆地和水面；4＝陆地和空中；5＝水面和空中；6＝陆地、水面、空中
@property (nonatomic, assign) NSInteger step;//	步长，动物一步所移动的像素
@property (nonatomic, assign) NSInteger speed;//	速度，对应动画祯数
@property (nonatomic, assign) NSInteger flyingStep;//	步长，动物飞行一步所移动的像素
@property (nonatomic, assign) NSInteger flyingSpeed;//	速度，飞行对应动画祯数
@property (nonatomic, assign) NSInteger swimmingStep;//	步长，动物游泳一步所移动的像素
@property (nonatomic, assign) NSInteger swimmingSpeed;//	速度，游泳对应动画祯数
@property (nonatomic, assign) NSInteger runingStep;//	步长，动物跑步一步所移动的像素
@property (nonatomic, assign) NSInteger runingSpeed;//	速度，跑步对应动画祯数
@property (nonatomic, assign) NSInteger walkToEatStep;//	步长，动物去吃饭时一步所移动的像素
@property (nonatomic, assign) NSInteger walkToEatSpeed;//	速度，动物去吃饭时对应动画祯数

@end
