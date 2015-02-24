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
#import "IDPCollectionViewReusableView.h"

static NSInteger const kIDPTestObjectsCount = 10;

static CGFloat const kIDPDefaultCellWidth  = 150;
static CGFloat const kIDPDefaultCellHeight = 100;
static CGFloat const kIDPDefaultHeaderHeight = 50;

@interface IDPCollectionViewController () <JNWCollectionViewDataSource, JNWCollectionViewDelegate, JNWCollectionViewGridLayoutDelegate>

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
        [self.objects addObject:model];
    }
    
    [self.myView.collectionView reloadData];
}

- (void)setupCollectionView {
    JNWCollectionViewGridLayout *gridLayout = [[JNWCollectionViewGridLayout alloc] init];
    gridLayout.delegate = self;
    gridLayout.verticalSpacing = 10.f;
    gridLayout.itemSize = CGSizeMake(kIDPDefaultCellWidth, kIDPDefaultCellHeight);
    
    self.myView.collectionView.collectionViewLayout = gridLayout;
    self.myView.collectionView.animatesSelection = YES;
    
    NSString *identifier = NSStringFromClass([IDPCollectionViewCell class]);
    NSNib *nib = [[NSNib alloc] initWithNibNamed:identifier bundle:nil];
    [self.myView.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    
    identifier = NSStringFromClass([IDPCollectionViewReusableView class]);
    nib = [[NSNib alloc] initWithNibNamed:identifier bundle:nil];
    
    [self.myView.collectionView registerNib:nib forSupplementaryViewOfKind:JNWCollectionViewGridLayoutHeaderKind withReuseIdentifier:identifier];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize(IDPCollectionView, myView)

#pragma mark -
#pragma mark Private methods

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return NSStringFromClass([IDPCollectionViewCell class]);
}

- (NSString *)collectionViewSupplementaryViewIdentifierForSection:(NSInteger)section kind:(NSString *)kind {
    return NSStringFromClass([IDPCollectionViewReusableView class]);
}

#pragma mark -
#pragma mark JNWCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
    return 5;
}

- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (JNWCollectionViewCell *)collectionView:(JNWCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IDPCollectionViewCell *cell = (IDPCollectionViewCell *)[collectionView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath]];
    [cell fillFromObject:[self.objects objectAtIndex:indexPath.jnw_item]];
    return cell;
}

- (JNWCollectionViewReusableView *)collectionView:(JNWCollectionView *)collectionView viewForSupplementaryViewOfKind:(NSString *)kind inSection:(NSInteger)section {
    IDPCollectionViewReusableView *header = (IDPCollectionViewReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                                                 withReuseIdentifer:[self collectionViewSupplementaryViewIdentifierForSection:section
                                                                                                                                                                                         kind:kind]];
    return header;
}

#pragma mark -
#pragma mark JNWCollectionViewGridLayoutDelegate

//- (CGSize)sizeForItemInCollectionView:(JNWCollectionView *)collectionView {
//    return CGSizeMake(kIDPDefaultCellWidth, kIDPDefaultCellHeight);
//}

- (CGFloat)collectionView:(JNWCollectionView *)collectionView heightForHeaderInSection:(NSInteger)index {
    return kIDPDefaultHeaderHeight;
}

#pragma mark -
#pragma mark JNWCollectionViewDelegate

@end