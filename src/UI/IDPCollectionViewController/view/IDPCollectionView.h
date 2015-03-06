//
//  IDPControllerView.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JNWCollectionView.h"

@interface IDPCollectionView : NSView

@property (nonatomic, strong) IBOutlet JNWCollectionView *collectionView;
@property (nonatomic, strong) IBOutlet NSTableView  *tableView;

@end