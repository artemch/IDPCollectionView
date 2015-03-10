//
//  IDPTestModel.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface IDPItemModel : NSObject

@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *subtitle;
@property (nonatomic, strong) NSColor   *backgroundColor;

@end
