//
//  Extension+URL.swift
//  Marvel
//
//  Created by Sergio Amo on 21/2/24.
//

import Foundation

extension URL {
    /// Computed property that returns http urls to https
    ///
    /// - Returns: Upgraded https url if possible or the original input if not.
    /// # Usage #
    /// ```
    /// let httpURL = URL(string: "http://foo.com")!
    /// let httpsURL = httpURL.upgradeUrlScheme
    /// ```
    var upgradeUrlScheme: URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        return urlComponents?.url ?? self
    }
}
