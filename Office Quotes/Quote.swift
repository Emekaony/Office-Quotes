//
//  Quote.swift
//  Office Quotes
//
//  Created by SHAdON . on 1/28/23.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let firstName: String
    let lastName:String
    
    enum QuoteKeys: String, CodingKey {
        case data
        
        enum DayaKeys: String, CodingKey {
            case quote = "content"
            case character
            
            enum NameKeys: String, CodingKey {
                case firstName = "firstname"
                case lastName = "lastname"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuoteKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: QuoteKeys.DayaKeys.self, forKey: .data)
        quote = try dataContainer.decode(String.self, forKey: .quote)
        let charContainer = try dataContainer.nestedContainer(keyedBy: QuoteKeys.DayaKeys.NameKeys.self, forKey: .character)
        
        firstName = try charContainer.decode(String.self, forKey: .firstName)
        lastName = try charContainer.decode(String.self, forKey: .lastName)
        
    }
}
