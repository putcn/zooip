//
//  DataModelAnt.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelAnt : NSObject {

	NSString* releaseAntsId;
	NSString* antsReleaser;
}

@property (nonatomic, retain) NSString* releaseAntsId;
@property (nonatomic, retain) NSString* antsReleaser;

@end
