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
    self.objectController.content = nil;
}

- (void)bindWithRelation:(NSArray *)relations toObject:(id)object {
    
}

- (void)bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
    if ([binding isEqualToString:@"hidden"]) {
        NSView *backgroundView = [self valueForKey:@"backgroundView"];
        [backgroundView bind:@"color" toObject:observable withKeyPath:keyPath options:options];
    } else {
        [super bind:binding toObject:observable withKeyPath:keyPath options:options];
    }
}

@end
