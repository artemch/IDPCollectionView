//
//  IDPTestModel.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface IDPItemModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *subtitle;
@property (nonatomic, assign) NSInteger value1;
@property (nonatomic, assign) NSInteger value2;

@property (nonatomic, strong) NSColor   *color;

@end
