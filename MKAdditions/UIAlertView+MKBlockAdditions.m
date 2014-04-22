//
//  UIAlertView+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+MKBlockAdditions.h"
#import <objc/runtime.h>

static char DISMISS_IDENTIFER;
static char CANCEL_IDENTIFER;
static char TEXTFIELD_IDENTIFIER;

@implementation UIAlertView (Block)

@dynamic cancelBlock;
@dynamic dismissBlock;
@dynamic textFieldDismissBlock;

- (void)setDismissBlock:(DismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &DISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (DismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &DISMISS_IDENTIFER);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, &CANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CancelBlock)cancelBlock
{
    return objc_getAssociatedObject(self, &CANCEL_IDENTIFER);
}

- (void)setTextFieldDismissBlock:(TextFieldDismissBlock)textFieldDismissBlock
{
    objc_setAssociatedObject(self, &TEXTFIELD_IDENTIFIER, textFieldDismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextFieldDismissBlock)textFieldDismissBlock
{
    return objc_getAssociatedObject(self, &TEXTFIELD_IDENTIFIER);
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                    message:(NSString*) message 
          cancelButtonTitle:(NSString*) cancelButtonTitle
          otherButtonTitles:(NSArray*) otherButtons
                  onDismiss:(DismissBlock) dismissed                   
                   onCancel:(CancelBlock) cancelled {
        
    UIAlertView *alert = [[UIAlertView alloc] showAlertViewWithTitle:title
                                                             message:message
                                                   cancelButtonTitle:cancelButtonTitle
                                                   otherButtonTitles:otherButtons
                                                        dismissBlock:dismissed
                                               textFieldDismissBlock:nil
                                                         cancelBlock:cancelled];
#if !__has_feature(objc_arc)
    return [alert autorelease];
#else
    return alert;
#endif
}

+ (UIAlertView*) alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtons
                 onTextFieldDismiss:(TextFieldDismissBlock)dismissed
                           onCancel:(CancelBlock)cancelled
{
    UIAlertView *alert = [[UIAlertView alloc] showAlertViewWithTitle:title
                                                             message:message
                                                   cancelButtonTitle:cancelButtonTitle
                                                   otherButtonTitles:otherButtons
                                                        dismissBlock:nil
                                               textFieldDismissBlock:dismissed
                                                         cancelBlock:cancelled];
#if !__has_feature(objc_arc)
    return [alert autorelease];
#else
    return alert;
#endif
}

- (UIAlertView*)showAlertViewWithTitle:(NSString*)title
                               message:(NSString*)message
                     cancelButtonTitle:(NSString*)cancelButtonTitle
                     otherButtonTitles:(NSArray*)otherButtons
                          dismissBlock:(DismissBlock)dismiss
                        textFieldDismissBlock:(TextFieldDismissBlock)textFieldDismiss
                                  cancelBlock:(CancelBlock)cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    [alert setCancelBlock:cancel];
    if (dismiss)
        [alert setDismissBlock:dismiss];
    if (textFieldDismiss) {
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert setTextFieldDismissBlock:textFieldDismiss];
    }
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
#if !__has_feature(objc_arc)
    return [alert autorelease];
#else
    return alert;
#endif
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                    message:(NSString*) message {
    
    return [UIAlertView alertViewWithTitle:title 
                                   message:message 
                         cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message
          cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
#if !__has_feature(objc_arc)
    return [alert autorelease];
#else
    return alert;
#endif
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex])
	{
		if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
	}
    else if (alertView.alertViewStyle==UIAlertViewStylePlainTextInput) {
        if (alertView.textFieldDismissBlock) {
            alertView.textFieldDismissBlock(buttonIndex - 1, [alertView textFieldAtIndex:0]);
        }
    }
    else
    {
        if (alertView.dismissBlock) {
            alertView.dismissBlock(buttonIndex - 1); // cancel button is button 0
        }
    }
}

@end