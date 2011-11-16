//
//  SaveImage.h
//
//  Created by MyFreeWeb on 29/04/2010.
//  Copyright 2010 MyFreeWeb.
//  MIT licensed
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#ifdef PHONEGAP_FRAMEWORK
#import <PhoneGap/PGPlugin.h>
#import <PhoneGap/NSData+Base64.h>
#else
#import "PGPlugin.h"
#import "NSData+Base64.h"
#endif

@interface SaveImage : PGPlugin {
}

- (void)saveImage:(NSMutableArray*)sdata withDict:(NSMutableDictionary*)options;
@end
