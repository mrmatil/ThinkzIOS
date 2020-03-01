// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let googleResponse = try? newJSONDecoder().decode(GoogleResponse.self, from: jsonData)

import Foundation

enum PurpleGoogleResponse: Codable {
    case string(String)
    case unionArrayArray([[GoogleResponseGoogleResponseUnion]])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([[GoogleResponseGoogleResponseUnion]].self) {
            self = .unionArrayArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(PurpleGoogleResponse.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PurpleGoogleResponse"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .unionArrayArray(let x):
            try container.encode(x)
        }
    }
}

enum GoogleResponseGoogleResponseUnion: Codable {
    case googleResponseClass(GoogleResponseClass)
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(GoogleResponseClass.self) {
            self = .googleResponseClass(x)
            return
        }
        throw DecodingError.typeMismatch(GoogleResponseGoogleResponseUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GoogleResponseGoogleResponseUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .googleResponseClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GoogleResponseClass
struct GoogleResponseClass: Codable {
    let isHTMLEscaped: Bool

    enum CodingKeys: String, CodingKey {
        case isHTMLEscaped = "is_html_escaped"
    }
}

typealias GoogleResponse = [PurpleGoogleResponse]

