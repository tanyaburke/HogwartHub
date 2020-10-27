//
//  Model.swift
//  HogwartHub
//
//  Created by Tanya Burke on 10/27/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation


struct Characters: Codable {
    let name: String
    let species: Species
    let gender: Gender
    let house: String
    let dateOfBirth: String
    let yearOfBirth: YearOfBirth
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alive: Bool
    let image: String
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

enum Species: String, Codable {
    case cat = "cat"
    case halfGiant = "half-giant"
    case human = "human"
    case werewolf = "werewolf"
}

struct Wand: Codable {
    let wood: String
    let core: String
    let length: Length
}

enum Length: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Length.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Length"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum YearOfBirth: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(YearOfBirth.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for YearOfBirth"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }




static func houseSections(characters: [Characters]) -> [[Characters]] {
    let sortedCharacters = characters.sorted {$0.house < $1.house}
    
    let uniqueHouse = Set(sortedCharacters.map{$0.house})
    
    var sections = Array(repeating: [Characters](), count: uniqueHouse.count)
    var currentIndex = 0
    var currentHouse = sortedCharacters.first?.house ?? "None"
    
    for character in sortedCharacters{
        if character.house == currentHouse {
            sections[currentIndex].append(character)
        } else{
            currentIndex += 1
            currentHouse = character.house
        }
    }
    
   return sections
}
}

