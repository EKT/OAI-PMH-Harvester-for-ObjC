/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

@interface MetadataFormat : NSObject {
    
    NSString *schema;
    NSString *prefix;
    NSString *namespce;
    
}

@property (nonatomic, retain) NSString *schema;
@property (nonatomic, retain) NSString *prefix;
@property (nonatomic, retain) NSString *namespce;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
