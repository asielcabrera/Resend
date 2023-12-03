//
//  ResendClient.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 12/2/23.
//

import Foundation
import NIO
import AsyncHTTPClient
import NIOHTTP1
import NIOFoundationCompat


public struct ResendClient {
    
    static var apiURL = "https://api.resend.com"
    static var httpClient: HTTPClient?
    static var apiKey: String?
    
    public init(httpClient: HTTPClient, apiKey: String) {
        Self.httpClient = httpClient
        Self.apiKey = apiKey
    }
    
    public static func initialized(httpClient: HTTPClient, apiKey: String) {
        Self.httpClient = httpClient
        Self.apiKey = apiKey
    }
    
}
