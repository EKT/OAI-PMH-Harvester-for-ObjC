/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "Record.h"

@implementation Record

@synthesize recordMetadata, recordHeader;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)recordXMLElement{
    if (self = [super init]){
        CXMLElement *headerElement = nil;
        NSArray *headerArray = [recordXMLElement elementsForName:@"header"];
        if ([headerArray count]>0)
            headerElement = [headerArray objectAtIndex:0];
        CXMLElement *metadataElement = nil;
        NSArray *metadataArray = [recordXMLElement elementsForName:@"metadata"];
        if ([metadataArray count]>0)
            metadataElement = [metadataArray objectAtIndex:0];
        self.recordMetadata = [[RecordMetadata alloc] initWithXMLElement:metadataElement];
        self.recordHeader = [[RecordHeader alloc] initWithXMLElement:headerElement];
        
        self.asXML = recordXMLElement.XMLString;
    }
    return self;
}

@end
