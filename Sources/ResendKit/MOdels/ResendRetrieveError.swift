//
//  ResendRetrieveError.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/3/23.
//

import Foundation


struct ResendRetrieveError: Codable, Error {
    let statusCode:  Int
    let message: String
    let name: String
}
