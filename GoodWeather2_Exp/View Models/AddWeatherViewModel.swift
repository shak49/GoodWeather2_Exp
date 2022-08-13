//
//  AddWeatherViewModel.swift
//  GoodWeather2_Exp
//
//  Created by Shak Feizi on 8/13/22.
//

import Foundation


struct WeatherViewModel {
    let weather: Weather
    
    var tempreture: Double {
        return weather.tempreture
    }
    var city: String {
        return weather.city
    }
    var icon: String {
        return weather.icon
    }
    var sunrise: Date {
        return weather.sunrise
    }
    var sunset: Date {
        return weather.sunset
    }
}

class AddWeatherViewModel: ObservableObject {
    var city: String = ""
    
    func save(completion: @escaping(WeatherViewModel) -> Void) {
        Webservice().getWeatherByCity(city: city) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(weather: weather))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
