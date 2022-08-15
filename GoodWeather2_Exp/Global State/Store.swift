//
//  Store.swift
//  GoodWeather2_Exp
//
//  Created by Shak Feizi on 8/13/22.
//

import Foundation


class Store: ObservableObject {
    @Published var selectedUnit: TemperatureUnit = .kelvin
    @Published var weatherList: [WeatherViewModel] = []
    
    init() {
        selectedUnit = UserDefaults.standard.unit
    }
    
    func addWeather(weather: WeatherViewModel) {
        self.weatherList.append(weather)
    }
}
