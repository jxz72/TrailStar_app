//
//  TrailData.swift
//  TrailStar
//
//  Created by William Convertino on 3/28/22.
//

struct TrailData {
    var name: String
    var city: String
    var state: String
    var country: String
    var length: Float
    var description: String
    var directionsBlurb: String
    var latitude: Double?
    var longitude: Double?
}

//--MARK: Test Values

let TEST_TRAIL_DATA: TrailData = TrailData(
    name: "name",
    city: "city",
    state: "state",
    country: "country",
    length: 0.0,
    description: "description",
    directionsBlurb: "directions",
    latitude: 0,
    longitude: 0
)

let TEST_WEATHER_DATA: WeatherData = WeatherData(
    city: "city",
    state: "state",
    country: "country",
    date: "yyyy-mm-dd",
    temperature: 0.0,
    conditions: "conditions",
    rainChance: 0
)
