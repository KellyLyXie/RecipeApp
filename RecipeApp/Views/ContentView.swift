//
//  ContentView.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                    Text(meal.name)
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMeals()
            }
        }
    }
}

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        VStack {
            if let meal = viewModel.selectedMeal {
                Text(meal.name)
                    .font(.largeTitle)
                    .padding()
                
                Text(meal.instructions)
                    .padding()
                
                List(meal.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchMealDetails(mealID: mealID)
                    }
            }
        }
        .navigationTitle("Meal Details")
    }
}
