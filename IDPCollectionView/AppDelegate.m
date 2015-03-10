//
//  AppDelegate.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "AppDelegate.h"
#import "IDPCollectionViewController.h"
#import "IDPItemModel.h"
#import "IDPSectionModel.h"

static NSInteger const kIDPTestObjectsCount = 10;
static NSInteger const kIDPSectionsCount = 5;


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) IBOutlet IDPCollectionViewController   *collectionViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    for (NSInteger index = 0; index < kIDPSectionsCount; index++) {
        IDPSectionModel *sectionModel = [IDPSectionModel new];
        sectionModel.title = [NSString stringWithFormat:@"Section %ld", (long)index];
        sectionModel.subtitle = [NSString stringWithFormat:@"Section header subtitle %ld", (long)index];
        for (NSInteger kIndex = 0; kIndex < kIDPTestObjectsCount; kIndex++) {
            IDPItemModel *model = [IDPItemModel new];
            model.title = [NSString stringWithFormat:@"Title %ld-%ld", (long)index, (long)kIndex];
            model.subtitle = [NSString stringWithFormat:@"Subtitle %ld/%ld", (long)index, (long)kIndex];
            [sectionModel.sectionContent addObject:model];
        }
        [self.collectionViewController.arrayController addObject:sectionModel];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
