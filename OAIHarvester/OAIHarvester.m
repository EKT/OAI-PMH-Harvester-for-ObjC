/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "OAIHarvester.h"

#import "Record.h"
#import "Identify.h"
#import "MetadataFormat.h"
#import "Set.h"
#import "ResumptionToken.h"
#import "Identifier.h"
#import "HarvesterError.h"

@interface OAIHarvester ()

- (void) checkResponseForError:(CXMLElement *)oaiPmhElement withError:(NSError **)error;

@end


@implementation OAIHarvester

@synthesize metadataPrefix, setSpec, baseURL, resumptionToken, identifiersResumptionToken, identifiers;
@synthesize identify, metadataFormats, sets, records;

#pragma mark - Initialization Methods
- (id) init{
    if (self = [super init]){
        
        self.resumptionToken = nil;
        self.setSpec = nil;
        self.identifiersResumptionToken = nil;
        self.identify = nil;
        self.metadataFormats = nil;
        self.sets = nil;
        self.identifiers = nil;
    }
    return self;
}

- (id) initWithBaseURL:(NSString *)theBaseURL{
    if (self = [super init]){
        
        self.resumptionToken = nil;
        self.setSpec = nil;
        self.identifiersResumptionToken = nil;
        self.identify = nil;
        self.metadataFormats = nil;
        self.sets = nil;
        self.identifiers = nil;
        
        self.baseURL = theBaseURL;
        
    }
    return self;
}

#pragma mark - Setters
- (void) setBaseURL:(NSString *)theBaseURL {
    baseURL = theBaseURL;
    NSError *error = nil;
    [self identifyWithError:&error];
    [self listMetadataFormatsWithError:&error];
    [self listSetsWithError:&error];
}

#pragma mark - Error Checking
- (void) checkResponseForError:(CXMLElement *)oaiPmhElement withError:(NSError **)error{
    NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
    
    NSError *err = nil;
    NSArray *errors = [oaiPmhElement nodesForXPath:@"//oai-pmh:error" namespaceMappings:namespaceMappings error:&err];
    if (!err && [errors count]>0){
        CXMLElement *errorElement = [errors objectAtIndex:0];
        NSString *code = [[errorElement attributeForName:@"code"] stringValue];
        HarvesterError *harvesterError = [[HarvesterError alloc] initWithDomain:[NSString stringWithFormat:@"harvester.oaipmh.error.%@", code] code:0 userInfo:nil];
        *error = harvesterError;
    }
    else {
        *error = err;
    }
}

#pragma mark - Verbs
#pragma mark ListRecords
- (BOOL) hasNextRecords {
    if (self.resumptionToken){
        return YES;
    }
    
    return NO;
}

- (NSArray *) getNextRecordsWithError:(NSError **)error {
    if (self.resumptionToken){
        return [self listRecordsWithResumptionToken:self.resumptionToken.token error:error];
    }
    
    return [self listRecordsWithResumptionToken:nil error:error];
}

- (NSArray *)listAllRecordsWithError:(NSError **)error{
    NSMutableArray *array = [self listRecordsWithResumptionToken:nil error:error];
    
    while (self.resumptionToken){
        NSArray *newResults = [self listRecordsWithResumptionToken:self.resumptionToken.token error:error];
        [array addObjectsFromArray:newResults];
    }
    
    return array;
}

- (NSMutableArray *)listRecordsWithResumptionToken:(NSString *)resumptionTkn error:(NSError **)error{
    
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    if (!metadataPrefix){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nometadataprefix" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url;
    
    if (!resumptionTkn){
        if (setSpec) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListRecords&metadataPrefix=%@&set=%@",baseURL, metadataPrefix, setSpec]];
        }
        else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListRecords&metadataPrefix=%@",baseURL, metadataPrefix]];
        }
    }
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListRecords&resumptionToken=%@",baseURL, resumptionTkn]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            
            NSArray *resumptionTokens = [oaiPmhElement nodesForXPath:@"//oai-pmh:resumptionToken" namespaceMappings:namespaceMappings error:error];
            if ([resumptionTokens count] > 0){
                NSString *token = [[resumptionTokens objectAtIndex:0] stringValue];
                if (!token || [token isEqualToString:@""]){
                    self.resumptionToken = nil;
                }
                else {
                    self.resumptionToken = [[ResumptionToken alloc] initWithXMLElement:[resumptionTokens objectAtIndex:0]];
                    NSLog(@"Token: %@", self.resumptionToken.token);
                }
            }
            else {
                self.resumptionToken = nil;
            }
            
            NSArray *records2 = [oaiPmhElement nodesForXPath:@"//oai-pmh:record" namespaceMappings:namespaceMappings error:error];
            NSMutableArray *results = [[NSMutableArray alloc] init];
            for (CXMLElement *recordNode in records2){
                Record *record = [[Record alloc] initWithXMLElement:recordNode];
                [results addObject:record];
            }
            
            self.records = results;
            
            return results;
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}

#pragma mark ListIdentifiers
- (BOOL) hasNextIdentifiers {
    if (self.identifiersResumptionToken){
        return YES;
    }
    
    return NO;
}

- (NSArray *) getNextIdentifiersWithError:(NSError **)error {
    if (self.identifiersResumptionToken){
        return [self listIdentifiersWithResumptionToken:self.identifiersResumptionToken.token error:error];
    }
    
    return [self listIdentifiersWithResumptionToken:nil error:error];
}

- (NSArray *)listAllIdentifiersWithError:(NSError **)error{
    NSMutableArray *array = [self listIdentifiersWithResumptionToken:nil error:error];
    
    while (self.identifiersResumptionToken){
        NSArray *newResults = [self listIdentifiersWithResumptionToken:self.identifiersResumptionToken.token error:error];
        [array addObjectsFromArray:newResults];
    }
    
    return array;
    
}

