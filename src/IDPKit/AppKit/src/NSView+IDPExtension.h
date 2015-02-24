//
//  NSView+IDPExtension.h
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/11/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (IDPExtension)

@property (nonatomic, strong) NSColor *backgroundViewColor;

- (void)round;
- (void)roundWithValue:(CGFloat)value;
- (void)borderWidthValue:(CGFloat)value;
- (void)borderViewColor:(NSColor *)color;
- (NSImage *)imageFromView;
- (NSImage *)imageRepresentation;

@end
