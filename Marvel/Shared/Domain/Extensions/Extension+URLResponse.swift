//
//  Extension+URLResponse.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation

extension URLResponse {
    /// Computed property that returns the status code of a HTTP response.
    /// 
    /// - returns: Integer with the StatusCode or nil if fails
    /// # Usage #
    /// ```
    /// let statusCode = response.statusCode
    /// ```
    
    var computedStatusCode: Int? {
        return (self as? HTTPURLResponse)?.statusCode
    }
}
