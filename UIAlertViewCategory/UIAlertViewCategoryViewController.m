//
//  UIAlertViewCategoryViewController.m
//  UIAlertViewCategory
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertViewCategoryViewController.h"
#import "UIAlertView+Block.h"

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
    [UIAlertView alertViewWithTitle:@"Test" 
                          onDismiss:^(int buttonIndex)
     {
         NSLog(@"%d", buttonIndex);
     }
                           onCancel:^()
     {
         NSLog(@"Cancelled");         
     }
                            message:@"Hello World" 
                  cancelButtonTitle:@"Dismiss" 
                  otherButtonTitles:[NSArray arrayWithObjects:@"First", @"Second", nil]];
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
