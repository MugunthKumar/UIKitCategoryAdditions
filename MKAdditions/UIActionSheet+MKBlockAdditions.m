//
//  UIActionSheet+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 Steinlogic All rights reserved.
//

#import "UIActionSheet+MKBlockAdditions.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;
static PhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;

@implementation UIActionSheet (MKBlockAdditions)

+(void) actionSheetWithTitle:(NSString *)title
                     destructiveButtonTitle:(NSString *)destructiveButtonTitle
                     buttons:(NSArray *)buttonTitles
                    fromRect:(CGRect)rect
                  showInView:(UIView *)view
                   onDismiss:(DismissBlock)dismissed
                    onCancel:(CancelBlock)cancelled
                    animated:(BOOL)animated
{
    [UIActionSheet actionSheetWithTitle:title
                             titleColor:nil
                      titleUseLargeFont:NO
                 destructiveButtonTitle:destructiveButtonTitle
                                buttons:buttonTitles
                           buttonsColor:nil
                               fromRect:rect
                             showInView:view
                              onDismiss:dismissed
                               onCancel:cancelled
                               animated:animated];
}

+(void) actionSheetWithTitle:(NSString*) title
                  titleColor:(UIColor *)titleColor
           titleUseLargeFont:(BOOL)largeTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
                     buttons:(NSArray *)buttonTitles
                buttonsColor:(UIColor *)buttonColor
                    fromRect:(CGRect)rect
                  showInView:(UIView *)view
                   onDismiss:(DismissBlock)dismissed
                    onCancel:(CancelBlock)cancelled
                    animated:(BOOL)animated
{
#if !__has_feature(objc_arc)
    [_cancelBlock release];
    [_dismissBlock release];
#endif
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:(id<UIActionSheetDelegate>)[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles)
        [actionSheet addButtonWithTitle:thisButtonTitle];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle)
        actionSheet.cancelButtonIndex ++;
    
    if (buttonColor) {
        [actionSheet setButtonTitleColor:buttonColor];
    }
    
    [actionSheet showFromRect:rect inView:view animated:animated];
    
    if (titleColor) {
        [actionSheet setTitleColor:titleColor];
    }
    [actionSheet setLargeTitle:largeTitle];
#if !__has_feature(objc_arc)
    [actionSheet release];
#endif
}

+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(DismissBlock) dismissed                   
                    onCancel:(CancelBlock) cancelled
{    
    [UIActionSheet actionSheetWithTitle:title 
                                message:message 
                 destructiveButtonTitle:nil 
                                buttons:buttonTitles 
                             showInView:view 
                              onDismiss:dismissed 
                               onCancel:cancelled];
}

+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(DismissBlock) dismissed                   
                     onCancel:(CancelBlock) cancelled
{
#if !__has_feature(objc_arc)
    [_cancelBlock release];
    [_dismissBlock release];
#endif
    _cancelBlock  = [cancelled copy];
    _dismissBlock  = [dismissed copy];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class]
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles)
        [actionSheet addButtonWithTitle:thisButtonTitle];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle)
        actionSheet.cancelButtonIndex ++;
    
    if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    
#if !__has_feature(objc_arc)
    [actionSheet release];
#endif
}

+ (void) photoPickerWithTitle:(NSString*) title
                   showInView:(UIView*) view
                    presentVC:(UIViewController*) presentVC
                onPhotoPicked:(PhotoPickedBlock) photoPicked                   
                     onCancel:(CancelBlock) cancelled
{
#if !__has_feature(objc_arc)
    [_cancelBlock release];
    [_photoPickedBlock release];
    [_presentVC release];
#endif
    _cancelBlock  = [cancelled copy];
    _photoPickedBlock  = [photoPicked copy];
    
#if !__has_feature(objc_arc)
    _presentVC = [presentVC retain];
#else
    _presentVC = presentVC;
#endif
    
    int cancelButtonIndex = -1;

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id<UIActionSheetDelegate>)[self class]
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:nil];

	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", @"")];
		cancelButtonIndex ++;
	}
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Photo library", @"")];
		cancelButtonIndex ++;
	}
    
	[actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
	cancelButtonIndex ++;
	
    actionSheet.tag = kPhotoActionSheetTag;
	actionSheet.cancelButtonIndex = cancelButtonIndex;		 

	if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
#if !__has_feature(objc_arc)
    [actionSheet release];
#endif
}


+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage)
        editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerOriginalImage];
    
    _photoPickedBlock(editedImage);
	[picker dismissModalViewControllerAnimated:YES];	
#if !__has_feature(objc_arc)
    [picker autorelease];
#endif
}


+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [_presentVC dismissModalViewControllerAnimated:YES];
#if !__has_feature(objc_arc)
	[picker autorelease];
    [_presentVC release];
#endif
    _cancelBlock();
}

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
	if(buttonIndex == [actionSheet cancelButtonIndex])
	{
		_cancelBlock();
	}
    else
    {
        if(actionSheet.tag == kPhotoActionSheetTag)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                buttonIndex ++;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                buttonIndex ++;
            }
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)[self class];
            picker.allowsEditing = YES;
            
            if(buttonIndex == 1) 
            {                
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else if(buttonIndex == 2)
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
            [_presentVC presentModalViewController:picker animated:YES];
        }
        else
        {
            _dismissBlock(buttonIndex);
        }
    }
}

- (void)setButtonTitleColor:(UIColor *)color
{
    for (id view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view setTitleColor:color forState:UIControlStateNormal];
            [view setTitleColor:color forState:UIControlStateHighlighted];
            [view setTitleColor:color forState:UIControlStateSelected];
        }
    }
}

- (void)setTitleColor:(UIColor *)color
{
    UILabel *label = [self valueForKey:@"_titleLabel"];
    if (label) {
        if (color)
            [label setTextColor:color];
    }
}

- (void)setLargeTitle:(BOOL)largeTitle
{
    if (largeTitle) {
        UILabel *label = [self valueForKey:@"_titleLabel"];
        if (label) {
            UIFont *font = [UIFont boldSystemFontOfSize:17];
            [label setFont:font];
            [label setFrame:CGRectMake(0, label.frame.origin.y, self.frame.size.width, 34)];
        }
    }
}

@end
