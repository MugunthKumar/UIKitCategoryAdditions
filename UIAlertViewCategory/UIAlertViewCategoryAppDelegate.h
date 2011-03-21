//
//  UIAlertViewCategoryAppDelegate.h
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIAlertViewCategoryViewController;

@interface UIAlertViewCategoryAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIAlertViewCategoryViewController *viewController;

@end