- (NSMutableArray *)listIdentifiersWithResumptionToken:(NSString *)resumptionTkn error:(NSError **)error{
    
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    if (!metadataPrefix){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nometadataprefix" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url;
    
    if (!resumptionTkn){
        if (setSpec) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListIdentifiers&metadataPrefix=%@&setSpec=%@",baseURL, metadataPrefix, setSpec]];
        }
        else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListIdentifiers&metadataPrefix=%@",baseURL, metadataPrefix]];
        }
    }
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListIdentifiers&resumptionToken=%@",baseURL, resumptionTkn]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            
            NSArray *resumptionTokens = [oaiPmhElement nodesForXPath:@"//oai-pmh:resumptionToken" namespaceMappings:namespaceMappings error:error];
            if ([resumptionTokens count] > 0){
                NSString *token = [[resumptionTokens objectAtIndex:0] stringValue];
                if (!token || [token isEqualToString:@""]){
                    self.identifiersResumptionToken = nil;
                }
                else {
                    self.identifiersResumptionToken = [[ResumptionToken alloc] initWithXMLElement:[resumptionTokens objectAtIndex:0]];
                    NSLog(@"Indentifiers Token: %@", self.identifiersResumptionToken.token);
                }
            }
            else {
                self.identifiersResumptionToken = nil;
            }
            
            NSArray *identifiers2 = [oaiPmhElement nodesForXPath:@"//oai-pmh:header" namespaceMappings:namespaceMappings error:error];
            NSMutableArray *results = [[NSMutableArray alloc] init];
            for (CXMLElement *recordNode in identifiers2){
                Identifier *identifier = [[Identifier alloc] initWithXMLElement:recordNode];
                [results addObject:identifier];
            }
            
            self.identifiers = results;
            
            return results;
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}


#pragma mark Identify
- (Identify *)identifyWithError:(NSError **)error{
    
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=Identify",baseURL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            NSArray *indentifyArray = [oaiPmhElement nodesForXPath:@"//oai-pmh:Identify" namespaceMappings:namespaceMappings error:error];
            
            CXMLElement *identifyNode = [indentifyArray objectAtIndex:0];
            
            Identify *identify2 = [[Identify alloc] initWithXMLElement:identifyNode];
            
            if (self.identify){
                self.identify = nil;
            }
            self.identify = identify2;
            
            return identify2;
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}

#pragma mark ListMetadataFormats
- (NSArray *)listMetadataFormatsWithError:(NSError **)error {
    
    return [self listMetadataFormatsForItem:nil error:error];
}

- (NSArray *)listMetadataFormatsForItem:(NSString *)itemIdentifier error:(NSError **)error {
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url;
    
    if (!itemIdentifier)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListMetadataFormats",baseURL]];
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListMetadataFormats&identifier=%@",baseURL, itemIdentifier]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            NSArray *formatArray = [oaiPmhElement nodesForXPath:@"//oai-pmh:metadataFormat" namespaceMappings:namespaceMappings error:error];
            
            NSMutableArray *results = [[NSMutableArray alloc] init];
            for (CXMLElement *formatElement in formatArray){
                MetadataFormat *format = [[MetadataFormat alloc] initWithXMLElement:formatElement];
                [results addObject:format];
            }
            
            if (!itemIdentifier){
                if (self.metadataFormats){
                    self.metadataFormats = nil;
                }
                self.metadataFormats = results;
            }
            
            return results;
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}

#pragma mark ListSets
- (NSArray *)listSetsWithError:(NSError **)error {
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url;
    
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListSets",baseURL]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            NSArray *formatArray = [oaiPmhElement nodesForXPath:@"//oai-pmh:set" namespaceMappings:namespaceMappings error:error];
            
            NSMutableArray *allSets = [[NSMutableArray alloc] init];
            for (CXMLElement *setElement in formatArray){
                Set *set = [[Set alloc] initWithXMLElement:setElement];
                [allSets addObject:set];
            }
            
            if (self.sets){
                self.sets = nil;
            }
            self.sets = allSets;
            
            return allSets;
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}

#pragma mark GetRecord
- (Record *)getRecordWithIdentifier:(NSString *)identifier error:(NSError **)error{
    
    if (!baseURL){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nobaseurl" code:0 userInfo:nil];
        return nil;
    }
    
    if (!metadataPrefix){
        *error = [HarvesterError errorWithDomain:@"harvester.client.error.nometadataprefix" code:0 userInfo:nil];
        return nil;
    }
    
    NSURL *url;
    
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?verb=ListRecords&metadataPrefix=%@",baseURL, metadataPrefix]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response;
    
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err){
        CXMLDocument *document = [[CXMLDocument alloc] initWithData:responseData options:0 error:&err];
        if (!err){
            CXMLElement *oaiPmhElement = [document rootElement];
            
            [self checkResponseForError:oaiPmhElement withError:&err];
            if (err){
                *error = err;
                return nil;
            }
            
            NSDictionary *namespaceMappings = [NSDictionary dictionaryWithObject:BASE_NAMESPACE forKey:@"oai-pmh"];
            
            NSArray *records2 = [oaiPmhElement nodesForXPath:@"//oai-pmh:record" namespaceMappings:namespaceMappings error:error];
            
            for (CXMLElement *recordNode in records2){
                Record *record = [[Record alloc] initWithXMLElement:recordNode];
                return record;
            }
        }
        *error = err;
        return nil;
    }
    *error = err;
    return nil;
}

@end
