//
//  IDPSectionModel.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/6/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppKitKit.h"

@interface IDPSectionModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *subtitle;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSArrayController *arrayController;

@end
