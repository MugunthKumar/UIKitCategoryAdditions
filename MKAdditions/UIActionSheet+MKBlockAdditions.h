//
//  UIActionSheet+MKBlockAdditions.h
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKBlockAdditions.h"

@interface UIActionSheet (MKBlockAdditions) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(DismissBlock) dismissed                   
                    onCancel:(CancelBlock) cancelled;


+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(DismissBlock) dismissed                   
                     onCancel:(CancelBlock) cancelled;


+ (void) photoPickerWithTitle:(NSString*) title
                   showInView:(UIView*) view
                    presentVC:(UIViewController*) presentView
                onPhotoPicked:(PhotoPickedBlock) photoPicked                   
                     onCancel:(CancelBlock) cancelled;

@end
