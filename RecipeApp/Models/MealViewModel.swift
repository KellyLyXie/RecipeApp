//
//  MealViewModel.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: MealDetail?
    
    func fetchMeals() {
        Task {
            do {
//                let meals = try await NetworkService.shared.fetchMeals()
                var meals = try await NetworkService.shared.fetchMeals()
                meals.sort { $0.name < $1.name }
                DispatchQueue.main.async {
                    self.meals = meals
                }
            } catch {
                print("Error fetching meals: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMealDetails(mealID: String) {
        Task {
            do {
                let mealDetail = try await NetworkService.shared.fetchMealDetails(mealID: mealID)
                DispatchQueue.main.async {
                    self.selectedMeal = mealDetail
                }
            } catch {
                print("Error fetching meal details: \(error.localizedDescription)")
            }
        }
    }
}
