

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=1e18397658cdd6199d4212f29fa6edfb&units=metric"
    
    func fetchWeatherFor(cityName: String) {
        let getWeather = "\(url)&q=\(cityName)"
        performRequest(url: getWeather)
        //print(getWeather)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let getWeather = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(url: getWeather)
        //print(getWeather)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(url: String)  {
        //1. Create URL
        if let urlString = URL(string: url) {
            //2. Create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = urlSession.dataTask(with: urlString) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


