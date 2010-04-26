//
//  AnimalViewFactory.h
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimalView.h"

@interface AnimalViewFactory : NSObject
{
	
}

+(AnimalView *) createAnimalView:(NSString *) type;

@end