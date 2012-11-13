/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "Record.h"
#import "Identify.h"
#import "MetadataFormat.h"
#import "Set.h"
#import "ResumptionToken.h"
#import "Identifier.h"
#import "HarvesterError.h"

#define BASE_NAMESPACE @"http://www.openarchives.org/OAI/2.0/"

@interface OAIHarvester : NSObject {
    
    NSString *baseURL;
    NSString *setSpec;
    NSString *metadataPrefix;
    
    ResumptionToken *resumptionToken;
    ResumptionToken *identifiersResumptionToken;
    
    Identify *identify;
    NSArray *metadataFormats;
    NSArray *sets;
    NSArray *records;
    NSArray *identifiers;
    
}

@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) NSString *setSpec;
@property (nonatomic, retain) NSString *metadataPrefix;

@property (nonatomic, retain) ResumptionToken *resumptionToken;
@property (nonatomic, retain) ResumptionToken *identifiersResumptionToken;

@property (nonatomic, retain) Identify *identify;
@property (nonatomic, retain) NSArray *metadataFormats;
@property (nonatomic, retain) NSArray *sets;
@property (nonatomic, retain) NSArray *records;
@property (nonatomic, retain) NSArray *identifiers;

#pragma mark - Initialization Methods
- (id) initWithBaseURL:(NSString *)theBaseURL;

#pragma mark - Verbs
#pragma mark Identify
- (Identify *)identifyWithError:(NSError **)error;
#pragma mark ListMetadataFormats
- (NSArray *)listMetadataFormatsWithError:(NSError **)error;
- (NSArray *)listMetadataFormatsForItem:(NSString *)itemIdentifier error:(NSError **)error;
#pragma mark ListSets
- (NSArray *)listSetsWithError:(NSError **)error;
#pragma mark ListRecords
- (NSArray *)listAllRecordsWithError:(NSError **)error;
- (NSMutableArray *)listRecordsWithResumptionToken:(NSString *)resumptionTkn error:(NSError **)error;
- (BOOL) hasNextRecords;
- (NSArray *) getNextRecordsWithError:(NSError **)error;
#pragma mark ListIdentifiers
- (NSArray *)listAllIdentifiersWithError:(NSError **)error;
- (NSMutableArray *)listIdentifiersWithResumptionToken:(NSString *)resumptionTkn error:(NSError **)error;
- (BOOL) hasNextIdentifiers;
- (NSArray *) getNextIdentifiersWithError:(NSError **)error;
#pragma mark GetRecord
- (Record *)getRecordWithIdentifier:(NSString *)identifier error:(NSError **)error;

@end
