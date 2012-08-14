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
#if ! __has_feature(objc_arc)
    [_block release];     
#endif
    _block = [aBlock copy];
    
    [self performSelector:@selector(callBlock)];
}

- (void) performBlock:(VoidBlock) aBlock afterDelay:(NSTimeInterval) delay
{
#if ! __has_feature(objc_arc)
    [_block release];     
#endif
    _block = [aBlock copy];

    [self performSelector:@selector(callBlock) withObject:nil afterDelay:delay];
}

-(void) callBlock
{
    _block();
#if ! __has_feature(objc_arc)
    [_block release];
#endif
    _block = nil;
}

@end
