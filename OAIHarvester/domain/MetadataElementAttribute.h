//
//  MetadataElementAttribute.h
//  Pods
//
//  Created by Kostas I. Stamatis on 9/28/15.
//
//

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

@interface MetadataElementAttribute : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

#pragma mark - Initialization Methods
- (id) initWithXMLNode:(CXMLNode *)recordXMLNode;

@end
