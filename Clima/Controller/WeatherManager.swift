//
//  WeatherManager.swift
//  Clima
//
//  Created by Smit Patel on 2020-04-01.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel)
    func didfailwitherror(error : Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1a2a1d1aee9d161a7155be1bdcfb27e1&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(urlString: urlString)
        
        
        
    }
    
    func performRequest(urlString : String){
     //1.Create URL
        
        if let url = URL(string: urlString)
        {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didfailwitherror(error: error!)
                         return
                     }
                     if let safeData = data {
                        if let weather = self.parseJSON(weatherData: safeData){
                            
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                     }
            }
            //4. Task resume
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data ) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id , cityName: name, temperature: temp)

            return weather
        } catch
        {
            delegate?.didfailwitherror(error: error)
            return nil
        }
        
    }
    


}
