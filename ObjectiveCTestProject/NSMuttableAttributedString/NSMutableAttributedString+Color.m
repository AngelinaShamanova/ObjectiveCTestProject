//
//  NSMutableAttributedString+Color.m
//  ObjectiveCTestProject
//
//  Created by Angelina on 04.01.2021.
//

#import "NSMutableAttributedString+Color.h"


@implementation NSMutableAttributedString (Color)

-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color
{
    NSRange range = [self.mutableString rangeOfString:textToFind options:NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
@end
