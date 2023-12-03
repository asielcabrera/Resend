//
//  ResendRequestMaker.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 12/3/23.
//

import Foundation
import NIO
import AsyncHTTPClient
import NIOHTTP1
import NIOFoundationCompat


public extension ResendClient {
    static func makeRequest<T: Codable>(method: HTTPMethod, route: String, data: T) throws -> HTTPClient.Request {
        return try .init(url: makeURL(route: route), method: method, headers: makeHeaders(), body: .data(encoder.encode(data)))
    }
    
    static func makeRequest(method: HTTPMethod, route: String) throws -> HTTPClient.Request {
        return try .init(url: makeURL(route: route), headers: makeHeaders())
    }
    
    static func makeHeaders() -> HTTPHeaders {
        guard let apiKey = Self.apiKey else { fatalError("You must set a Resend ApiKey")}
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        headers.add(name: "Content-Type", value: "application/json")
        return headers
    }
    
    static func makeURL(route: String) -> String {
        return Self.apiURL + "/\(route)"
    }
}
