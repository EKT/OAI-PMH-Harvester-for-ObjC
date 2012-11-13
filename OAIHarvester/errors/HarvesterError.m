/*********************************************************************************************
 
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
 
 To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
 
**********************************************************************************************/

#import "HarvesterError.h"

@implementation HarvesterError

- (NSString *) localizedDescription{

    return NSLocalizedString(self.domain, @"");

}

@end
