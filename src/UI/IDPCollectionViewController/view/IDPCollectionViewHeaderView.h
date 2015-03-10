//
//  IDPCollectionViewReusableView.h
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "JNWCollectionViewReusableView.h"
#import "IDPBindModel.h"
#import "IDPKeyPathObserver.h"

@interface IDPCollectionViewHeaderView : JNWCollectionViewReusableView

@property (nonatomic, strong) IBOutlet NSTextField  *title;
@property (nonatomic, strong) IBOutlet NSTextField  *subtitle;
@property (nonatomic, strong) IBOutlet NSButton *button;
@property (nonatomic, strong) IBOutlet NSArrayController    *arrayController;

- (void)bindWithRelation:(NSArray *)relations toObject:(id)object;

- (void)startObservingArrayControllerWithObserver:(id<IDPKeyPathObserverDelegate>)observer;

@end
