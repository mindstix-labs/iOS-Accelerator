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

import UIKit
import Firebase
import Mantle
import SDWebImage



/**
 * ViewController to show weather forecast of city.
 * - Current weather.
 * - Forecast for next 5 days.
 *
 */

class WeatherReportViewController: UIViewController {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var skyDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var sunsetTimeLabel: UILabel!
    @IBOutlet var sunriseTimeLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    
    let appId: String = Bundle.main.infoDictionary!["WEATHER_FORECAST_APPID"] as! String
    let baseUrlString = Bundle.main.infoDictionary!["WEATHER_BASE_URL"] as! String
    let apiVersion = Bundle.main.infoDictionary!["WEATHER_API_VERSION"] as! String
    
    var weatherList = [WeatherDetailsModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = String(format: NSLocalizedString("WeatherReportViewController_titleLabel", comment:"" ))
        
        //initialize weather API helper to set baseUrl, api version and api key.
        let weatherAPIHelper : WeatherAPIHelper = WeatherAPIHelper.init(baseUrlString: baseUrlString, apiVersion: apiVersion, apiKey: appId)
        
        weatherAPIHelper.getWeatherDataFor(city: "Pune,in") { (weatherDetails: WeatherDetailsModel?, error: Error?) in
            guard let weatherDetails = weatherDetails else {
                print("Failed to get weather data.")
                return
            }
            self.populateWeatherDetails(with: weatherDetails)
        }
        weatherAPIHelper.getForecastDataFor(city: "Pune,in") { (forecastDetails: ForecastDetailsModel?, error: Error?) in
            guard let forecastDetails = forecastDetails else {
                print("Failed to get forecast data.")
                return
            }
            self.weatherList = forecastDetails.weatherDetails
        }
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\("title")" as NSObject,
            AnalyticsParameterItemName: "title" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private functions
    /**
     * Bind current weather data received from API to UI.
     *
     * @param weatherDetails - Weather data received from API.
     */
    func populateWeatherDetails(with weatherDetails:WeatherDetailsModel){
        // Show city name
        self.cityNameLabel.text = weatherDetails.name
        
        // Show latitude.
        self.latitudeLabel.text = String(format: NSLocalizedString("latitudeLabel", comment:"" ), weatherDetails.lat.floatValue)
        
        // Show longitude.
        self.longitudeLabel.text = String(format: NSLocalizedString("longitudeLabel", comment:"" ), weatherDetails.lon.floatValue)

        var tempWeatherDetail = Weather()
        tempWeatherDetail =  weatherDetails.weather.first
        
        // Show weather condition status.
        self.skyDescriptionLabel.text = String(format: NSLocalizedString("skyDetailsLabel", comment:"" ), (tempWeatherDetail?.weatherMain)!)
        
        // Show weather condition icon.
        let iconBaseUrl: String = Bundle.main.infoDictionary!["WEATHER_ICON_BASE_URL"] as! String
        let imageUrl = iconBaseUrl + (tempWeatherDetail?.icon)! + ".png"
        self.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            self.imageView.image = image;
        })
        
        // Show temperature.
        self.temperatureLabel.text = String(format: NSLocalizedString("temperatureLabel", comment:"" ), weatherDetails.weatherDetails.temp.floatValue)
        
        // Show minimum temperature.
        self.minTempLabel.text = String(format: NSLocalizedString("minTemperatureLabel", comment:"" ),weatherDetails.weatherDetails.temp_min.floatValue)
        
        // Show maximum temperature.
        self.maxTempLabel.text = String(format: NSLocalizedString("maxTemperatureLabel", comment:"" ),weatherDetails.weatherDetails.temp_max.floatValue)
        
        // Show pressure.
        self.pressureLabel.text = String(format: NSLocalizedString("pressureLabel", comment:"" ),weatherDetails.weatherDetails.pressure.floatValue)
        
        // Show humidity.
        self.humidityLabel.text = String(format: NSLocalizedString("humidityLabel", comment:"" ),weatherDetails.weatherDetails.humidity.floatValue)
        
        // Show wind speed.
        self.windLabel.text = String(format: NSLocalizedString("windLabel", comment:"" ),weatherDetails.wind.speed.floatValue)
        
        // Show sunrise time.
        self.sunriseTimeLabel.text = String(format: NSLocalizedString("sunriseLabel", comment:"" ), self.convertTimeToString(time: weatherDetails.sunrise))
        
        // Show sunset time.
        self.sunsetTimeLabel.text = String(format: NSLocalizedString("sunsetLabel", comment:"" ), self.convertTimeToString(time: weatherDetails.sunset))
    }
    
    /**
     * Function to convert time to string format.
     *
     * @param time - time which is to be converted to string format.
     */
    func convertTimeToString(time:NSNumber ) -> String{
        let currentDateTime = NSDate(timeIntervalSince1970: time.doubleValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: currentDateTime as Date)
    }
}

// MARK: - UITableViewDataSource
extension WeatherReportViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weather = weatherList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastDetailsTableViewCell", for: indexPath) as! ForecastDetailsTableViewCell
        cell.populateDataOnCell(with: weather)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherReportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245;
    }
    
}
