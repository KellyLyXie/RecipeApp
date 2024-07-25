//
//  NetworkService.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//


import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    // Get All Dessert
    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(MealResponse.self, from: data)
        return response.meals
    }

    
    
    
    // Get the dessert details
    func fetchMealDetails(mealID: String) async throws -> MealDetail {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(MealDetailResponse.self, from: data)
        guard let mealDetail = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return mealDetail
    }

    struct MealDetailResponse: Decodable {
        let meals: [MealDetail]
    }
}
