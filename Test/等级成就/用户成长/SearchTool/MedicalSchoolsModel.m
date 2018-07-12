//
//  MedicalSchoolsModel.m
//  Test
//
//  Created by wlq on 2018/6/27.
//  Copyright © 2018年 wlq. All rights reserved.
//

#import "MedicalSchoolsModel.h"

@implementation MedicalSchoolsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.schoolId = [dict objectForKey:@"MediID"];
        self.schoolName = [dict objectForKey:@"HospitalName"];
        self.schoolPY = [self firstCharactor:self.schoolName];
    }
    return self;
}

- (NSString *)firstCharactor:(NSString *)aString{
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *pinYin = [str capitalizedString];
    
    NSString *firatCharactors = [NSMutableString string];
    for (int i = 0; i < pinYin.length; i++) {
        if ([pinYin characterAtIndex:i] >= 'A' && [pinYin characterAtIndex:i] <= 'Z') {
            firatCharactors = [firatCharactors stringByAppendingString:[NSString stringWithFormat:@"%C",[pinYin characterAtIndex:i]]];
        }
    }
    return firatCharactors;
}

@end
