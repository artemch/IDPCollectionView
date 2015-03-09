//
//  IDPCollectionViewController.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewController.h"
#import "IDPCollectionViewView.h"
#import "NSViewController+IDPExtension.h"
#import "IDPKeyPathObserver.h"
#import "IDPKVOMutableArray.h"
#import "IDPCollectionViewCell.h"
#import "IDPCollectionViewHeaderView.h"
#import "NSNib+IDPExtension.h"
#import "JNWCollectionViewGridLayout.h"

static CGFloat const kIDPDefaultCellWidth  = 185;
static CGFloat const kIDPDefaultCellHeight = 80;
static CGFloat const kIDPDefaultHeaderHeight = 60;

static CGFloat const kIDPItemVerticalSpacing = 10;
static CGFloat const kIDPItemHorizontalMargin = 10;

@interface IDPCollectionViewController () <JNWCollectionViewDataSource, JNWCollectionViewDelegate, JNWCollectionViewGridLayoutDelegate, IDPKeyPathObserverDelegate>

@property (nonatomic, strong, readonly) IDPCollectionViewView   *myView;

@property (nonatomic, strong) NSMutableArray   *dataSourceObjects;

@property (nonatomic, strong) IDPKeyPathObserver    *dataSourceKeyPathObserver;
@property (nonatomic, strong) IDPKeyPathObserver    *headerKeyPathObserver;

@property (nonatomic, assign) CGFloat  headerHeight;

@end

@implementation IDPCollectionViewController

#pragma mark -
#pragma mark Initializations and DeallocationsTest string

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    self.dataSourceObjects = [IDPKVOMutableArray array];
    self.dataSourceKeyPathObserver = [[IDPKeyPathObserver alloc] initWithObservedObject:self.dataSourceObjects observerObject:self];
    self.dataSourceKeyPathObserver.observedKeyPathsArray = @[@"count"];
    [self.dataSourceKeyPathObserver startObserving];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewBaseInit];
}

- (void)loadView {
    [super loadView];
    [self viewBaseInit];
}

- (void)viewBaseInit {
    [self setupCollectionView];
}

- (void)setupCollectionView {
    self.headerHeight = kIDPDefaultHeaderHeight;
    
    JNWCollectionViewGridLayout *gridLayout = [[JNWCollectionViewGridLayout alloc] init];
    gridLayout.verticalSpacing = kIDPItemVerticalSpacing;
    gridLayout.itemHorizontalMargin = kIDPItemHorizontalMargin;
    gridLayout.itemSize = CGSizeMake(kIDPDefaultCellWidth, kIDPDefaultCellHeight);
    gridLayout.delegate = self;
    
    self.myView.collectionView.collectionViewLayout = gridLayout;
    
    IDPCollectionViewCell *cell = [NSNib objectOfClass:[IDPCollectionViewCell class]];
    gridLayout.itemSize = cell.frame.size;
    
    IDPCollectionViewHeaderView *view = [NSNib objectOfClass:[IDPCollectionViewHeaderView class]];
    self.headerHeight = NSHeight(view.frame);
}

#pragma mark -
#pragma mark Accessor methods

IDPViewControllerViewOfClassGetterSynthesize(IDPCollectionViewView, myView)

#pragma mark -
#pragma mark Public methods

- (void)reloadData {
    [self.myView.collectionView reloadData];
}

- (void)addObject:(IDPSectionModel *)object {
    [self.dataSourceObjects addObject:object];
}

- (void)removeObject:(IDPSectionModel *)object {
    [self.dataSourceObjects removeObject:object];
}

- (void)insertObject:(IDPSectionModel *)object atIndex:(NSUInteger)index {
    [self.dataSourceObjects insertObject:object atIndex:index];
}

- (IDPSectionModel *)objectAtIndex:(NSUInteger)index {
    return [self.dataSourceObjects objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(IDPSectionModel *)object {
    return [self.dataSourceObjects indexOfObject:object];
}

#pragma mark -
#pragma mark JNWCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
    return self.dataSourceObjects.count;
}

- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    IDPSectionModel *model = [self.dataSourceObjects objectAtIndex:section];
    return model.sectionContent.count;
}

- (JNWCollectionViewCell *)collectionView:(JNWCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IDPCollectionViewCell *cell = (IDPCollectionViewCell *)[collectionView dequeueReusableCellWithIdentifier:NSStringFromClass([collectionView.itemPrototype class])];
    IDPSectionModel *model = [self.dataSourceObjects objectAtIndex:indexPath.jnw_section];
    id object = [model.sectionContent objectAtIndex:indexPath.jnw_item];
    [cell bindWithRelation:self.cellBindRelation toObject:object];
    return cell;
}

- (JNWCollectionViewReusableView *)collectionView:(JNWCollectionView *)collectionView viewForSupplementaryViewOfKind:(NSString *)kind inSection:(NSInteger)section {
    IDPCollectionViewHeaderView *header = (IDPCollectionViewHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                                             withReuseIdentifer:NSStringFromClass([collectionView.headerPrototype class])];
    IDPSectionModel *model = [self.dataSourceObjects objectAtIndex:section];
    [header bindWithRelation:self.headerBindRelation toObject:model];
    return header;
}

#pragma mark -
#pragma mark JNWCollectionViewGridLayoutDelegate

- (CGFloat)collectionView:(JNWCollectionView *)collectionView heightForHeaderInSection:(NSInteger)index {
    return self.headerHeight;
}

#pragma mark -
#pragma mark JNWCollectionViewDelegate

- (BOOL)collectionView:(JNWCollectionView *)collectionView canDragItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(JNWCollectionView *)collectionView
     dragFromIndexPath:(NSIndexPath *)fromIndexPath
           toIndexPath:(NSIndexPath *)toIndexpath
{
    if (fromIndexPath.jnw_section == toIndexpath.jnw_section) {
        IDPSectionModel *sectionModel = [self.dataSourceObjects objectAtIndex:fromIndexPath.jnw_section];
        [sectionModel.sectionContent exchangeObjectAtIndex:fromIndexPath.jnw_item withObjectAtIndex:toIndexpath.jnw_item];
    } else {
        IDPSectionModel *sectionModelFrom = [self.dataSourceObjects objectAtIndex:fromIndexPath.jnw_section];
        IDPSectionModel *sectionModelTo = [self.dataSourceObjects objectAtIndex:toIndexpath.jnw_section];
        id object = [sectionModelFrom.sectionContent objectAtIndex:fromIndexPath.jnw_item];
        [sectionModelTo.sectionContent insertObject:object atIndex:toIndexpath.jnw_item];
        [sectionModelFrom.sectionContent removeObject:object];
    }
}

#pragma mark -
#pragma mark IDPKeyPathObserverDelegate

- (void)keyPathObserver:(IDPKeyPathObserver *)observer
        didCatchChanges:(NSDictionary *)changes
              inKeyPath:(NSString *)keyPath
               ofObject:(id<NSObject>)observedObject {
    if (observer == self.dataSourceKeyPathObserver && observedObject == self.dataSourceObjects) {
        [self reloadData];
    }
}

@end