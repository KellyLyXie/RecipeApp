//
//  MealDetail.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//
import Foundation

struct MealDetail: Decodable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        let rawValues = try decoder.singleValueContainer().decode([String: String?].self)
        var ingredients: [String] = []
        for i in 1...20 {
            if let ingredient = rawValues["strIngredient\(i)"] as? String, !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
        }
        self.ingredients = ingredients
    }
}
