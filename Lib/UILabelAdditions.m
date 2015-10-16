//
//  UILabelAdditions.m
//  KSLibrary
//
//  Created by jerry gao on 12-11-20.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import "UILabelAdditions.h"
#import "UIViewAdditions.h"
#import "KSConfiguration.h"

@implementation UILabel (KS)

+ (instancetype)createLabelWithFrame:(CGRect)frame
                                text:(NSString*)text
                           textColor:(UIColor*)textColor
                                font:(UIFont*)font
                           alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text?text:@"";
    label.textAlignment = alignment?alignment:NSTextAlignmentLeft;
    label.font = font?font:SYSFont(14);
    label.textColor = textColor;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    return label;
}


- (CGFloat)attributeTextHeight
{
    if (SYSTEM_VERSION>=7.0)
    {
        
        
        return [self.attributedText boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
    }
    return 100;
}

- (CGFloat)attributeTextWidth
{

        
    return [self.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;

}

-(CGFloat)textHeight
{
    if (SYSTEM_VERSION>=7.0)
    {

        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];

        return [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size.height;

    }
NO_WARN_BEGIN
NO_WARN
    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height;
NO_WARN_END

}
-(CGFloat)textWidth
{
    if (SYSTEM_VERSION>=7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];

        return [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size.width;

    }


    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.height) lineBreakMode:self.lineBreakMode].width;
#pragma clang diagnostic pop
}

- (void)textHeightWithSetTextLindSpace:(CGFloat)space
{
    //    if (SYSTEM_VERSION<6.0)
    //    {
    //
    //        return ;
    //    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    paragraphStyle.alignment = self.textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attributedString;
    
    //    [self sizeToFit];
}


@end

