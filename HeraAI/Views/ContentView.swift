//
//  ContentView.swift
//  HeraAI
//
//  Created by ali arvas on 8.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to HeraAI")
                    .font(.largeTitle)
                    .padding()

                Text("Generate amazing images by combining your own pictures with AI-generated enhancements. Get started by uploading your images and providing a prompt!")
                    .font(.body)
                    .padding()

                NavigationLink(destination: UserInputView()) {
                    Text("Get Started")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("HeraAI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
