//
//  With.swift
//  Marvel
//
//  Created by Sergio Amo on 1/3/24.
//

import Foundation

/// Executes a closure that takes a value as its argument and returns the result.
/// It's similar to the kotlin `with` scope function
///
/// - parameter value: Value that will be passed to the closure.
/// - parameter closure: Closure takes an argument T and returns a value R.
/// - Returns: The result returned by the closure.
///
/// # Example #
/// ```
/// enum NetworkConstants {
///     static let baseUrl: String = "FooBar.com"
///     static let endPoint: String =  "/baz"
/// }
/// let endPointFullPath = with(NetworkConstants.self) {
///     "\($0.baseUrl)\($0.endPoint)"
/// }
/// ```
func with<T, R>(_ value: T, _ closure: (T) -> R) -> R {
    return closure(value)
}
