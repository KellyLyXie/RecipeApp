//
//  ContentView.swift
//  RecipeApp
//
//  Created by 谢璐阳 on 7/24/24.
//
import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                        HStack {
                            AsyncImage(url: URL(string: meal.thumbnail), transaction: .init(animation: .default)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(width: 50, height: 50)
                                         .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                @unknown default:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Text(meal.name)
                                .font(.headline)
                                .padding(.leading, 10)
                        }
                    }
                }
            }
            .navigationTitle("Desserts Menu")
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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let meal = viewModel.selectedMeal {
                    Text(meal.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.bottom, 10)
                    
                    AsyncImage(url: URL(string: meal.thumbnail)) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: .infinity)
                             .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Group {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .padding(.top, 20)
                        
                        Text(meal.instructions)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.top, 10)
                            .lineSpacing(5)
                    }
                    
                    Group {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .padding(.top, 20)
                        
                        ForEach(meal.ingredients, id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.leading, 10)
                                .padding(.bottom, 5)
                        }
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            viewModel.fetchMealDetails(mealID: mealID)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}

#Preview {
    MealDetailView(mealID: "52901")
}
