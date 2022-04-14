//
//  WeatherAPIModule.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 4/2/22.
//

import Foundation

class WeatherAPI {
    private static func formatURLQuery(query: String) -> String {
        return query.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    }
    
    //date must be in form: yyyy-mm-dd. For example, April 5th 2022 is: 2022-04-05
    //days = number of days in advance that we are predicting. Can go from 0 to 2.
    //0 means just today, 1 means tomorrow, and 2 means two days from now.
    static func generateWeather(trailData: TrailData, date: String, days: Int) throws ->  WeatherData {
        return try generateWeather(city: trailData.city, state: trailData.state, country: trailData.country, date: date, days: days)
    }
    
    static func generateWeather(city: String, state: String, country: String, date: String, days: Int) throws ->  WeatherData {
        
        var weatherAtCity = WeatherData(city: city, state: state, country: country, date: date, temperature: 0.0, conditions: "None", rainChance: 0)
        
        var retTemperature = 0.0
        var retConditions = "None"
        var retRainChance = 0
         
        var callError: Error?
        
        let session = URLSession.shared
        
        let group = DispatchGroup()
        group.enter()

        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=f826a4ae7cab467981a192902220204&q=" + city + "," + state + "," + country + "&days=" + "3" + "&aqi=no&alerts=no")!
        
        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            
            guard error == nil else {
                callError = APIError.connectionFailed
                group.leave()
                return;
            }
            
            guard let jsonData = data else {
                callError = APIError.invalidData
                group.leave()
                return;
            }

            do {
                
                if let weather_apicall = try? JSONDecoder().decode(WeatherItem.self, from: jsonData) {
                    
                    retTemperature = weather_apicall.forecast.forecastday[days].day.avgtempF
                    retConditions = weather_apicall.forecast.forecastday[days].day.condition.text
                    retRainChance = weather_apicall.forecast.forecastday[days].day.dailyChanceOfRain
                    //note: rain chance is in 100s. Divide by 100 to get percentage.
                    
                    print("Returned Temperature: \(retTemperature)")
                    print("Returned Conditions: " + retConditions)
                    print("Returned Rain Chance: \(retRainChance)")
                    
                    
                    weatherAtCity.temperature = retTemperature
                    weatherAtCity.conditions = retConditions
                    weatherAtCity.rainChance = retRainChance

                }
                
            }
            
            group.leave()
        })
        
        dataTask.resume()
        
        group.wait()
        
        guard callError == nil else {
            throw callError!
        }
        
        return weatherAtCity
        
    }
    
    
    
    
    //date must be in form: yyyy-mm-dd. For example, April 5th 2022 is: 2022-04-05
    //days = number of days in advance that we are predicting. Can go from 0 to 2.
    //0 means just today, 1 means tomorrow, and 2 means two days from now.
    //DONT USE THIS IN CALL: note to self: On the API call, 1 = today, 2 = today and tomorrow, 3 = today, tomorrow, and next day
    func generateWeather1(city: String, state: String, country: String, date: String, days: Int, myCompletionHandler: @escaping (WeatherData) -> Void) {
            
            var weatherAtCity = WeatherData(city: city, state: state, country: country, date: date, temperature: 0.0, conditions: "None", rainChance: 0)
            print(weatherAtCity)
            
            var retTemperature = 0.0
            var retConditions = "None"
            var retRainChance = 0
            
            //weatherapi.com
            let mySession = URLSession(configuration: URLSessionConfiguration.default)
            
        

            let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=f826a4ae7cab467981a192902220204&q=" + city + "," + state + "," + country + "&days=" + "3" + "&aqi=no&alerts=no")!
            
            
            let task = mySession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error with fetching weather: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
                }
                
                // check response code
                // ensure there is data returned from this HTTP response
                guard let jsonData = data else {
                    print("No data")
                    return
                }

                if let weather_apicall = try? JSONDecoder().decode(WeatherItem.self, from: jsonData) {
                    
                     retTemperature = weather_apicall.forecast.forecastday[days].day.avgtempF
                     retConditions = weather_apicall.forecast.forecastday[days].day.condition.text
                     retRainChance = weather_apicall.forecast.forecastday[days].day.dailyChanceOfRain
                     //note: rain chance is in 100s. Divide by 100 to get percentage.
                     
                     print("Returned Temperature: \(retTemperature)")
                     print("Returned Conditions: " + retConditions)
                     print("Returned Rain Chance: \(retRainChance)")
                     
                     
                     weatherAtCity.temperature = retTemperature
                     weatherAtCity.conditions = retConditions
                     weatherAtCity.rainChance = retRainChance

                    //Note: myCompletionHandler is defined in ViewController (or wherever we call generateWeather)
                    myCompletionHandler( weatherAtCity )
                }
            } )
        
            task.resume()
    }
    

    // MARK: - WeatherItem
    struct WeatherItem: Codable {
        let location: Location
        let current: Current
        let forecast: Forecast
    }

    // MARK: - Current
    struct Current: Codable {
        let condition: AstroClass
        let uv: Int
    }

    // MARK: - AstroClass
    struct AstroClass: Codable {
    }

    // MARK: - Forecast
    struct Forecast: Codable {
        let forecastday: [Forecastday]
    }

    // MARK: - Forecastday
    struct Forecastday: Codable {
        let date: String
        let day: Day
        let astro: AstroClass
        let hour: [Hour]
    }

    // MARK: - Day
    struct Day: Codable {
        let maxtempF, mintempF, avgtempF: Double
        let dailyWillItRain, dailyChanceOfRain, dailyWillItSnow, dailyChanceOfSnow: Int
        let condition: DayCondition

        enum CodingKeys: String, CodingKey {
            case maxtempF = "maxtemp_f"
            case mintempF = "mintemp_f"
            case avgtempF = "avgtemp_f"
            case dailyWillItRain = "daily_will_it_rain"
            case dailyChanceOfRain = "daily_chance_of_rain"
            case dailyWillItSnow = "daily_will_it_snow"
            case dailyChanceOfSnow = "daily_chance_of_snow"
            case condition
        }
    }

    // MARK: - DayCondition
    struct DayCondition: Codable {
        let text, icon: String
        let code: Int
    }

    // MARK: - Hour
    struct Hour: Codable {
        let condition: AstroClass
    }

    // MARK: - Location
    struct Location: Codable {
        let name, region, country: String
        let lat, lon: Double
        let tzID: String
        let localtimeEpoch: Int
        let localtime: String

        enum CodingKeys: String, CodingKey {
            case name, region, country, lat, lon
            case tzID = "tz_id"
            case localtimeEpoch = "localtime_epoch"
            case localtime
        }
    }

}
