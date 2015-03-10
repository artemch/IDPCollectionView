//
//  IDPCollectionViewCell.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCollectionViewCell.h"
#import "IDPItemModel.h"
#import "NSColor+IDPExtension.h"
#import "NSView+IDPExtension.h"
#import "IDPColorValueTransformer.h"

static NSString *const kIDPBackgroundView    = @"backgroundView";
static NSString *const kIDPBindingIdentifier = @"hidden";
static NSString *const kIDPBindindValue      = @"color";

@implementation IDPCollectionViewCell

+ (void)initialize {
    if (self == [self class]) {
        [NSValueTransformer setValueTransformer:[IDPColorValueTransformer new]
                                        forName:NSStringFromClass([IDPColorValueTransformer class])];
    }
}

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
    self.objectController.content = nil;
}

- (void)bindWithRelation:(NSArray *)relations toObject:(id)object {
    
}

- (void)bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
    if ([binding isEqualToString:kIDPBindingIdentifier]) {
        NSView *backgroundView = [self valueForKey:kIDPBackgroundView];
        [backgroundView bind:kIDPBindindValue toObject:observable withKeyPath:keyPath options:options];
    } else {
        [super bind:binding toObject:observable withKeyPath:keyPath options:options];
    }
}

@end
