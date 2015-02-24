//
//  IDPCollectionViewCell.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <JNWCollectionView/JNWCollectionViewCell.h>

@interface IDPCollectionViewCell : JNWCollectionViewCell

@property (nonatomic, strong) IBOutlet NSTextField  *title;
@property (nonatomic, strong) IBOutlet NSTextField  *subtitle;

- (void)fillFromObject:(id)object;

@end
