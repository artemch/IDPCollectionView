//
//  IDPBindModel.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 3/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPBindModel : NSObject

@property (nonatomic, copy)   NSString      *bindTo;
@property (nonatomic, copy)   NSString      *bind;
@property (nonatomic, copy)   NSString      *keyPath;
@property (nonatomic, strong) NSDictionary  *options;

@end
