//
//  IDPSectionModel.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/4/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPSectionModel.h"

@implementation IDPSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

@end
