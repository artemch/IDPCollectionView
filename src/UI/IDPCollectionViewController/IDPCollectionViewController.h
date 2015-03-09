//
//  IDPCollectionViewController.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IDPBindModel.h"
#import "IDPSectionModel.h"
#import "NSIndexPath+JNWAdditions.h"

@interface IDPCollectionViewController : NSViewController

@property (nonatomic, strong) NSArray   *cellBindRelation;
@property (nonatomic, strong) NSArray   *headerBindRelation;

@property (nonatomic, strong, readonly) id selectedObject;

- (void)reloadData;

- (void)addObject:(IDPSectionModel *)object;
- (void)removeObject:(IDPSectionModel *)object;
- (void)insertObject:(IDPSectionModel *)object atIndex:(NSUInteger)index;
- (IDPSectionModel *)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(IDPSectionModel *)object;

@end