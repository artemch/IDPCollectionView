//
//  IDPCollectionViewCell.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewCell.h"
#import "IDPTestModel.h"

@implementation IDPCollectionViewCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [NSColor greenColor];
}

#pragma mark -
#pragma mark Public methods

- (void)fillFromObject:(id)object {
    if ([object isKindOfClass:[IDPTestModel class]]) {
        IDPTestModel *model = (IDPTestModel *)object;
        self.title.stringValue = model.title;
        self.subtitle.stringValue = model.subtitle;
    }
}

@end
