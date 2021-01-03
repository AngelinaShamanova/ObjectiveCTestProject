//
//  NSMutableAttributedString+Color.h
//  ObjectiveCTestProject
//
//  Created by Angelina on 04.01.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Color)
-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color;
@end
