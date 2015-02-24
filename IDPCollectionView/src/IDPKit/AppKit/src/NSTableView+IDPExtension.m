//
//  NSTableView+IDPExtension.m
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/11/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSTableView+IDPExtension.h"

@implementation NSTableView (IDPExtension)

#pragma mark -
#pragma mark Public methods

- (NSArray *)visibleRows {
    NSRange range = [self rangeOfVisibleRows];
    NSMutableArray *visibleRows = [NSMutableArray array];
    NSInteger endIndex = range.location + range.length;
    
    for (NSInteger index = range.location; index < endIndex; index++) {
        [visibleRows addObject:@(index)];
    }
    
    return visibleRows.count > 0 ? [NSArray arrayWithArray:visibleRows] : nil;
}

- (NSArray *)visibleCells {
    NSMutableArray *visibleCells = [NSMutableArray array];
    NSArray *visibleRows = [self visibleRows];
    for (NSNumber *row in [[visibleRows reverseObjectEnumerator] allObjects]) {
        NSTableCellView *cell = [self viewAtColumn:0 row:row.integerValue makeIfNecessary:NO];
        [visibleCells addObject:cell];
    }
    
    return visibleCells.count > 0 ? [NSArray arrayWithArray:visibleCells] :  nil;
}

- (NSTableCellView *)firstVisibleViewCell {
    return [self firstVisibleViewCellMakeIfNecessary:NO];
}

- (NSTableCellView *)firstVisibleViewCellMakeIfNecessary {
    return [self firstVisibleViewCellMakeIfNecessary:YES];
}

- (void)scrollToRow:(NSInteger)indexRow
   atScrollPosition:(IDPTableViewScrollPosition)scrollPosition
{
    NSScrollView *scrollView = [self enclosingScrollView];
    NSRect rect = [self rectOfRow:indexRow];
    NSRect frame = scrollView.frame;
    CGFloat halfFrameHeight = NSHeight(frame) / 2;
    NSRect bounds = self.bounds;
    NSPoint origin = [scrollView documentVisibleRect].origin;
    CGFloat y = rect.origin.y;
    
    BOOL userDefaultScrollToVisibleRow = YES;
    
    if (scrollPosition == IDPTableViewScrollPositionMiddle && y+halfFrameHeight < NSHeight(bounds) && y - halfFrameHeight > 0 ) {
        y = rect.origin.y - halfFrameHeight;
        userDefaultScrollToVisibleRow = NO;
    }
    
    if (userDefaultScrollToVisibleRow) {
        [self scrollRowToVisible:indexRow];
    } else {
        origin.y = y;
        [[scrollView documentView] scrollPoint:origin];
    }
}

#pragma mark -
#pragma mark Private methods

- (NSTableCellView *)firstVisibleViewCellMakeIfNecessary:(BOOL)makeIfNecessary {
    NSRange range = [self rangeOfVisibleRows];
    if (range.length == 0) {
        return nil;
    }
    NSTableCellView *cell = [self viewAtColumn:0 row:range.location makeIfNecessary:makeIfNecessary];
    return cell;
}

- (NSRange)rangeOfVisibleRows {
    NSScrollView *scrollView = [self enclosingScrollView];
    CGRect visibleRect = scrollView.contentView.visibleRect;
    NSRange range = [self rowsInRect:visibleRect];
    return range;
}

@end
