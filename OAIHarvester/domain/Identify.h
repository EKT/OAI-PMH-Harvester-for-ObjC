/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

typedef enum
{
    NO_DELETION = 0,
	PERSISTENT_DELETION,
    TRANSIENT_DELETION,
    OTHER
    
} DELETIONS_STATUS;

@interface Identify : NSObject {
    NSString *repositoryName;
    NSString *baseURL;
    NSString *protocolVersion;
    NSString *earliestDatestamp;
    NSString *granularity;
    
    DELETIONS_STATUS deletionStatus;
    
    NSMutableArray *adminEmails;
    NSMutableArray *compressions;
    NSMutableArray *descriptions;
}

@property (nonatomic, retain) NSString *repositoryName;
@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) NSString *protocolVersion;
@property (nonatomic, retain) NSString *earliestDatestamp;
@property (nonatomic, retain) NSString *granularity;
@property (nonatomic, assign) DELETIONS_STATUS deletionStatus;
@property (nonatomic, retain) NSMutableArray *adminEmails;
@property (nonatomic, retain) NSMutableArray *compressions;
@property (nonatomic, retain) NSMutableArray *descriptions;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
