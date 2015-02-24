//
//  NSTableView+IDPExtension.h
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/11/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    IDPTableViewScrollPositionNone,
    // Not supported yet
//    IDPTableViewScrollPositionTop,
    IDPTableViewScrollPositionMiddle,
    // Not supported yet
//    IDPTableViewScrollPositionBottom
} IDPTableViewScrollPosition;

@interface NSTableView (IDPExtension)

- (NSArray *)visibleRows;
- (NSArray *)visibleCells;
- (NSTableCellView *)firstVisibleViewCell;
- (NSTableCellView *)firstVisibleViewCellMakeIfNecessary;

- (void)scrollToRow:(NSInteger)indexRow
              atScrollPosition:(IDPTableViewScrollPosition)scrollPosition;

@end
