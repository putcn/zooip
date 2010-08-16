/*
 *  Common.h
 *  zoo
 *
 *  Created by shen lancy on 10-7-30.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

enum popViewType{

	SHOP_POPVIEW = 0, //动物商店
	EGG_WAREHOUSE_POPVIEW,  // 卖蛋操作
	ANIMAL_WAREHOUSE_POPVIEW, // 动物仓库，拍卖放入动物
	ANIMAL_MATEORMARRY_POPVIEW, // 动物婚姻管理
	ANIMAL_DISAPAERT_POPVIEW, //动物离婚弹出窗口
	ANIMAL_ANTSCHOOSE_POPVIEW,
};

enum secPopView{
	
	BUY_ANIMAL = 0,
	BUY_FOODS,
	BUY_GOODS,
	SALE_COMMONEGGS,
	SALE_ZYGOTEEGGS,
	
	ANIMAL_WAREHOUSE,
	BUY_ANIMAL_WAREHOUSE,
	
	ANIMAL_MARRY, //
	ANIMAL_DISAPART, //
	Mate_Before_Marry, //
	Mate_After_Marry,
};