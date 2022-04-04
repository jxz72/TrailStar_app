//
//  WeatherAPIModule.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 4/2/22.
//

import Foundation

class WeatherAPIModule {
    //date must be in form:
    //days = number of days in advance that we are predicting. Can go from 1 to 3. 1 means just today, 2 means today and tomorrow, and 3 means today, tomorrow, and the next day.
    
    func generateWeather(city: String, state: String, country: String, date: String, days: Int) throws -> WeatherData {
        
        //create new object of WeatherData type, to return later
        var weatherAtCity = WeatherData(city: city, state: state, country: country, date: date, temperature: "None", conditions: "None")
        
        //weatherapi.com
        let mySession = URLSession(configuration: URLSessionConfiguration.default)
        
        let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=f826a4ae7cab467981a192902220204&q=" + "Durham" + "," + "NC" + "," + "USA" + "&days=" + "3" + "&aqi=no&alerts=no")!
        
/*        let url = URL(string: "http://api.weatherapi.com/v1/current.json?key=f826a4ae7cab467981a192902220204&q=" + "Durham" + ", " + "NC" + ", " + "USA" + "&aqi=no")!*/
        
        let task = mySession.dataTask(with: url) { data, response, error in
        // ensure there is no error for this HTTP response
        guard error == nil else {
            print ("Error: \(error!)") // local console message for debug

                //DispatchQueue.main.async {
                //let alert = UIAlertController(title: "Error - ", message: "\(error!)", preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //self.present(alert, animated: true)
                //}
             
            return
        }
        
        // check response code
        
        // ensure there is data returned from this HTTP response
        guard let jsonData = data else {
            print("No data")
            return
        }
        
        do {
            var weather_apicall = try JSONDecoder().decode([WeatherItem].self, from: jsonData)
            print(weather_apicall)
            
            //var forecast_weather_apicall = weather_apicall.forecast
            
//            for todo in self.allTodos {
//                print("Read UserId: \(todo.userId)")
//                print("This Id: \(todo.id)")
//                print("The Title: \(todo.title)")
//
//                if (todo.completed) {
//                    print("TRUE")
//                } else {
//                    print("FALSE")
//                }
//            }
            //print("Done!")
            /*
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }*/
            
        } catch {
            print("error in weatherAPI")
            /*
            DispatchQueue.main.async {
               let alert = UIAlertController(title: "JSON Decode Error - ", message: "\(error)", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert, animated: true)
           }*/
        }
    }
    task.resume()
    
    return weatherAtCity
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
