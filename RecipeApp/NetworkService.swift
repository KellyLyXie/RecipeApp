//
//  NetworkService.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meals: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealResponse.self, from: data)
                let meals = response.meals
                print("Fetched meals: \(meals)")
                completion(.success(meals))
            } catch {
                print("Error decoding meals: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }

    
    func fetchMealDetails(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meal details: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received."])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealDetailResponse.self, from: data)
                if let mealDetail = response.meals.first {
                    print("Fetched meal detail: \(mealDetail)")
                    completion(.success(mealDetail))
                } else {
                    print("No meal details found.")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No meal details found."])))
                }
            } catch {
                print("Error decoding meal details: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }

    struct MealDetailResponse: Decodable {
        let meals: [MealDetail]
    }

}
