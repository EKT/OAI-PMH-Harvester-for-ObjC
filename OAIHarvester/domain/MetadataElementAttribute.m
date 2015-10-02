//
//  MetadataElementAttribute.m
//  Pods
//
//  Created by Kostas I. Stamatis on 9/28/15.
//
//

#import "MetadataElementAttribute.h"

@implementation MetadataElementAttribute

#pragma mark - Initialization Methods
- (id) initWithXMLNode:(CXMLNode *)recordXMLNode{
    if (self = [super init]){
        self.name = recordXMLNode.localName;
        self.value = recordXMLNode.stringValue;
    }
    return self;
}

@end
