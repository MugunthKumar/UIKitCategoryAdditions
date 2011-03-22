//
//  UIActionSheet+MKBlockAdditions.m
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import "UIActionSheet+MKBlockAdditions.h"


@implementation UIActionSheet (MKBlockAdditions)


+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(DismissBlock) dismissed                   
                    onCancel:(CancelBlock) cancelled
{
    
}


+ (void) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message          
     destructiveButtonTitle:(NSString*) descructiveButtonTitle
                    buttons:(NSArray*) buttonTitles
                 showInView:(UIView*) view
                  onDismiss:(DismissBlock) dismissed                   
                   onCancel:(CancelBlock) cancelled
{
    
}


+ (void) photoPickerAlertViewWithTitle:(NSString*) title
                            showInView:(UIView*) view
                             onDismiss:(DismissBlock) dismissed                   
                              onCancel:(CancelBlock) cancelled
{
    
}

@end
