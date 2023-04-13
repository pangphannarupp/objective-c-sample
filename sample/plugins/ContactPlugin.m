//
//  ContactPlugin.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "ContactPlugin.h"
#import "Util.h"

@implementation ContactPlugin

CNContactStore *store;

- (void)execute:(NSDictionary *)param {
    NSLog(@"ContactPlugin => param => %@", param);
    
    self.util = [[Util alloc] init];
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"get"]) {
        [self get];
    } else if([type isEqual:@"open"]) {
        [self open];
    } else {
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-2",
            @"errorMessage": @"No implementation",
        }];
    }
}

-(void)open {
    CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
    picker.delegate = self;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

-(void)get {
    store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // Access granted, continue with fetching contacts
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getContactList];
            });
        } else {
            // Access denied, handle error
            dispatch_async(dispatch_get_main_queue(), ^{
                Util *util = [[Util alloc] init];
                [util showDialog:self.viewController message:@{
                    @"result": @NO,
                    @"errorCode": [NSString stringWithFormat:@"%ld", (long)error.code],
                    @"errorMessage": error.localizedDescription,
                }];
            });
        }
    }];
}

-(void)getContactList {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]];
        NSError *error = nil;
        NSMutableArray *contacts = [NSMutableArray array];
        [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contacts addObject:contact];
        }];
        if (error) {
            // Handle error
            NSLog(@"error => %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                Util *util = [[Util alloc] init];
                [util showDialog:self.viewController message:@{
                    @"result": @NO,
                    @"errorCode": [NSString stringWithFormat:@"%ld", (long)error.code],
                    @"errorMessage": error.localizedDescription,
                }];
            });
        } else {
            NSMutableArray *response = [NSMutableArray array];
            // Do something with the contacts array
            //NSLog(@"contacts => %@", contacts);
            for (int i = 0; i < [contacts count]; i++) {
                CNContact *contact = [contacts objectAtIndex:i];
                NSString *givenName = contact.givenName;
                NSString *familyName = contact.familyName;
                NSString *phoneNumber = @"";
                for (CNLabeledValue<CNPhoneNumber*>* phone in contact.phoneNumbers) {
                    if ([phone.label isEqualToString:CNLabelPhoneNumberMobile] || [phone.label isEqualToString:CNLabelPhoneNumberiPhone]) {
                        // Found a mobile phone number or iPhone number
                        CNPhoneNumber *phoneNumberObj = phone.value;
                        phoneNumber = phoneNumberObj.stringValue;
                        break;
                    }
                }
                //NSLog(@"Item %d: %@, %@", i, givenName, familyName);
                [response addObject:@{
                    @"given_name": givenName,
                    @"family_name": familyName,
                    @"phone_number": phoneNumber,
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                Util *util = [[Util alloc] init];
                [util showDialog:self.viewController message: @{
                    @"result": @YES,
                    @"contacts": response,
                }];
            });
        }
    });
}

#pragma mark - CNContactPickerDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    // Handle the selected contact
    //NSLog(@"Selected contact: %@", contact);
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    NSString *givenName = [contact givenName];
    NSString *familyName = [contact familyName];
    NSString *phoneNumber = @"";
    for (CNLabeledValue<CNPhoneNumber*>* phone in contact.phoneNumbers) {
        if ([phone.label isEqualToString:CNLabelPhoneNumberMobile] || [phone.label isEqualToString:CNLabelPhoneNumberiPhone]) {
            // Found a mobile phone number or iPhone number
            CNPhoneNumber *phoneNumberObj = phone.value;
            phoneNumber = phoneNumberObj.stringValue;
            break;
        }
    }
    
    [self.util showDialog:self.viewController message:@{
        @"result": @YES,
        @"given_name": givenName,
        @"family_name": familyName,
        @"phone_number": phoneNumber,
    }];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    // Handle cancellation
    //NSLog(@"Contact picker cancelled");
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    [self.util showDialog:self.viewController message:@{
        @"result": @NO,
        @"errorCode": @"-4",
        @"errorMessage": @"User cancels",
    }];
}

@end
