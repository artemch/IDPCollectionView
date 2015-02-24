//
//  IDPCollectionViewController.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IDPCollectionViewController : NSViewController <NSCollectionViewDelegate>

@property (nonatomic, strong) IBOutlet NSArrayController    *arrayController;

@property (nonatomic, strong) NSMutableArray   *objects;

@end