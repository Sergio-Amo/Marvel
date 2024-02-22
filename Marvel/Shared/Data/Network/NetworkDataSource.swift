//
//  NetworkDataSource.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation

// I've found no reasons to move Methods and constants outside as this file
// has only 52 lines of code and both are relevant to the network layer
struct HTTPMethods {
    static let get = "GET"
    static let content = "application/json"
    static let contentType = "Content-type"
}

struct NetworkConstants {
    static let limit = "?limit=20"
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    private static let _charactersEndPoint = "/characters"
    private static let _seriesEndPoint = "/series"
    // Computed properties & functions
    static var charactersEndPoint: String { "\(baseUrl)\(_charactersEndPoint)" }
    static var seriesEndPoint: String { "\(baseUrl)\(_seriesEndPoint)" }
    static func characterOffset(_ offset: Int) -> String { "&offset=\(offset)" }
    static func characterID(_ id: Int) -> String { "&characters=\(id)" }
}

struct Network {
    
    let auth = Authentication()
    
    func getCharactersRequest(offset: Int = 0) -> URLRequest {
        // BaseURL + Endpoint + Limit + offset + Auth
        let urlWithParams = NetworkConstants.charactersEndPoint+NetworkConstants.limit+NetworkConstants.characterOffset(offset)+"&"+auth.authParams
        return createRequest(from: urlWithParams)
    }
    
    func getCharacterSeriesRequest(id: Int) -> URLRequest {
        // BaseURL + Endpoint + Limit + id + Auth
        let urlWithParams =  NetworkConstants.seriesEndPoint+NetworkConstants.limit+NetworkConstants.characterID(id)+"&"+auth.authParams
        return createRequest(from: urlWithParams)
    }
    
    func createRequest(from urlWithParams: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: urlWithParams)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentType)
        return request
    }
}
