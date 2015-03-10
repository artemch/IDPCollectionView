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

@property (nonatomic, strong) IDPKeyPathObserver    *dataSourceKeyPathObserver;
@property (nonatomic, strong) IDPKeyPathObserver    *headerKeyPathObserver;

@property (nonatomic, assign) CGFloat  headerHeight;

@property (nonatomic, assign) BOOL awakeOnce;

- (IBAction)onAddItem:(id)sender;

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
    
}

- (void)awakeFromNib {
    if (!self.awakeOnce) {
        self.awakeOnce = YES;
        [super awakeFromNib];
        [self viewBaseInit];
    }
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

- (void)setArrayController:(NSArrayController *)arrayController {
    _arrayController = arrayController;
    if (_arrayController) {
        self.dataSourceKeyPathObserver = [[IDPKeyPathObserver alloc] initWithObservedObject:self.arrayController observerObject:self];
        self.dataSourceKeyPathObserver.observedKeyPathsArray = @[@"arrangedObjects"];
        [self.dataSourceKeyPathObserver startObserving];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onAddItem:(id)sender {
    
}

#pragma mark -
#pragma mark Public methods

- (void)reloadData {
    [self.myView.collectionView reloadData];
}

#pragma mark -
#pragma mark JNWCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(JNWCollectionView *)collectionView {
    return [self.arrayController.arrangedObjects count];
}

- (NSUInteger)collectionView:(JNWCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    IDPSectionModel *model = [self.arrayController.arrangedObjects objectAtIndex:section];
    return [model.sectionContent count];
}

- (JNWCollectionViewCell *)collectionView:(JNWCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IDPCollectionViewCell *cell = (IDPCollectionViewCell *)[collectionView dequeueReusableCellWithIdentifier:NSStringFromClass([collectionView.itemPrototype class])
                                                                                                       owner:self];
    self.arrayController.selectionIndex = indexPath.jnw_section;
    IDPSectionModel *model = [self.arrayController.arrangedObjects objectAtIndex:indexPath.jnw_section];
    id object = [model.sectionContent objectAtIndex:indexPath.jnw_item];
    [cell bindWithRelation:self.cellBindRelation toObject:object];
    return cell;
}

- (JNWCollectionViewReusableView *)collectionView:(JNWCollectionView *)collectionView viewForSupplementaryViewOfKind:(NSString *)kind inSection:(NSInteger)section {
    IDPCollectionViewHeaderView *header = (IDPCollectionViewHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                                             withReuseIdentifer:NSStringFromClass([collectionView.headerPrototype class])
                                                                                                                          owner:self];
    IDPSectionModel *model = [self.arrayController.arrangedObjects objectAtIndex:section];
    header.arrayController.content = model.sectionContent;
    [header bindWithRelation:self.headerBindRelation toObject:model];
    [header startObservingArrayControllerWithObserver:self];
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
        IDPSectionModel *sectionModel = [self.arrayController.arrangedObjects objectAtIndex:fromIndexPath.jnw_section];
        id object = [sectionModel.sectionContent objectAtIndex:fromIndexPath.jnw_item];
        [sectionModel.sectionContent removeObject:object];
        [sectionModel.sectionContent insertObject:object atIndex:toIndexpath.jnw_item];
    } else {
        IDPSectionModel *sectionModelFrom = [self.arrayController.arrangedObjects objectAtIndex:fromIndexPath.jnw_section];
        IDPSectionModel *sectionModelTo = [self.arrayController.arrangedObjects objectAtIndex:toIndexpath.jnw_section];
        id object = [sectionModelFrom.sectionContent objectAtIndex:fromIndexPath.jnw_item];
        [sectionModelTo.sectionContent insertObject:object atIndex:toIndexpath.jnw_item];
        [sectionModelFrom.sectionContent removeObject:object];
    }
}

- (void)collectionView:(JNWCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark IDPKeyPathObserverDelegate

- (void)keyPathObserver:(IDPKeyPathObserver *)observer
        didCatchChanges:(NSDictionary *)changes
              inKeyPath:(NSString *)keyPath
               ofObject:(id<NSObject>)observedObject {
    if ([keyPath isEqualToString:@"arrangedObjects"]) {
        [self reloadData];
    }
}

@end