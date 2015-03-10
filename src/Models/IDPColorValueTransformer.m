//
//  IDPColorValueTransformer.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/10/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPColorValueTransformer.h"
#import <Cocoa/Cocoa.h>

@implementation IDPColorValueTransformer

+ (Class)transformedValueClass {
    return [NSColor class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}


@end
