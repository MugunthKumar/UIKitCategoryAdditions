//
//  UIAlertView+Block.h
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Block) <UIAlertViewDelegate> {
    
}

+ (void) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message;

+ (void) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message
          cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (void) alertViewWithTitle:(NSString*) title                    
                  onDismiss:(DismissBlock) dismissed                   
                   onCancel:(CancelBlock) cancelled
                    message:(NSString*) message 
          cancelButtonTitle:(NSString*) cancelButtonTitle
          otherButtonTitles:(NSArray*) otherButtons;

@end
