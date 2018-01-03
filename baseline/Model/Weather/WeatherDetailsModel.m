// Copyright (c) 2017-18 Mindstix Software Labs, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "WeatherDetailsModel.h"

@implementation WeatherDetailsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"lat" : @"coord.lat",
             @"lon" : @"coord.lon",
             @"weather" : @"weather",
             @"sunrise" : @"sys.sunrise",
             @"sunset" : @"sys.sunset",
             @"weatherDetails":@"main",
             @"wind":@"wind",
             @"detailsCapturedDate":@"dt_txt"
             };
}

+ (NSValueTransformer *)weatherJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Weather class]];
}

+ (NSValueTransformer *)weatherDetailsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WeatherDetails class]];
}

+ (NSValueTransformer *)windJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[Wind class]];
}

@end


@implementation Weather

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weatherDescription" : @"description",
             @"icon" : @"icon",
             @"iconId" : @"id",
             @"weatherMain" : @"main"
             };
}

@end

@implementation WeatherDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"grnd_level" : @"grnd_level",
             @"humidity" : @"humidity",
             @"pressure" : @"pressure",
             @"sea_level" : @"sea_level",
             @"temp" : @"temp",
             @"temp_max" : @"temp_max",
             @"temp_min" : @"temp_min"
             };
}
@end

@implementation Wind

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"speed" : @"speed",
             @"deg" : @"deg"
             };
}
@end

