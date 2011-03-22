//
//  UIKitCategoryAdditionsAppDelegate.h
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIKitCategoryAdditionsViewController;

@interface UIKitCategoryAdditionsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIKitCategoryAdditionsViewController *viewController;

@end
