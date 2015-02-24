//
//  IDPTestModel.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPTestModel.h"

@implementation IDPTestModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Title string";
        self.subtitle = @"Subtitle string";
    }
    return self;
}

@end
