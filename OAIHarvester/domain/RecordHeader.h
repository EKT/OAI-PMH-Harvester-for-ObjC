/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

typedef enum
{
    NO_STATUS,
	STATUS_DELETED
} RECORD_STATUS;

@interface RecordHeader : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *datestamp;
@property (nonatomic, strong) NSMutableArray *setSpecs;
@property (nonatomic, assign) RECORD_STATUS status;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)headerXMLElement;

@end
