#import <substrate.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "./DLGMemor/memui/DLGMemEntry.h"

%ctor {
    @autoreleasepool {
        NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
        
        NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/jb/var/mobile/Library/Preferences/cn.devileo.dlgmemor.plist"];
        
        if([prefs[bundleID] boolValue])
        {
            NSLog(@"[DLGMemorInjector] Successfully Loaded");
            runDLGMem();
        }
    }
}

