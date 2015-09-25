/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "Identifier.h"

@implementation Identifier

@synthesize identifier, datestamp;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement{
    if (self = [super init]){
        
        self.identifier = [[[xmlElement elementsForLocalName:@"identifier" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.datestamp = [[[xmlElement elementsForLocalName:@"datestamp" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        
    }
    return self;
}

@end
