#include "DMIPRootListController.h"
#define PREFERENCE_IDENTIFIER @"/var/jb/var/mobile/Library/Preferences/cn.devileo.dlgmemor.plist"

NSMutableDictionary *prefs;

@implementation DMIPRootListController

-(NSArray*)getSpecifiersForAppSection:(NSInteger)type {
    NSArray<LSApplicationProxy*>* allInstalledApplications = [[LSApplicationWorkspace defaultWorkspace] atl_allInstalledApplications];
    NSArray<ATLApplicationSection*>* appSections = @[[[[ATLApplicationSection alloc] init] initNonCustomSectionWithType:type]];
    
    [appSections enumerateObjectsUsingBlock:^(ATLApplicationSection* section, NSUInteger idx, BOOL *stop)
     {
        [section populateFromAllApplications:allInstalledApplications];
    }];
    
	//CRASH FIXED...
    NSMutableArray* specifiersForSection = [NSMutableArray new];
    [appSections enumerateObjectsUsingBlock:^(ATLApplicationSection* section, NSUInteger idx, BOOL *stop)
     {
        NSArray *ourArray = [[ATLApplicationListControllerBase alloc] createSpecifiersForApplicationSection:section];
		[specifiersForSection addObjectsFromArray:ourArray];
        // NSLog(@"[ASPrefs] specifiersForSection: %@", specifiersForSection);
    }];

	// NSArray *ret = [[[NSArray alloc] init] initWithArray:specifiersForSection];
    
    return specifiersForSection;
}


- (NSArray *)specifiers {
	if (!_specifiers) {
        [self getPreference];
        NSMutableArray *specifiers = [[NSMutableArray alloc] init];
        [specifiers addObject:({
            PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Enabled Apps" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
            specifier;
        })];
        
        NSArray *appSpecifiers = [self getSpecifiersForAppSection:SECTION_TYPE_USER];
        for(PSSpecifier *spec in appSpecifiers) {
            PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:[spec name] target:self set:@selector(setSwitch:forSpecifier:) get:@selector(getSwitch:) detail:nil cell:PSSwitchCell edit:nil];
            [specifier.properties setValue:[spec propertyForKey:@"applicationIdentifier"] forKey:@"displayIdentifier"];
            UIImage *icon = [spec propertyForKey:@"iconImage"];
            if (icon) [specifier setProperty:icon forKey:@"iconImage"];
            [specifiers addObject:specifier];
        }
        
        
        _specifiers = [specifiers copy];
	}

	return _specifiers;
}



-(void)setSwitch:(NSNumber *)value forSpecifier:(PSSpecifier *)specifier {
    prefs[[specifier propertyForKey:@"displayIdentifier"]] = [NSNumber numberWithBool:[value boolValue]];
    [[prefs copy] writeToFile:PREFERENCE_IDENTIFIER atomically:FALSE];
}
-(NSNumber *)getSwitch:(PSSpecifier *)specifier {
    return [prefs[[specifier propertyForKey:@"displayIdentifier"]] isEqual:@1] ? @1 : @0;
}

-(void)getPreference {
    if(![[NSFileManager defaultManager] fileExistsAtPath:PREFERENCE_IDENTIFIER]) prefs = [[NSMutableDictionary alloc] init];
    else prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PREFERENCE_IDENTIFIER];
}

@end
