//
//  NSObject+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 25/03/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "NSObject+MKBlockAdditions.h"

static VoidBlock _block;

@implementation NSObject (MKBlockAdditions)

- (void) performBlock:(VoidBlock) aBlock
{
    [_block release];     
    _block = [aBlock copy];
    
    [self performSelector:@selector(callBlock)];
}

-(void) callBlock
{
    _block();
    [_block release];
    _block = nil;
}

@end
