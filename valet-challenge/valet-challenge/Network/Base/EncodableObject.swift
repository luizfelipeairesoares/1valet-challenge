//
//  EncodableObject.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

struct EncodableObject: Encodable {
    
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
    
}
