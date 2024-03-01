//
//  StatusModel.swift
//  Marvel
//
//  Created by Sergio Amo on 1/3/24.
//

import Foundation

enum Status: Equatable {
    case none, loading, loaded, error(error: String)
}
