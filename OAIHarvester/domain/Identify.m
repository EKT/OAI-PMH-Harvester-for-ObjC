/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "Identify.h"

@implementation Identify 

@synthesize repositoryName, baseURL, protocolVersion, earliestDatestamp, granularity, deletionStatus, adminEmails, descriptions, compressions;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement{
    if (self = [super init]){
        
        self.repositoryName = [[[xmlElement elementsForLocalName:@"repositoryName" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.baseURL = [[[xmlElement elementsForLocalName:@"baseURL" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.protocolVersion = [[[xmlElement elementsForLocalName:@"protocolVersion" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.earliestDatestamp = [[[xmlElement elementsForLocalName:@"earliestDatestamp" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.granularity = [[[xmlElement elementsForLocalName:@"granularity" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        
        NSString *deletedRecord = [[[xmlElement elementsForLocalName:@"deletedRecord" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        if ([[deletedRecord lowercaseString] isEqualToString:@"no"]){
            self.deletionStatus = NO_DELETION;
        }
        else if ([[deletedRecord lowercaseString] isEqualToString:@"persistent"]){
            self.deletionStatus = PERSISTENT_DELETION;
        }
        else if ([[deletedRecord lowercaseString] isEqualToString:@"transient"]){
            self.deletionStatus = TRANSIENT_DELETION;
        }
        else {
            self.deletionStatus = NO_DELETION;
        }
        
        NSArray *emails = [xmlElement elementsForLocalName:@"adminEmail" URI:BASE_NAMESPACE];
        self.adminEmails = [[[NSMutableArray alloc] init] autorelease];
        for (CXMLElement *emailElement in emails){
            [self.adminEmails addObject:[emailElement stringValue]];
        }
        
        NSArray *compressionsArray = [xmlElement elementsForLocalName:@"compression" URI:BASE_NAMESPACE];
        self.compressions = [[[NSMutableArray alloc] init] autorelease];
        for (CXMLElement *compressionElement in compressionsArray){
            [self.compressions addObject:[compressionElement stringValue]];
        }
        
        NSArray *descriptionsArray = [xmlElement elementsForLocalName:@"description" URI:BASE_NAMESPACE];
        self.descriptions = [[[NSMutableArray alloc] init] autorelease];
        for (CXMLElement *descriptionElement in descriptionsArray){
            [self.descriptions addObject:[descriptionElement XMLString]];
        }
    }
    return self;
}

#pragma mark - Memory Management
- (void) dealloc {
    
    [repositoryName release];
    [baseURL release];
    [protocolVersion release];
    [earliestDatestamp release];
    [granularity release];
    
    [adminEmails release];
    [descriptions release];
    [compressions release];
    
    [super dealloc];
}
    

@end
