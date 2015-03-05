//
//  IDPCollectionViewController.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewController.h"
#import "IDPCollectionViewView.h"
#import "IDPItemModel.h"
#import "NSViewController+IDPExtension.h"
#import "IDPCollectionViewCell.h"
#import "IDPCollectionViewReusableView.h"
#import "IDPSectionModel.h"

static NSInteger const kIDPTestObjectsCount = 10;
static NSInteger const kIDPSectionsCount = 5;

//static CGFloat const kIDPDefaultCellWidth  = 185;
//static CGFloat const kIDPDefaultCellHeight = 80;
//static CGFloat const kIDPDefaultHeaderHeight = 60;

//static CGFloat const kIDPItemVerticalSpacing = 10;
//static CGFloat const kIDPItemHorizontalMargin = 10;

@interface IDPCollectionViewController ()

@property (nonatomic, strong, readonly) IDPCollectionViewView   *myView;

@end

@implementation IDPCollectionViewController

#pragma mark -
#pragma mark Initializations and DeallocationsTest string

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setupCollectionView];
    self.objects = [NSMutableArray array];
    
    NSRect bounds = self.myView.collectionView.itemPrototype.view.bounds;
    bounds.size.width = NSWidth(self.view.frame);
    [self.myView.collectionView setMinItemSize:bounds.size];
    
    for (NSInteger index = 0; index < kIDPSectionsCount; index++) {
        IDPSectionModel *sectionModel = [IDPSectionModel new];
        sectionModel.title = [NSString stringWithFormat:@"Title %ld", (long)index];
        sectionModel.subtitle = @"Section header subtitle";
//        NSMutableArray *innerObjects = [NSMutableArray array];
        for (NSInteger kIndex = 0; kIndex < kIDPTestObjectsCount; kIndex++) {
            IDPItemModel *model = [IDPItemModel new];
            model.title = [NSString stringWithFormat:@"Title %ld-%ld", (long)index, (long)kIndex];
            model.color = [NSColor redColor];
            [sectionModel.objects addObject:model];
        }
//        [innerObjects addObject:model];
        [self.arrayController addObject:sectionModel];
//        [self.objects addObject:innerObjects];
    }
    
//    [self.myView.collectionView reloadData];
}

- (void)setupCollectionView {
//    JNWCollectionViewGridLayout *gridLayout = [[JNWCollectionViewGridLayout alloc] init];
//    gridLayout.delegate = self;
//    gridLayout.verticalSpacing = kIDPItemVerticalSpacing;
//    gridLayout.itemHorizontalMargin = kIDPItemHorizontalMargin;
//    gridLayout.itemSize = CGSizeMake(kIDPDefaultCellWidth, kIDPDefaultCellHeight);
//    
//    self.myView.collectionView.collectionViewLayout = gridLayout;
//    
//    NSString *identifier = NSStringFromClass([IDPCollectionViewCell class]);
//    NSNib *nib = [[NSNib alloc] initWithNibNamed:identifier bundle:nil];
//    [self.myView.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
//    
//    identifier = NSStringFromClass([IDPCollectionViewReusableView class]);
//    nib = [[NSNib alloc] initWithNibNamed:identifier bundle:nil];
//    
//    [self.myView.collectionView registerNib:nib forSupplementaryViewOfKind:JNWCollectionViewGridLayoutHeaderKind withReuseIdentifier:identifier];
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize(IDPCollectionViewView, myView)

//#pragma mark -
//#pragma mark Private methods
//
//- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
//    return NSStringFromClass([IDPCollectionViewCell class]);
//}
//
//- (NSString *)collectionViewSupplementaryViewIdentifierForSection:(NSInteger)section kind:(NSString *)kind {
//    return NSStringFromClass([IDPCollectionViewReusableView class]);
//}
//
//#pragma mark -
//#pragma mark JNWCollectionViewDataSource
//
//- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
//    return self.objects.count;
//}
//
//- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [[self.objects objectAtIndex:section] count];
//}
//
//- (JNWCollectionViewCell *)collectionView:(JNWCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    IDPCollectionViewCell *cell = (IDPCollectionViewCell *)[collectionView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath]];
//    id object = [[self.objects objectAtIndex:indexPath.jnw_section] objectAtIndex:indexPath.jnw_item];
//    [cell fillFromObject:object];
//    return cell;
//}
//
//- (JNWCollectionViewReusableView *)collectionView:(JNWCollectionView *)collectionView viewForSupplementaryViewOfKind:(NSString *)kind inSection:(NSInteger)section {
//    IDPCollectionViewReusableView *header = (IDPCollectionViewReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                                                                 withReuseIdentifer:[self collectionViewSupplementaryViewIdentifierForSection:section
//                                                                                                                                                                                         kind:kind]];
//    return header;
//}
//
//#pragma mark -
//#pragma mark JNWCollectionViewGridLayoutDelegate
//
//- (CGFloat)collectionView:(JNWCollectionView *)collectionView heightForHeaderInSection:(NSInteger)index {
//    return kIDPDefaultHeaderHeight;
//}
//
//#pragma mark -
//#pragma mark JNWCollectionViewDelegate
//
//- (BOOL)collectionView:(JNWCollectionView *)collectionView canDragItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)collectionView:(JNWCollectionView *)collectionView
//     dragFromIndexPath:(NSIndexPath *)fromIndexPath
//           toIndexPath:(NSIndexPath *)toIndexpath
//{
//    if (fromIndexPath.jnw_section == toIndexpath.jnw_section) {
//        NSMutableArray *array = [self.objects objectAtIndex:fromIndexPath.jnw_section];
//        [array exchangeObjectAtIndex:fromIndexPath.jnw_item withObjectAtIndex:toIndexpath.jnw_item];
//    } else {
//        NSMutableArray *fromArray = [self.objects objectAtIndex:fromIndexPath.jnw_section];
//        NSMutableArray *toArray = [self.objects objectAtIndex:toIndexpath.jnw_section];
//        id object = [fromArray objectAtIndex:fromIndexPath.jnw_item];
//        [toArray insertObject:object atIndex:toIndexpath.jnw_item];
//        [fromArray removeObject:object];
//    }
//}

@end