/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "ResumptionToken.h"

@implementation ResumptionToken

@synthesize token, expireDate, completeListSize, cursor;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement{
    if (self = [super init]){
        
        self.token = [xmlElement stringValue];
        self.expireDate = [[xmlElement attributeForName:@"expirationDate"] stringValue];
        self.cursor = [[[xmlElement attributeForName:@"cursor"] stringValue] intValue];
        self.completeListSize = [[[xmlElement attributeForName:@"completeListSize"] stringValue] intValue];
     
        NSLog(@"");
    }
    return self;
}

#pragma mark - Memory Management
- (void) dealloc {
    
    [token release];
    [expireDate release];
    
    [super dealloc];
}
@end
