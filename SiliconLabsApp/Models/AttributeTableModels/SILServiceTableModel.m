//
//  SILServiceTableModel.m
//  SiliconLabsApp
//
//  Created by Eric Peterson on 10/6/15.
//  Copyright © 2015 SiliconLabs. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "SILServiceTableModel.h"
#import "SILBluetoothModelManager.h"
#import "SILUUIDProvider.h"

@implementation SILServiceTableModel

@synthesize isExpanded;
@synthesize hideTopSeparator;

- (instancetype)initWithService:(CBService *)service {
    self = [super init];
    if (self) {
        self.service = service;
        self.characteristicModels = [NSArray new];
        self.bluetoothModel = [[SILBluetoothModelManager sharedManager] serviceModelForUUIDString:[self uuidString]];
    }
    return self;
}

- (NSString *)name {
    if (_bluetoothModel.name) {
        return _bluetoothModel.name;
    }
    NSString* predefinedName = [SILUUIDProvider predefinedNameForServiceOrCharacteristicUUID:[self uuidString]];
    return predefinedName ?: @"Unknown Service";
}

#pragma mark - SILGenericAttributeTableModel

- (BOOL)canExpand {
    return self.characteristicModels.count > 0;
}

- (void)toggleExpansionIfAllowed {
    self.isExpanded = !self.isExpanded;
}

- (NSString *)uuidString {
    return self.service.UUID.UUIDString;
}

@end
