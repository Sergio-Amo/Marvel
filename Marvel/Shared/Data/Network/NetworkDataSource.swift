//
//  NetworkDataSource.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation

// I've found no reasons to move Methods and constants outside as this file
// has only 55 lines of code and both are only relevant to the Network layer.
enum HTTPMethods {
    static let get = "GET"
    static let content = "application/json"
    static let contentType = "Content-type"
}

enum NetworkConstants {
    static let itemLimit: Int = 20
    static let limit = "?limit=\(itemLimit)"
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    private static let charactersEndPoint = "/characters"
    private static let seriesEndPoint = "/series"
    static let charactersUrl = "\(baseUrl)\(charactersEndPoint)"
    static let seriesUrl = "\(baseUrl)\(seriesEndPoint)"
    // Computed properties & functions
    static func itemOffset(_ offset: Int) -> String { "&offset=\(offset)" }
    static func characterID(_ id: Int) -> String { "&characters=\(id)" }
}

struct Network {
    
    let auth: AuthenticationProtocol!
    
    init(auth: AuthenticationProtocol = Authentication()) {
        self.auth = auth
    }
    
    func getCharactersRequest(offset: Int = 0) -> URLRequest {
        let urlWithParams = with(NetworkConstants.self) {
            "\($0.charactersUrl)\($0.limit)\($0.itemOffset(offset))&\(auth.authParams)"
        }
        return createRequest(from: urlWithParams)
    }
    
    func getCharacterSeriesRequest(id: Int, offset: Int = 0) -> URLRequest {
        let urlWithParams = with(NetworkConstants.self) {
            "\($0.seriesUrl)\($0.limit)\($0.characterID(id))\($0.itemOffset(offset))&\(auth.authParams)"
        }
        return createRequest(from: urlWithParams)
    }
    
    func createRequest(from urlWithParams: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: urlWithParams)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentType)
        return request
    }
}
