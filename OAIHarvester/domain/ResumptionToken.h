/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

#import "OAIHarvester.h"

@interface ResumptionToken : NSObject

@property (nonatomic, strong) NSString *expireDate;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) int completeListSize;
@property (nonatomic, assign) int cursor;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
