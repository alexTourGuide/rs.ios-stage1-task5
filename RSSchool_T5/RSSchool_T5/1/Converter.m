#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    
    NSMutableDictionary *mutDict = [NSMutableDictionary new];
    NSNumber *allMaxDigit = [NSNumber new];
    NSNumber *numberDigit = [NSNumber new];
    NSNumber *numberCodeDigit = [NSNumber new];
    NSMutableString *initialStringNumber = [NSMutableString stringWithString:string];
    NSDictionary *countries = @{
        @"375": @[@"BY", @12, @9, @3],
        @"7": @[@"RU", @11, @10, @1],
        @"77": @[@"KZ", @11, @10, @1],
        @"373": @[@"MD", @11, @8, @3],
        @"374": @[@"AM", @11, @8, @3],
        @"380": @[@"UA", @12, @9, @3],
        @"992": @[@"TJ", @12, @9, @3],
        @"993": @[@"TM", @11, @8, @3],
        @"994": @[@"AZ", @12, @9, @3],
        @"996": @[@"KG", @12, @9, @3],
        @"998": @[@"UZ", @12, @9, @3]
    };
    
    NSDictionary *countries2 = @{
        @"BY": @"375",
        @"RU": @"7",
        @"KZ": @"7",
        @"MD": @"373",
        @"AM": @"374",
        @"UA": @"380",
        @"TJ": @"992",
        @"TM": @"993",
        @"AZ": @"994",
        @"KG": @"996",
        @"UZ": @"998"
    };
 
    if ([[initialStringNumber substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"]) {
        [initialStringNumber deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    if (string.length > 0) {
        if ([[initialStringNumber substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"7"]) {
            if (string.length > 1) {
                if ([[initialStringNumber substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"77"]) {
                    [mutDict setValue:@"KZ" forKey:@"KeyCountry"];
                    allMaxDigit = [countries objectForKey:@"77"][1];
                    numberDigit = [countries objectForKey:@"77"][2];
                    numberCodeDigit = [countries objectForKey:@"77"][3];
                } else {
                    [mutDict setValue:@"RU" forKey:@"KeyCountry"];
                    allMaxDigit = [countries objectForKey:@"7"][1];
                    numberDigit = [countries objectForKey:@"7"][2];
                    numberCodeDigit = [countries objectForKey:@"7"][3];
                }
            } else {
                return @{KeyPhoneNumber: @"+7",
                         KeyCountry: @"RU"};
            }
        } else if (string.length >= 3) {
                    for (int i = 1; i <= 3; i++) {
                        NSRange codePosition = NSMakeRange(0, i);
                        NSString *code = [initialStringNumber substringWithRange:codePosition];
                            if ([countries objectForKey:code]) {
                                [mutDict setValue:[countries valueForKey:code][0] forKey:@"KeyCountry"];
                                allMaxDigit = [countries objectForKey:code][1];
                                numberDigit = [countries objectForKey:code][2];
                                numberCodeDigit = [countries objectForKey:code][3];
                            } else {
                                [mutDict setValue:@"" forKey:@"KeyCountry"];
                            }
                    }
                    if (!numberCodeDigit) {
                        [initialStringNumber insertString:@"+" atIndex:0];
                        NSString *str = [initialStringNumber substringToIndex:13];
                        return @{KeyPhoneNumber: str,
                                    KeyCountry: @""};
                    }
        } else {
            [initialStringNumber insertString:@"+" atIndex:0];
            return @{KeyPhoneNumber: initialStringNumber,
                     KeyCountry: @""};
        }
    }
    
    NSString *wholeNumber = [NSString new];
    if (string.length > allMaxDigit.integerValue) {
        wholeNumber = [string substringWithRange:NSMakeRange(0, allMaxDigit.integerValue)];
    } else {
        wholeNumber = string;
    }
    
    NSMutableString *onlyNumber = [wholeNumber substringWithRange:NSMakeRange(numberCodeDigit.intValue, (int)wholeNumber.length - numberCodeDigit.intValue)].mutableCopy;
    
    switch (numberDigit.intValue) {
        case 10:
        if (onlyNumber.length > 0) {
            [onlyNumber insertString:@" (" atIndex:0];
            if (onlyNumber.length > 5) {
                [onlyNumber insertString:@") " atIndex:5];
                if (onlyNumber.length > 10) {
                    [onlyNumber insertString:@"-" atIndex:10];
                    if (onlyNumber.length > 13) {
                        [onlyNumber insertString:@"-" atIndex:13];
                    }
                }
            }
            NSString *final = [NSString stringWithFormat:@"+%@%@", [countries2 objectForKey:[mutDict objectForKey:@"KeyCountry"]], onlyNumber];
            [mutDict setValue:final forKey:@"KeyPhoneNumber"];
        } else {
            [initialStringNumber insertString:@"+" atIndex:0];
            [mutDict setValue:initialStringNumber forKey:@"KeyPhoneNumber"];
        }
        break;
        case 9:
            if (onlyNumber.length > 0) {
                [onlyNumber insertString:@" (" atIndex:0];
                if (onlyNumber.length > 4) {
                    [onlyNumber insertString:@") " atIndex:4];
                    if (onlyNumber.length >= 9) {
                        [onlyNumber insertString:@"-" atIndex:9];
                        if (onlyNumber.length > 12) {
                            [onlyNumber insertString:@"-" atIndex:12];
                        }
                    }
                }
                NSString *final = [NSString stringWithFormat:@"+%@%@", [countries2 objectForKey: [mutDict objectForKey:@"KeyCountry"]], onlyNumber];
                [mutDict setValue:final forKey:@"KeyPhoneNumber"];
            } else {
                [initialStringNumber insertString:@"+" atIndex:0];
                [mutDict setValue:initialStringNumber forKey:@"KeyPhoneNumber"];
            }
            break;
        case 8:
        if (onlyNumber.length > 0) {
            [onlyNumber insertString:@" (" atIndex:0];
            if (onlyNumber.length > 4) {
                [onlyNumber insertString:@") " atIndex:4];
                if (onlyNumber.length >= 10) {
                    [onlyNumber insertString:@"-" atIndex:9];
                }
            }
            NSString *final = [NSString stringWithFormat:@"+%@%@", [countries2 objectForKey: [mutDict objectForKey:@"KeyCountry"]], onlyNumber];
            [mutDict setValue:final forKey:@"KeyPhoneNumber"];
        } else {
            [initialStringNumber insertString:@"+" atIndex:0];
            [mutDict setValue:initialStringNumber forKey:@"KeyPhoneNumber"];
        }
        break;
        default:
            break;
    }
 
    return @{KeyPhoneNumber: [mutDict objectForKey:@"KeyPhoneNumber"],
                KeyCountry: [mutDict objectForKey:@"KeyCountry"]};;
}
@end
