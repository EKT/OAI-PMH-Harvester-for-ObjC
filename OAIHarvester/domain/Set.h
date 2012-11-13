/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import <Foundation/Foundation.h>

@interface Set : NSObject {
    
    NSString *name;
    NSString *spec;
    
    NSString *fullSpec;
    BOOL visible;
    
    NSMutableArray *children;
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *spec;
@property (nonatomic, retain) NSMutableArray *children;
@property (nonatomic, retain) NSString *fullSpec;
@property (nonatomic, assign) BOOL visible;

#pragma mark Initialization Methods
- (id) initWithXMLElement:(CXMLElement *)xmlElement;

@end
