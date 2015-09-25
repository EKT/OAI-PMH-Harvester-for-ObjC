/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "Set.h"

@implementation Set 

@synthesize name, children, spec, fullSpec, visible;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement{
    if (self = [super init]){
        
        self.fullSpec = [[[xmlElement elementsForLocalName:@"setSpec" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        self.name = [[[xmlElement elementsForLocalName:@"setName" URI:BASE_NAMESPACE] objectAtIndex:0] stringValue];
        
        NSRange semiColon = [self.fullSpec rangeOfString:@":" options:NSBackwardsSearch];
        
        if (semiColon.length>0)
            self.spec = [self.fullSpec substringFromIndex:(semiColon.location+1)];
        else
            self.spec = [NSString stringWithString:self.fullSpec];
        
    }
    return self;
}

@end
