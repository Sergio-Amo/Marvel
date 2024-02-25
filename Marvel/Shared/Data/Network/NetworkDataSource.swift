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
    static let itemLimit: Int = 20
    static let limit = "?limit=\(itemLimit)"
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    private static let charactersEndPoint = "/characters"
    private static let seriesEndPoint = "/series"
    // Computed properties & functions
    static var charactersUrl: String { "\(baseUrl)\(charactersEndPoint)" }
    static var seriesUrl: String { "\(baseUrl)\(seriesEndPoint)" }
    static func itemOffset(_ offset: Int) -> String { "&offset=\(offset)" }
    static func characterID(_ id: Int) -> String { "&characters=\(id)" }
}

struct Network {
    
    let auth = Authentication()
    
    func getCharactersRequest(offset: Int = 0) -> URLRequest {
        // BaseURL + Endpoint + Limit + offset + Auth
        let urlWithParams = NetworkConstants.charactersUrl+NetworkConstants.limit+NetworkConstants.itemOffset(offset)+"&"+auth.authParams
        return createRequest(from: urlWithParams)
    }
    
    func getCharacterSeriesRequest(id: Int, offset: Int = 0) -> URLRequest {
        // BaseURL + Endpoint + Limit + id + offset + Auth
        let urlWithParams =  NetworkConstants.seriesUrl+NetworkConstants.limit+NetworkConstants.characterID(id)+NetworkConstants.itemOffset(offset)+"&"+auth.authParams
        return createRequest(from: urlWithParams)
    }
    
    func createRequest(from urlWithParams: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: urlWithParams)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentType)
        return request
    }
}
