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

#define kIDPUnselectedCellColor [NSColor colorWithIntRed:255 green:245 blue:137 alpha:255]
#define kIDPSelectedCellColor   [NSColor colorWithIntRed:247 green:247 blue:247 alpha:255]

@implementation IDPCollectionViewCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kIDPUnselectedCellColor;
    
    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowColor:[NSColor colorWithIntRed:216 green:219 blue:219 alpha:255]];
    [dropShadow setShadowOffset:NSMakeSize(2.0, -2.0)];
    [dropShadow setShadowBlurRadius:0.0];
    
    [self setShadow:dropShadow];
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

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backgroundColor = selected ? kIDPSelectedCellColor : kIDPUnselectedCellColor;
}

@end
