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
import UIKit
import SDWebImage

/**
 * Custom UITableViewCell to show weather forecast details on a table view
 *
 */

public class ForecastDetailsTableViewCell: UITableViewCell {
   
    @IBOutlet var forecastDateTimeLabel: UILabel!
    @IBOutlet var skyDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    
    // MARK: Private functions
    /**
     * Bind current forecast data received from API to UI.
     *
     * @param weatherDetails - Weather data received from API.
     */
    
    public func populateDataOnCell(with details:WeatherDetailsModel){
        
        
        var tempWeatherDetail : Weather? = nil
        
        if details.weather != nil &&  (details.weather?.count)! > 0 {
            tempWeatherDetail =  details.weather!.first!
        }

        // Show weather condition status.
        if(self.skyDescriptionLabel != nil) {
            self.skyDescriptionLabel.text = String(format: NSLocalizedString("skyDetailsLabel", comment:"" ), (tempWeatherDetail?.weatherMain)!)
        }

        // Show weather condition icon.
        let iconBaseUrl: String = Bundle.main.infoDictionary!["WEATHER_ICON_BASE_URL"] as! String
        let imageUrl = iconBaseUrl + (tempWeatherDetail?.icon)! + ".png"
        self.weatherImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            self.weatherImageView.image = image;
        })

        // Show temperature.
        if let temperature = details.weatherDetails?.temp {
            self.temperatureLabel.text = String(format: NSLocalizedString("temperatureLabel", comment:"" ), temperature.floatValue)
        }

        // Show minimum temperature.
        if let minTemperature = details.weatherDetails?.temp_min {
            self.minTempLabel.text = String(format: NSLocalizedString("minTemperatureLabel", comment:"" ),minTemperature.floatValue)
        }

        // Show maximum temperature.
        if let maxTemperature = details.weatherDetails?.temp_max {
            self.maxTempLabel.text = String(format: NSLocalizedString("maxTemperatureLabel", comment:"" ),maxTemperature.floatValue)
        }

        // Show pressure.
        if let pressure = details.weatherDetails?.pressure {
            self.pressureLabel.text = String(format: NSLocalizedString("pressureLabel", comment:"" ),pressure.floatValue)
        }

        // Show humidity.
        if let humidity = details.weatherDetails?.humidity {
            self.humidityLabel.text = String(format: NSLocalizedString("humidityLabel", comment:"" ),humidity.floatValue)
        }

       // Show wind speed.
        if let wind = details.wind?.speed {
            self.windLabel.text = String(format: NSLocalizedString("windLabel", comment:"" ),wind.floatValue)
        }

        // Show weather data captured time.
        if let capturedDate = details.detailsCapturedDate{
            self.forecastDateTimeLabel.text = String(format: NSLocalizedString("ForecastLabel", comment:"" ), self.convertTimeToString(time: capturedDate as NSString))
        }
    }
    
    /**
     * Function to convert time to string format.
     *
     * @param time - time which is to be converted to string format.
     */
    
    func convertTimeToString(time:NSString ) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var stringFromDate = ""
        if let dateFromString = formatter.date(from: time as String) {
            formatter.dateFormat = "dd-MM-yyyy HH:mm"
            stringFromDate = formatter.string(from: dateFromString)
        }
        return stringFromDate
    }
}
