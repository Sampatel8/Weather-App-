//
//  WeatherManager.swift
//  Clima
//
//  Created by Smit Patel on 2020-04-01.
//  Copyright © 2020 App Brewery. All rights reserved.
//


struct WeatherManager {
    
    let weatherURL = "https://samples.openweathermap.org/data/2.5/weather?&appid=1a2a1d1aee9d161a7155be1bdcfb27e1"
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
