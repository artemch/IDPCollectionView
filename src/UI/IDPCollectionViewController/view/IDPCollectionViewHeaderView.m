//
//  IDPCollectionViewReusableView.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewHeaderView.h"

@implementation IDPCollectionViewHeaderView

#pragma mark -
#pragma mark Public methods

- (void)prepareForReuse {
    [super prepareForReuse];
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

@end
