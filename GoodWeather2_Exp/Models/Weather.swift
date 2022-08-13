//
//  Weather.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/8/21.
//

import Foundation

struct Response: Decodable {
    let name: String
    let weather: Weather
    let icons: [WeatherIcon]
    let sys: Sys
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.icons = try container.decode([WeatherIcon].self, forKey: .icon)
        self.sys = try container.decode(Sys.self, forKey: .sys)
        let weatherContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        let tempreture = try weatherContainer.decode(Double.self, forKey: .tempreture)
        weather = Weather(city: name, tempreture: tempreture, icon: self.icons.first!.icon, sunrise: self.sys.sunrise, sunset: self.sys.sunset)
    }
    
}

extension Response {
    private enum ResponseKeys: String, CodingKey {
        case name
        case weather = "main"
        case icon = "weather"
        case sys = "sys"
    }
    
    enum WeatherKeys: String, CodingKey {
        case tempreture = "temp"
    }
}


struct Weather: Decodable {
    let city: String
    let tempreture: Double
    let icon: String
    let sunrise: Date
    let sunset: Date
}

struct WeatherIcon: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Sys: Decodable {
    let sunrise: Date
    let sunset: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SysKeys.self)
        let sunriseTimeInterval = try container.decode(Int32.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int32.self, forKey: .sunset)
        self.sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
        self.sunset = Date(timeIntervalSince1970: TimeInterval(sunsetTimeInterval))
    }
}

extension Sys {
    private enum SysKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}
