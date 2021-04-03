//
//  ViewModel.swift
//  TCSCoding
//
//  Created by Rohith Kumar on 4/2/21.
//

import Foundation

struct DetailsOfCity {
    let cityNameValue: String
    let description: String
    let rows: [(label: String, value: String)]
    
    init(tempature: CityTemperature, cityName: String) {
        cityNameValue = cityName
        description = tempature.weather.first?.description ?? ""
        var rowsCalculations: [(label: String, value: String)] = []
        rowsCalculations.append(("Tempeature ", "\(tempature.main.temp) K"))
        rowsCalculations.append(("Pressure", "\(tempature.main.pressure) hpa"))
        rowsCalculations.append(("Humidity", "\(tempature.main.humidity) %"))
        rowsCalculations.append(("Tempeature Min", "\(tempature.main.tempMin) hpa"))
        rowsCalculations.append(("Tempeature Max", "\(tempature.main.tempMax) K"))
        rowsCalculations.append(("Wind Speed", "\(tempature.wind.speed)"))
        rowsCalculations.append(("Sunrise", "\(tempature.sys.sunrise)"))
        rowsCalculations.append(("Sunset", "\(tempature.sys.sunset)"))
        rows = rowsCalculations
    }
}


struct CityTemperature: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}

