//
//  ResendCodable.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 12/3/23.
//

import Foundation

extension ResendClient {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
}
