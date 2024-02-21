//
//  NetworkDataSource.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation

struct HTTPMethods {
    static let get = "GET"
    static let content = "application/json"
}

struct NetworkConstants {
    static let limit = "?limit=20"
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    private static let _charactersEndPoint = "/characters"
    private static let _seriesEndPoint = "/series"
    
    static var charactersEndPoint: String {
        "\(baseUrl)\(_charactersEndPoint)"
    }
    static var seriesEndPoint: String {
        "\(baseUrl)\(_seriesEndPoint)"
    }
}

struct Network {
    
    let auth = Authentication()
    
    func getCharactersRequest(offset: Int = 0) -> URLRequest {
        let offset = "&offset=\(offset)"
        // BaseURL + Endpoint + Limit + offset + Auth
        let urlCad = NetworkConstants.charactersEndPoint+NetworkConstants.limit+offset+"&"+auth.authParams
        return createRequest(from: urlCad)
    }
    
    func getCharacterSeriesRequest(id: Int) -> URLRequest {
        let id = "&characters=\(id)"
        // BaseURL + Endpoint + Limit + id + Auth
        let urlCad = NetworkConstants.seriesEndPoint+NetworkConstants.limit+id+"&"+auth.authParams
        return createRequest(from: urlCad)
    }
    
    func createRequest(from urlString: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        return request
    }
}
