//
//  ContactPlugin.h
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "Plugin.h"


@interface ContactPlugin : Plugin <CNContactPickerDelegate>

@end
