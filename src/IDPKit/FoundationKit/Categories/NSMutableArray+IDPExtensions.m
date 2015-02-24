//
//  NSMutableArray+IDPExtensions.m
//  IDPMailView
//
//  Created by Artem on 2/17/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"

@implementation NSMutableArray (IDPExtensions)

- (void)removeFirstObject {
    if (self.count > 0) {
        [self removeObjectAtIndex:0];
    }
}

@end
