// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let azureResponse = try? newJSONDecoder().decode(AzureResponse.self, from: jsonData)

import Foundation


// MARK: - ErrorEnum
enum AzureResponseErrors:Error{
    
    case noFreeTry
}

// MARK: - AzureResponse
struct AzureResponse: Codable {
    let recognitionUnits: [RecognitionUnit]
}

// MARK: - RecognitionUnit
struct RecognitionUnit: Codable {
    let id: Int
    let recognizedText: String?
    let parentID: Int
    let category: String
    let boundingRectangle: BoundingRectangle
    let recognitionUnitClass: String
    let strokeIDS: [Int]
    let rotatedBoundingRectangle: [RotatedBoundingRectangle]
    let alternates: [Alternate]?
    let childIDS: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, recognizedText
        case parentID = "parentId"
        case category, boundingRectangle
        case recognitionUnitClass = "class"
        case strokeIDS = "strokeIds"
        case rotatedBoundingRectangle, alternates
        case childIDS = "childIds"
    }
}

// MARK: - Alternate
struct Alternate: Codable {
    let category: Category
    let recognizedString: String
}

enum Category: String, Codable {
    case inkWord = "inkWord"
    case line = "line"
}

// MARK: - BoundingRectangle
struct BoundingRectangle: Codable {
    let topX, width, height, topY: Double
}

// MARK: - RotatedBoundingRectangle
struct RotatedBoundingRectangle: Codable {
    let x, y: Double
}
