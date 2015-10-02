/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

@interface Set : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) NSString *fullSpec;
@property (nonatomic, assign) BOOL visible;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
