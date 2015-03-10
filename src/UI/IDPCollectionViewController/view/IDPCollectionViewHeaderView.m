//
//  IDPCollectionViewReusableView.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewHeaderView.h"

@interface IDPCollectionViewHeaderView ()

@property (nonatomic, strong) IDPKeyPathObserver   *arrayControllerKeyPathObserver;
@property (nonatomic, strong) NSArray  *bindRelation;

@end

@implementation IDPCollectionViewHeaderView

#pragma mark -
#pragma mark Public methods

- (void)prepareForReuse {
    [super prepareForReuse];
    self.arrayControllerKeyPathObserver = nil;
    for (IDPBindModel *bindModel in self.bindRelation) {
        id bindToSource = [self valueForKey:bindModel.bindTo];
        [bindToSource unbind:bindModel.bind];
    }
}

- (void)bindWithRelation:(NSArray *)relations toObject:(id)object {
    self.bindRelation = relations;
    for (IDPBindModel *bindModel in relations) {
        id bindToSource = [self valueForKey:bindModel.bindTo];
        [bindToSource bind:bindModel.bind toObject:object withKeyPath:bindModel.keyPath options:bindModel.options];
    }
}

- (void)startObservingArrayControllerWithObserver:(id<IDPKeyPathObserverDelegate>)observer {
    self.arrayControllerKeyPathObserver = [[IDPKeyPathObserver alloc] initWithObservedObject:self.arrayController observerObject:observer];
    self.arrayControllerKeyPathObserver.observedKeyPathsArray = @[@"arrangedObjects"];
    [self.arrayControllerKeyPathObserver startObserving];
}

@end
