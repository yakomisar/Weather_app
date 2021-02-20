//
//  WeatherModel.swift
//  Clima
//
//  Created by Олег Комисаренко on 29.06.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        var condition = ""
        switch conditionID {
            case 200...233:
                condition = "cloud.bolt"
            case 300...321:
                condition = "cloud.drizzle"
            case 500...531:
                condition = "cloud.rain"
            case 600...622:
                condition = "cloud.snow"
            case 701...781:
                condition = "cloud.fog"
            case 801...804:
                condition = "cloud.bolt"
            case 800:
                condition = "sun.max"
            default:
                condition = "cloud"
        }
        return condition
    } 
}
