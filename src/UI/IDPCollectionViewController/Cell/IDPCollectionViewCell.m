//
//  IDPCollectionViewCell.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewCell.h"
#import "IDPTestModel.h"
#import "NSColor+IDPExtension.h"
#import "NSView+IDPExtension.h"

@implementation IDPCollectionViewCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowColor:[NSColor colorWithIntRed:216 green:219 blue:219 alpha:255]];
    [dropShadow setShadowOffset:NSMakeSize(2.0, -2.0)];
    [dropShadow setShadowBlurRadius:0.0];
    
    [self setShadow:dropShadow];
}

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
