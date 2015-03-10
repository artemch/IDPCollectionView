//
//  IDPCollectionViewCell.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "JNWCollectionViewCell.h"

/*
For binding background color of cell use hidden field in Binding inspector and IDPColorValueTransformer.
*/

@interface IDPCollectionViewCell : JNWCollectionViewCell

@property (nonatomic, strong) IBOutlet NSTextField          *title;
@property (nonatomic, strong) IBOutlet NSTextField          *subtitle;
@property (nonatomic, strong) IBOutlet NSObjectController   *objectController;

- (void)bindWithRelation:(NSArray *)relations toObject:(id)object;

@end
