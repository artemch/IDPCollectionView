/*
 Copyright (c) 2013, Jonathan Willing. All rights reserved.
 Licensed under the MIT license <http://opensource.org/licenses/MIT>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions
 of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 IN THE SOFTWARE.
 */

#import "JNWCollectionViewCell.h"
#import "JNWCollectionViewCell+Private.h"
#import "JNWCollectionView+Private.h"
#import <QuartzCore/QuartzCore.h>

@interface JNWCollectionViewCellBackgroundView : NSView
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, weak) JNWCollectionView *collectionView;
@end

@implementation JNWCollectionViewCellBackgroundView

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self == nil) return nil;
    [self baseInit];
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

- (void)baseInit {
    self.wantsLayer = YES;
    self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
}

- (void)setImage:(NSImage *)image {
	_image = image;
	[self setNeedsDisplay:YES];
}

- (void)setColor:(NSColor *)color {
	_color = color;
	[self setNeedsDisplay:YES];
}

- (void)setFrame:(NSRect)frameRect {
	if (CGRectEqualToRect(self.frame, frameRect))
		return;

	[super setFrame:frameRect];
	[self setNeedsDisplay:YES];
}

- (BOOL)wantsUpdateLayer {
	return YES;
}

- (void)updateLayer {
	self.layer.contents = self.image;
	self.layer.backgroundColor = self.color.CGColor;
}

@end

static NSTimeInterval const kIDPMouseHoldTimerDuration = 0.2;
static NSString *const kIDPEventKey = @"event";

@interface JNWCollectionViewCell()

@property (nonatomic, strong) JNWCollectionViewCellBackgroundView *backgroundView;
@property (nonatomic, strong) NSTimer *mouseHoldTimer;

@end

@implementation JNWCollectionViewCell

@synthesize contentView = _contentView;
@synthesize backgroundColor = _backgroundColor;

- (void)dealloc
{
    self.mouseHoldTimer = nil;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self == nil) return nil;
	
	[self baseInit];
	
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

- (void)baseInit {
    self.wantsLayer = YES;
    self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    _backgroundView = [[JNWCollectionViewCellBackgroundView alloc] initWithFrame:self.bounds];
    _backgroundView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    _crossfadeDuration = 0.25;
    
    [self addSubview:_backgroundView positioned:NSWindowBelow relativeTo:_contentView];
}

- (void)prepareForReuse {
	[self.backgroundView.layer removeAllAnimations];
    [self stopMouseDownTimer];
	// for subclasses
}

- (void)willLayoutWithFrame:(CGRect)frame {
	// for subclasses
}

- (NSView *)contentView {
	if (_contentView == nil) {
		_contentView = [[NSView alloc] initWithFrame:self.bounds];
		[self configureContentView:_contentView];
	}
	
	return _contentView;
}

- (void)setContentView:(NSView *)contentView {
	if (_contentView) {
		[_contentView removeFromSuperview];
	}
	
	_contentView = contentView;
	[self configureContentView:contentView];
}

- (void)configureContentView:(NSView *)contentView {
	contentView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	contentView.wantsLayer = YES;
	
	[self addSubview:contentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animate {
	if (animate && self.selected != selected) {
		CATransition *transition = [CATransition animation];
		transition.duration = self.crossfadeDuration;
		[self.backgroundView.layer addAnimation:transition forKey:@"fade"];
	}
	
	self.selected = selected;
}

- (void)setCollectionView:(JNWCollectionView *)collectionView {
	_collectionView = collectionView;
	self.backgroundView.collectionView = collectionView;
}

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    _backgroundColor = backgroundColor;
	self.backgroundView.color = backgroundColor;
}

- (NSColor *)backgroundColor {
    return _backgroundColor;
}

- (void)setBackgroundImage:(NSImage *)backgroundImage {
	self.backgroundView.image = backgroundImage;
}

- (NSImage *)backgroundImage {
	return self.backgroundView.image;
}

- (void)mouseDown:(NSEvent *)theEvent {
	[super mouseDown:theEvent];
    [self starMouseDownTimer:theEvent];
//    [self.collectionView mouseDownInCollectionViewCell:self withEvent:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [self checkMouseDownTimer];
	[super mouseUp:theEvent];
	[self.collectionView mouseUpInCollectionViewCell:self withEvent:theEvent];
	
	if (theEvent.clickCount == 2) {
		[self.collectionView doubleClickInCollectionViewCell:self withEvent:theEvent];
	}
}

- (void)rightMouseDown:(NSEvent *)theEvent {
	[super rightMouseDown:theEvent];
	
	[self.collectionView rightClickInCollectionViewCell:self withEvent:theEvent];
}

//- (void)mouseDragged:(NSEvent *)theEvent {
//    [super mouseDragged:theEvent];
//    [self.collectionView mouseDraggedInCollectionViewCell:self withEvent:theEvent];
//}

#pragma mark NSObject

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p; frame = %@; layer = <%@: %p>>", self.class, self, NSStringFromRect(self.frame), self.layer.class, self.layer];
}

#pragma mark -
#pragma mark Accessor methods

- (void)setMouseHoldTimer:(NSTimer *)mousDownTimer {
    [_mouseHoldTimer invalidate];
    _mouseHoldTimer = mousDownTimer;
}

#pragma mark -
#pragma mark Public methods

- (NSImage *)draggingImageRepresentation {
    NSSize imgSize = self.bounds.size;
    
    NSBitmapImageRep *bir = [self bitmapImageRepForCachingDisplayInRect:[self bounds]];
    [bir setSize:imgSize];
    
    [self cacheDisplayInRect:[self bounds] toBitmapImageRep:bir];
    
    NSImage *image = [[NSImage alloc] initWithSize:imgSize];
    [image addRepresentation:bir];
    
    return image;
}

#pragma mark -
#pragma mark Private methods

- (void)starMouseDownTimer:(NSEvent *)event {
    self.mouseHoldTimer = [NSTimer scheduledTimerWithTimeInterval:kIDPMouseHoldTimerDuration target:self selector:@selector(mouseHoldTimerFire:) userInfo:@{kIDPEventKey: event} repeats:NO];
}

- (void)checkMouseDownTimer {
    if (self.mouseHoldTimer) {
        NSDictionary *userInfo = (NSDictionary *)self.mouseHoldTimer.userInfo;
        NSEvent *theEvent = [userInfo objectForKey:kIDPEventKey];
        [self.collectionView mouseDownInCollectionViewCell:self withEvent:theEvent];
    }
    [self stopMouseDownTimer];
}

- (void)stopMouseDownTimer {
    self.mouseHoldTimer = nil;
}

- (void)mouseHoldTimerFire:(NSTimer *)timer {
    if (timer == self.mouseHoldTimer) {
        NSDictionary *userInfo = (NSDictionary *)self.mouseHoldTimer.userInfo;
        NSEvent *theEvent = [userInfo objectForKey:kIDPEventKey];
        [self.collectionView mouseDraggedInCollectionViewCell:self withEvent:theEvent];
    }
}

@end
