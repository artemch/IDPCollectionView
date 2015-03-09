//
//  AppDelegate.m
//  IDPCollectionView
//
//  Created by Artem Chabanniy on 2/24/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "AppDelegate.h"
#import "IDPCollectionViewController.h"
#import "IDPTestModel.h"
#import "NSColor+IDPExtension.h"
#import "IDPSectionModel.h"

static NSInteger const kIDPTestObjectsCount = 10;
static NSInteger const kIDPSectionsCount = 5;


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) IBOutlet IDPCollectionViewController   *collectionViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    IDPBindModel *bindModel = [IDPBindModel new];
    bindModel.bindTo = @"title";
    bindModel.bind = @"value";
    bindModel.keyPath = @"title";
    
    IDPBindModel *bindModel2 = [IDPBindModel new];
    bindModel2.bindTo = @"subtitle";
    bindModel2.bind = @"value";
    bindModel2.keyPath = @"subtitle";
    
    IDPBindModel *bindModel3 = [IDPBindModel new];
    bindModel3.bindTo = @"backgroundView";
    bindModel3.bind = @"color";
    bindModel3.keyPath = @"backgroundColor";
    
    self.collectionViewController.cellBindRelation = @[bindModel, bindModel2, bindModel3];
    NSColor *backgroundColor = [NSColor colorWithIntRed:255 green:245 blue:137 alpha:255];
    
    bindModel = [IDPBindModel new];
    bindModel.bindTo = @"title";
    bindModel.bind = @"value";
    bindModel.keyPath = @"title";
    
    bindModel2 = [IDPBindModel new];
    bindModel2.bindTo = @"subtitle";
    bindModel2.bind = @"value";
    bindModel2.keyPath = @"subtitle";
    self.collectionViewController.headerBindRelation = @[bindModel, bindModel2];
    
    for (NSInteger index = 0; index < kIDPSectionsCount; index++) {
        IDPSectionModel *sectionModel = [IDPSectionModel new];
        sectionModel.title = [NSString stringWithFormat:@"Section %ld", (long)index];
        sectionModel.subtitle = [NSString stringWithFormat:@"Section header subtitle %ld", (long)index];
        for (NSInteger kIndex = 0; kIndex < kIDPTestObjectsCount; kIndex++) {
            IDPTestModel *model = [IDPTestModel new];
            model.title = [NSString stringWithFormat:@"Title %ld-%ld", (long)index, (long)kIndex];
            model.subtitle = [NSString stringWithFormat:@"Subtitle %ld/%ld", (long)index, (long)kIndex];
            model.backgroundColor = backgroundColor;
            [sectionModel.sectionContent addObject:model];
        }
        [self.collectionViewController addObject:sectionModel];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
