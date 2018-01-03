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
import Mantle

public typealias WeatherDataCompletionHandler = (WeatherDetailsModel?, Error?) -> ()
public typealias ForecastDataCompletionHandler = (ForecastDetailsModel?, Error?) -> ()

let WEATHER_PATH = "/weather"
let FORECAST_PATH = "/forecast"

/**
 * Weather API helper class which is responsible to get weather and forecast data from API
 *
 */

public class WeatherAPIHelper {
    var baseUrl: String?
    var apiVersion: String?
    var appId: String?
    
    /**
     * Initialse helper to set base url, api version and api key.
     *
     * @Params baseUrlString: base url string required for weather API
     * @Params apiVersion: API version required for weather API
     * @Params apiKey: API key required for weather API
     */
    public init(baseUrlString: String, apiVersion:String, apiKey: String) {
        self.baseUrl = baseUrlString
        self.apiVersion = apiVersion
        self.appId = apiKey
    }
    
    /**
     * API call to get current weather data.
     * http://api.openweathermap.org/data/2.5/weather?q=Pune,in&appid=af921fb4e45cceda08b7ce7f63c71005
     *
     * @completionHandler : returns object of WeatherDetailsModel and error
     */
    
    func getWeatherDataFor (city:String, completionHandler: @escaping WeatherDataCompletionHandler) {
        var completeURLString: String?
        completeURLString = self.baseUrl! + self.apiVersion! + WEATHER_PATH
        
        var params: [String: String] = [:]
        params["appid"] = self.appId
        params["q"] = city
        
        MSBaseService.makeRequest(with:completeURLString!, method: .get, query: params , headers: nil, body: nil, completionHandler: { (response: NSDictionary?, error: Error?) in
            do {
                
                let weatherDetails =  try MTLJSONAdapter.model(of: WeatherDetailsModel.self, fromJSONDictionary: response as! [AnyHashable : Any]) as! WeatherDetailsModel
                completionHandler(weatherDetails,error)
                
            } catch {
                
            }
        })
    }
    
    /**
     * API call to get forecast weather data.
     * http://api.openweathermap.org/data/2.5/forecast?q=Pune,in&appid=af921fb4e45cceda08b7ce7f63c71005
     *
     * @completionHandler : returns object of ForecastDetailsModel and error
     */
    
    func getForecastDataFor (city:String, completionHandler: @escaping ForecastDataCompletionHandler) {
        var completeURLString: String?
        completeURLString = self.baseUrl! + self.apiVersion!  + FORECAST_PATH
        

        var params: [String: String] = [:]
        params["appid"] = self.appId
        params["q"] = city
        
        MSBaseService.makeRequest(with:completeURLString!, method: .get, query: params , headers: nil, body: nil, completionHandler: { (response: NSDictionary?, error: Error?) in
            let userData = response as NSDictionary? as? [AnyHashable: Any] ?? [:]
            do {
                
                let forecastDetails =  try MTLJSONAdapter.model(of: ForecastDetailsModel.self, fromJSONDictionary: userData) as! ForecastDetailsModel
                completionHandler(forecastDetails,error)
            } catch {
                
            }
        })
    }
}

