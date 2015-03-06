//
//  IDPCollectionViewController.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IDPCollectionViewController : NSViewController

@property (nonatomic, strong) NSMutableArray   *objects;
@property (nonatomic, strong) IBOutlet NSArrayController    *arrayController;

@end
