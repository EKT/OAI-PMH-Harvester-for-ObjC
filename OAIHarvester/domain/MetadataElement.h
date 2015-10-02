/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

@interface MetadataElement : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *namespce;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSArray *attributes;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)recordXMLElement;

@end
