//
//  TrailAPIModule.swift
//  TrailStar
//
//  Created by William Convertino on 3/29/22.
//

import Foundation

class TrailAPIModule {

    
    // MARK: - Trail generation
    /*
     Generates trails from a given latitude and longitude
     */
    static func generateTrailList(latitude: Double, longitude: Double, limit: Int=30) throws -> [TrailData] {
        let request = NSMutableURLRequest(url: NSURL(string: String(format: "https://trailapi-trailapi.p.rapidapi.com/activity/?lat=%f&limit=30&lon=%f&radius=20&q-activities_activity_type_name_eq=hiking",latitude,longitude  ))! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        return try generateTrailList(request: request);
    }
    
    /*
     Generates trails from a given city, state, and country name
     */
    static func generateTrailList(city: String, state: String, country: String="United States", limit: Int=30) throws -> [TrailData] {
        print("enter generateTrailList1 city=\(city), state=\(state)")
    
        let request = NSMutableURLRequest(url: NSURL(string: String(format: "https://trailapi-trailapi.p.rapidapi.com/activity/?limit=%d&q-city_cont=%@&q-country_cont=%@&q-state_cont=%@&q-activities_activity_type_name_eq=hiking",
                                                                    limit, formatURLQuery(query: city), formatURLQuery(query: country), formatURLQuery(query: state)
                                                                   ))! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        return try generateTrailList(request: request);
        
    }
    
    /*
     Generates trails from a given request
     */
    static func generateTrailList(request: NSMutableURLRequest) throws -> [TrailData] {
        print("enter generateTrailList2")
        
        var encodedTrailMap: TrailEncodingMap = [:]
        
        let headers = [
            "x-rapidapi-host": "trailapi-trailapi.p.rapidapi.com",
            "x-rapidapi-key": "c089a61c79msh55e4f2311111661p15f8dbjsn40de6114c9d2"
        ]

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        var callError: Error?
        
        let session = URLSession.shared
        
        let group = DispatchGroup()
        group.enter()
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            
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

            /*
            print("printing jason")
                do {
                    let data1 =  try JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                    let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                    print(convertedString ?? "defaultvalue")
                } catch let myJSONError {
                    print(myJSONError)
                }

            */
            
            do {
                print("JSONDATA: \(jsonData)")
                
                
                
                encodedTrailMap = try JSONDecoder().decode(TrailEncodingMap.self, from: jsonData)
                
            } catch {
                print("JSON Decoder error = \(error)" )
                callError = APIError.unexpected(code: 0)
            }
            
            group.leave()
        })
        
        dataTask.resume()
        
        group.wait()
        
        guard callError == nil else {
            throw callError!
        }
        
        
        var trailDataList: [TrailData] = []
        
        for trailEncoding in encodedTrailMap.values {
            let trailData: TrailData = decodeTrail(encoding: trailEncoding)
            trailDataList.append(trailData)
        }
        
        
        print("exit generateTrailList2")

        return trailDataList
        
    }
    

    
    
    private static func formatURLQuery(query: String) -> String {
        return query.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    }
    
    private static func decodeTrail(encoding: TrailEncoding) -> TrailData {
        return TrailData(
            name: encoding.name,
            city: encoding.city,
            state: encoding.state,
            country: encoding.country,
            length: Float(encoding.activities.hiking.length)!,
            desc: encoding.trailsDescription,
            directionsBlurb: encoding.directions,
            latitude: Double(encoding.lat),
            longitude: Double(encoding.lon)
        )
    }
    
    private typealias TrailEncodingMap = [String : TrailEncoding]

    // MARK: - Trail Encoding
    private struct TrailEncoding: Codable {
        var name, city, state, country: String
        var trailsDescription, directions, lat, lon: String
        var parentID, placeID: String
        var activities: Activities

        enum CodingKeys: String, CodingKey {
            case name, city, state, country
            case trailsDescription = "description"
            case directions, lat, lon
            case parentID = "parent_id"
            case placeID = "place_id"
            case activities
        }
    }

    // MARK: - Activity Encoding
    private struct Activities: Codable {
        var hiking: Hiking
    }

    // MARK: - Hiking Encoding
    private struct Hiking: Codable {
        var url: String
        var length, hikingDescription, name, rank: String
        var rating, thumbnail, activityType, activityTypeName: String
        var attribs: Attribs
        var placeActivityID: String

        enum CodingKeys: String, CodingKey {
            case url, length
            case hikingDescription = "description"
            case name, rank, rating, thumbnail
            case activityType = "activity_type"
            case activityTypeName = "activity_type_name"
            case attribs
            case placeActivityID = "place_activity_id"
        }
    }

    // MARK: - Attribs Encoding
    private struct Attribs: Codable {
        var length: String
    }
    
    
    
}
