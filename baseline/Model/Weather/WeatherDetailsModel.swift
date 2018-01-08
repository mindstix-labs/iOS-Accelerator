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

import Foundation
import AlamofireObjectMapper
import ObjectMapper

/**
 * Model class to hold the data of weather details coming from weather details and forecast details API
 *
 */

public class WeatherDetailsModel : Mappable  {
    public var name : String?
    public var lat: NSNumber?
    public var lon: NSNumber?
    public var weather : Array<Weather>?
    var weatherDetails: WeatherDetails?
    public var sunrise: NSNumber?
    public var sunset: NSNumber?
    var wind: Wind?
    
    required public init?(map: Map) {
    }
    public var detailsCapturedDate : String?
    
    public func mapping(map: Map) {
        name <- map["name"]
        lat <- map["coord.lat"]
        lon <- map["coord.lon"]
        weather <- map["weather"]
        sunrise <- map["sys.sunrise"]
        sunset <- map["sys.sunset"]
        weatherDetails <- map["main"]
        wind <- map["wind"]
        detailsCapturedDate <- map["dt_txt"]
    }
}

public class Weather : Mappable {
    public var weatherDescription : String?
    public var icon : String?
    public var iconId : NSNumber?
    public var weatherMain : String?
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        weatherDescription <- map["description"]
        icon <- map["icon"]
        iconId <- map["id"]
        weatherMain <- map["main"]
    }
}

class WeatherDetails : Mappable {
    public var grnd_level : NSNumber?
    public var humidity : NSNumber?
    public var pressure : NSNumber?
    public var sea_level : NSNumber?
    public var temp : NSNumber?
    public var temp_max : NSNumber?
    public var temp_min : NSNumber?
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        grnd_level <- map["grnd_level"]
        humidity <- map["humidity"]
        pressure <- map["pressure"]
        sea_level <- map["sea_level"]
        temp <- map["temp"]
        temp_max <- map["temp_max"]
        temp_min <- map["temp_min"]
    }
}
class Wind : Mappable {
    public var speed : NSNumber?
    public var deg : NSNumber?
    
    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}

