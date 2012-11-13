/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

typedef enum
{
    NO_STATUS,
	STATUS_DELETED
} RECORD_STATUS;

@interface RecordHeader : NSObject {
    
    NSString *identifier;
    NSString *datestamp;
    NSMutableArray *setSpecs;
    
    RECORD_STATUS status;
    
}

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *datestamp;
@property (nonatomic, retain) NSMutableArray *setSpecs;
@property (nonatomic, assign) RECORD_STATUS status;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)headerXMLElement;

@end
