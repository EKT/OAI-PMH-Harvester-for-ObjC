/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

typedef enum
{
    NO_DELETION = 0,
	PERSISTENT_DELETION,
    TRANSIENT_DELETION,
    OTHER
    
} DELETIONS_STATUS;

@interface Identify : NSObject

@property (nonatomic, strong) NSString *repositoryName;
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *protocolVersion;
@property (nonatomic, strong) NSString *earliestDatestamp;
@property (nonatomic, strong) NSString *granularity;
@property (nonatomic, assign) DELETIONS_STATUS deletionStatus;
@property (nonatomic, strong) NSMutableArray *adminEmails;
@property (nonatomic, strong) NSMutableArray *compressions;
@property (nonatomic, strong) NSMutableArray *descriptions;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
