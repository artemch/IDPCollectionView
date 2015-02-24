//
//  NSViewController+IDPExtension.h
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/18/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define IDPViewControllerViewOfClassGetterSynthesize(theClass, getterName) \
- (theClass *)getterName { \
    if ([self.view isKindOfClass:[theClass class]]) {\
        return (theClass *)self.view;\
    }\
    return nil;\
}

@interface NSViewController (IDPExtension)

@end