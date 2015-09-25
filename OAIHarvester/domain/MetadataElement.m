/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "MetadataElement.h"
#import "OAIHarvester.h"

@implementation MetadataElement

@synthesize name, value, namespce, prefix;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)recordXMLElement{
    if (self = [super init]){
        self.name = recordXMLElement.localName;
        self.value = recordXMLElement.stringValue;
        self.namespce = recordXMLElement.URI;
        self.prefix = recordXMLElement.prefix;
    }
    return self;
}

@end
