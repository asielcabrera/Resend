//
//  ResendEmailClient.swift
//
//
//  Created by Asiel Cabrera Gonzalez on 12/3/23.
//

import Foundation
import NIO

extension ResendClient {
    
    public static let email = Email()
    
    public struct Email {
        public func send(email: ResendEmail) async throws -> ResendEmailResponse {
            let req = try ResendClient.makeRequest(method: .POST, route: "emails", data: email)
            let response = try await ResendClient.httpClient!.execute(request: req ).get()
            // If the request was accepted, simply return
            guard response.status != .ok && response.status != .accepted else {
                let byteBuffer = response.body ?? ByteBuffer(.init())
                let emailResponse = try ResendClient.decoder.decode(ResendEmailResponse.self, from: byteBuffer)
                return emailResponse
            }
            
            // JSONDecoder will handle empty body by throwing decoding error
            let byteBuffer = response.body ?? ByteBuffer(.init())
            throw try ResendClient.decoder.decode(ResendRetrieveError.self, from: byteBuffer)

        }
        
        public func retrieve(id: String) async throws -> ResendEmail {
            let response = try await ResendClient.httpClient!.execute(request: ResendClient.makeRequest(method: .GET, route: "emails/\(id)")).get()
            // If the request was accepted, simply return
            guard response.status != .ok && response.status != .accepted else {
                let byteBuffer = response.body ?? ByteBuffer(.init())
                
                let email = try ResendClient.decoder.decode(ResendEmail.self, from: byteBuffer)
                return email
            }
            
            // JSONDecoder will handle empty body by throwing decoding error
            let byteBuffer = response.body ?? ByteBuffer(.init())
            throw try ResendClient.decoder.decode(ResendRetrieveError.self, from: byteBuffer)
        }
    }
}
