//
//  Utils.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-04-02.
//

import Foundation

struct Utils {
    
    static func loadJSON(from classType: AnyClass, name: String) -> Data? {
        do {
            if let fileUrl = Bundle(for: classType.self).url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
}
