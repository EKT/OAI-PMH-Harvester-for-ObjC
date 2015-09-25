/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "MetadataFormat.h"

@implementation MetadataFormat

@synthesize schema, prefix, namespce;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement{
    if (self = [super init]){
        
        self.prefix = [[[xmlElement elementsForLocalName:@"metadataPrefix" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.schema = [[[xmlElement elementsForLocalName:@"schema" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.namespce = [[[xmlElement elementsForLocalName:@"metadataNamespace" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        
    }
    return self;
}

@end
