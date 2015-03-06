//
//  IDPCollectionViewItem.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/6/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewItem.h"

@interface IDPCollectionViewItem ()

@end

@implementation IDPCollectionViewItem

- (void)awakeFromNib {
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor redColor] CGColor];
    [super awakeFromNib];
}

@end
