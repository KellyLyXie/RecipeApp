//
//  MealViewModel.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//

import SwiftUI
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: MealDetail?
    
    func fetchMeals() {
        NetworkService.shared.fetchMeals { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals
                case .failure(let error):
                    print("Error fetching meals: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchMealDetails(mealID: String) {
        NetworkService.shared.fetchMealDetails(mealID: mealID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetail):
                    self.selectedMeal = mealDetail
                case .failure(let error):
                    print("Error fetching meal details: \(error.localizedDescription)")
                }
            }
        }
    }
}
