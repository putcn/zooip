//
//  GameController.h
//  zoo
//
//  Created by Gu Lei on 10-4-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameController : NSObject
{
	
}

+(GameController *) sharedGameController;

-(void) initGame;

@end
