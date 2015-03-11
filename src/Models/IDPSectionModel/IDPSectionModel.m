//
//  IDPSectionModel.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPSectionModel.h"

@interface IDPSectionModel ()

@property (nonatomic, strong) NSMutableArray    *sectionContent;

@end

@implementation IDPSectionModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Section Title";
        self.subtitle = @"Section subtitle";
        self.sectionContent = [NSMutableArray new];
    }
    return self;
}

@end
