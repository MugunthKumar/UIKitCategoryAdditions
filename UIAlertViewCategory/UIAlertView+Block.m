//
//  UIAlertView+Block.m
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+Block.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (Block)

+ (void) alertViewWithTitle:(NSString*) title                    
                  onDismiss:(DismissBlock) dismissed                   
                   onCancel:(CancelBlock) cancelled
                    message:(NSString*) message 
          cancelButtonTitle:(NSString*) cancelButtonTitle
          otherButtonTitles:(NSString*) otherButtons, ...
{
    
    [_cancelBlock release];
    _cancelBlock  = [cancelled copy];

    [_dismissBlock release];
    _dismissBlock  = [cancelled copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:otherButtons, nil];
    [alert show];
    [alert release];
}

+ (void) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

+ (void) alertViewWithTitle:(NSString*) title 
                    message:(NSString*) message
          cancelButtonTitle:(NSString*) cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
	if(buttonIndex != [alertView cancelButtonIndex])
	{
		_cancelBlock();
        [_cancelBlock release];
	}
    else
    {
        _dismissBlock(buttonIndex);
        [_dismissBlock release];
    }
}
@end
