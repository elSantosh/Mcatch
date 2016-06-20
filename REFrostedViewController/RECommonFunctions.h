//
// RECommonFunctions.h
// REFrostedViewController
//

#import <Foundation/Foundation.h>

#ifndef REUIKitIsFlatMode
#define REUIKitIsFlatMode() REFrostedViewControllerUIKitIsFlatMode()
#endif

BOOL REFrostedViewControllerUIKitIsFlatMode(void);