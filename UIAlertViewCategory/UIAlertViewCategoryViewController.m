//
//  UIAlertViewCategoryViewController.m
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertViewCategoryViewController.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "UIActionSheet+MKBlockAdditions.h"

@implementation UIAlertViewCategoryViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    [UIAlertView alertViewWithTitle:@"Test" 
                            message:@"Hello World" 
                  cancelButtonTitle:@"Dismiss" 
                  otherButtonTitles:[NSArray arrayWithObjects:@"First", @"Second", nil]
                          onDismiss:^(int buttonIndex)
     {
         NSLog(@"%d", buttonIndex);
     }
                           onCancel:^()
     {
         NSLog(@"Cancelled");         
     }
     ];
     */
    
    /*
    [UIActionSheet actionSheetWithTitle:@"Title" 
                                message:@"Message" 
                 destructiveButtonTitle:@"Delete" 
                                buttons:[NSArray arrayWithObjects:@"But 1", @"But 2", nil]
                             showInView:self.view 
                              onDismiss:^(int buttonIndex)
     {
         NSLog(@"%d", buttonIndex);
     }
                               onCancel:^
     {
         NSLog(@"Cancelled");
     }];
     
     */
    
    [UIActionSheet photoPickerWithTitle:@"Choose an avatar" 
                             showInView:self.view 
                              presentVC:self 
                          onPhotoPicked:^(UIImage* image) 
     {
         NSData *data = UIImagePNGRepresentation(image);
         [data writeToFile:@"/Users/mugunth/Desktop/test.png" atomically:YES];
     }
                               onCancel:^
     {
         NSLog(@"Cancelled"); 
     }];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
