/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "RecordHeader.h"

@implementation RecordHeader

@synthesize identifier, datestamp, setSpecs, status;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)headerXMLElement{
    if (self = [super init]){

        //Identifier
        NSArray *identifierNodes = [headerXMLElement  elementsForLocalName:@"identifier" URI:BASE_NAMESPACE];
        if ([identifierNodes count]>0)
            self.identifier = [[identifierNodes objectAtIndex:0] stringValue];
        else
            self.identifier = nil;
        
        //Status
        NSString *astatus = [[headerXMLElement attributeForName:@"status"] stringValue];
        if (astatus && [astatus isEqualToString:@"deleted"])
            self.status = STATUS_DELETED;
        else
            self.status = NO_STATUS;
        
        //setSpecs
        NSArray *setNodes = [headerXMLElement  elementsForLocalName:@"setSpec" URI:BASE_NAMESPACE];
        if ([setNodes count]>0) {
            self.setSpecs = [[[NSMutableArray alloc] initWithCapacity:[setNodes count]] autorelease];
            for (CXMLNode *node in setNodes){
                [self.setSpecs addObject:[node stringValue]];
            }
        }
        else {
            self.setSpecs = nil;
        }
        
        //datestamp
        NSArray *dateNodes = [headerXMLElement  elementsForLocalName:@"datestamp" URI:BASE_NAMESPACE];
        if ([dateNodes count]>0) {
            self.datestamp = [[dateNodes objectAtIndex:0] stringValue];
        }
        else {
            self.datestamp = nil;
        }
    }
    return self;
}

#pragma mark - Memory Management
- (void) dealloc {
    
    [identifier release];
    [datestamp release];
    [setSpecs release];
    
    [super dealloc];
}

@end
