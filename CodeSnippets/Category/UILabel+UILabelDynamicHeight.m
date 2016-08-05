//
//  UILabel+UILabelDynamicHeight.m
//  SellCar
//
//  Created by GeekRRK on 16/8/5.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "UILabel+UILabelDynamicHeight.h"
@implementation UILabel (UILabelDynamicHeight)


#pragma mark - Calculate the size,bounds,frame of the Multi line Label
/*====================================================================*/

/* Calculate the size,bounds,frame of the Multi line Label */

/*====================================================================*/
/**
 *  Returns the size of the Label
 *
 *  @param aLabel To be used to calculte the height
 *
 *  @return size of the Label
 */
-(CGSize)sizeOfMultiLineLabel{
    
    //Label text
    NSString *aLabelTextString = [self text];
    
    //Label font
    UIFont *aLabelFont = [self font];
    
    //Width of the Label
    CGFloat aLabelSizeWidth = self.frame.size.width;
    
    //Return the calculated size of the Label
    return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size;
    
}
@end