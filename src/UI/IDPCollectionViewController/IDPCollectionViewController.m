//
//  IDPCollectionViewController.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewController.h"
#import "IDPTestModel.h"

static NSInteger const kIDPTestObjectsCount = 10;

@implementation IDPCollectionViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    self.objects = [NSMutableArray array];
    for (NSInteger index = 0; index < kIDPTestObjectsCount; index++) {
        IDPTestModel *model = [IDPTestModel new];
        [self.arrayController addObject:model];
    }
}

@end
