/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>
#import "RecordHeader.h"
#import "RecordMetadata.h"

@interface Record : NSObject 

@property (nonatomic, strong) NSString *asXML;

@property (nonatomic, strong) RecordHeader *recordHeader;
@property (nonatomic, strong) RecordMetadata *recordMetadata;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)recordXMLElement;

@end
