//
//  IDPCollectionViewController.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewController.h"
#import "IDPCollectionView.h"
#import "IDPTestModel.h"
#import "NSViewController+IDPExtension.h"
#import "IDPCollectionViewCell.h"

static NSInteger const kIDPTestObjectsCount = 10;

static CGFloat const kIDPDefaultCellWidth  = 100;
static CGFloat const kIDPDefaultCellHeight = 100;

@interface IDPCollectionViewController () <JNWCollectionViewDataSource, JNWCollectionViewGridLayoutDelegate>

@property (nonatomic, strong, readonly) IDPCollectionView   *myView;

@end

@implementation IDPCollectionViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCollectionView];
    
    self.objects = [NSMutableArray array];
    for (NSInteger index = 0; index < kIDPTestObjectsCount; index++) {
        IDPTestModel *model = [IDPTestModel new];
//        [self.arrayController addObject:model];
        [self.objects addObject:model];
    }
    
    [self.myView.collectionView reloadData];
}

- (void)setupCollectionView {
    JNWCollectionViewGridLayout *gridLayout = [[JNWCollectionViewGridLayout alloc] init];
    gridLayout.delegate = self;
    gridLayout.verticalSpacing = 10.f;
    
    self.myView.collectionView.collectionViewLayout = gridLayout;
    self.myView.collectionView.animatesSelection = NO; // (this is the default option)
    
    NSString *identifier = NSStringFromClass([IDPCollectionViewCell class]);
    NSNib *nib = [[NSNib alloc] initWithNibNamed:identifier bundle:nil];
    [self.myView.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize(IDPCollectionView, myView)

#pragma mark -
#pragma mark Private methods

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return NSStringFromClass([IDPCollectionViewCell class]);
}

#pragma mark -
#pragma mark JNWCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
    return 5;
}

- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (CGSize)sizeForItemInCollectionView:(JNWCollectionView *)collectionView {
    return CGSizeMake(kIDPDefaultCellWidth, kIDPDefaultCellHeight);
}

- (JNWCollectionViewCell *)collectionView:(JNWCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IDPCollectionViewCell *cell = (IDPCollectionViewCell *)[collectionView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath]];
    [cell fillFromObject:[self.objects objectAtIndex:indexPath.jnw_item]];
    return cell;
}

#pragma mark -
#pragma mark JNWCollectionViewGridLayoutDelegate

@end
