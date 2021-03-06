//
//  APIError.swift
//  TrailStar
//
//  Created by Wiliam Convertino on 3/29/22.
//

import Foundation

enum APIError: Error {
    case connectionFailed
    
    case invalidData
    
    case dataParsingError
    
    case locationParsingFailure
    
    case dataNotFound
    
    case unexpected(code: Int)
}
