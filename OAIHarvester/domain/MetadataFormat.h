/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

@interface MetadataFormat : NSObject

@property (nonatomic, strong) NSString *schema;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *namespce;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
