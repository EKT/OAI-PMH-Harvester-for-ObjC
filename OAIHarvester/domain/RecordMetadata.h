/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>
#import "MetadataElement.h"

@interface RecordMetadata : NSObject{
    
    NSString *namespce;
    NSString *schemaLocation;
    NSMutableArray *metadataElements;
    
}

@property (nonatomic, retain) NSString *namespce;
@property (nonatomic, retain) NSString *schemaLocation;
@property (nonatomic, retain) NSMutableArray *metadataElements;

#pragma mark - Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)metadataXMLElement;

@end
