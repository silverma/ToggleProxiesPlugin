//
//  ToggleProxiesPlugin.m
//  ToggleProxiesPlugin
//
//  Created by Marc Silverman on 12/2/6.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToggleProxiesPlugin.h"
#import <Adium/AIAccountControllerProtocol.h>
//#import <Adium/AIAccountMenuAccessPlugin.h>
#import <Adium/AIMenuControllerProtocol.h>
#import <Adium/AIAccount.h>
#import <AIUtilities/AIStringAdditions.h>
#import <AIUtilities/AIMenuAdditions.h>

@interface ToggleProxiesPlugin()

@end

@implementation ToggleProxiesPlugin

- (void)installPlugin
{
	NSMenuItem *rootMenu = [[NSMenuItem alloc] initWithTitle:(@"Toggle Proxies")
												target:nil
												action:nil
										 keyEquivalent:@""];

	NSMenu *subMenu = [[NSMenu alloc] init];
	NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:(@"Turn All Proxies On")
											target:self
											action:@selector(turnProxiesOn:)
											 keyEquivalent:@"z"];
	[menuItem setKeyEquivalentModifierMask:(NSCommandKeyMask | NSAlternateKeyMask)];
	[subMenu addItem:menuItem];

	//	[menuItem_toggleUserlist setKeyEquivalentModifierMask:(NSCommandKeyMask | NSAlternateKeyMask)];
	menuItem = [[NSMenuItem alloc] initWithTitle:(@"Turn All Proxies Off")
											target:self
											action:@selector(turnProxiesOff:)
											 keyEquivalent:@"x"];
	[menuItem setKeyEquivalentModifierMask:(NSCommandKeyMask | NSAlternateKeyMask)];
	[subMenu addItem:menuItem];
	[adium.menuController addMenuItem:rootMenu toLocation:LOC_File_Additions];
	[rootMenu setSubmenu:subMenu];
	[menuItem release];
	[subMenu release];
	[rootMenu release];
}

/*!
 * @brief Uninstall Plugin
 */
- (void)uninstallPlugin
{

}

/*!
 * @brief Turns all proxies off
 */
- (void)turnProxiesOff:(NSMenuItem *)menuItem
{
	for (AIAccount *account in adium.accountController.accounts) {
	  if ([[account preferenceForKey:KEY_ACCOUNT_PROXY_ENABLED group:GROUP_ACCOUNT_STATUS] boolValue]) {
		  	[account setPreference:[NSNumber numberWithInteger:NO]
					forKey:KEY_ACCOUNT_PROXY_ENABLED group:GROUP_ACCOUNT_STATUS];
	  if (account.enabled)
			[account setShouldBeOnline:YES];
	  }
	}
}

/*!
 * @brief Turns all proxies on
 */
- (void)turnProxiesOn:(NSMenuItem *)menuItem
{
	for (AIAccount *account in adium.accountController.accounts) {
	  if (![[account preferenceForKey:KEY_ACCOUNT_PROXY_ENABLED group:GROUP_ACCOUNT_STATUS] boolValue]) {
		  	[account setPreference:[NSNumber numberWithInteger:YES]
					forKey:KEY_ACCOUNT_PROXY_ENABLED group:GROUP_ACCOUNT_STATUS];
	  if (account.enabled)
			[account setShouldBeOnline:YES];
	  }
	}
}

@end

