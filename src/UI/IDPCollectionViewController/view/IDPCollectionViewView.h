//
//  IDPControllerView.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JNWCollectionViewFramework.h"

@interface IDPCollectionViewView : NSView

@property (nonatomic, strong) IBOutlet JNWCollectionView *collectionView;

@end