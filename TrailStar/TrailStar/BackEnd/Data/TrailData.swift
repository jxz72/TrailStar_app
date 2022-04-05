//
//  TrailData.swift
//  TrailStar
//
//  Created by William Convertino on 3/28/22.
//

struct TrailData {
    var name: String
    var city: String
    var country: String
    var length: Float
    var description: String
    var directionsBlurb: String
}

//--MARK: Test Values

let TEST_TRAIL_DATA: TrailData = TrailData(
    name: "name",
    city: "city",
    country: "country",
    length: 0.0,
    description: "description",
    directionsBlurb: "directions"
)
