//
//  main.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIKitCategoryAdditionsAppDelegate.h"

int main(int argc, char *argv[])
{
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
#else
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([UIKitCategoryAdditionsAppDelegate class]));
    }
#endif
}
