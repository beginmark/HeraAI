//
//  UserInputView.swift
//  HeraAI
//
//  Created by ali arvas on 8.07.2024.
//

import SwiftUI

struct UserInputView: View {
    @StateObject private var viewModel = UserInputViewModel()
    @State private var isImagePicker1Presented = false
    @State private var isImagePicker2Presented = false
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        if let image1 = viewModel.userInput.image1 {
                            Image(uiImage: image1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .border(Color.gray, width: 1)
                        } else {
                            Button(action: {
                                isImagePicker1Presented = true
                            }) {
                                Text("Select Image 1")
                                    .frame(width: 100, height: 100)
                                    .border(Color.gray, width: 1)
                            }
                            .sheet(isPresented: $isImagePicker1Presented) {
                                ImagePicker(selectedImage: $viewModel.userInput.image1)
                            }
                        }
                    }
                    
                    VStack {
                        if let image2 = viewModel.userInput.image2 {
                            Image(uiImage: image2)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .border(Color.gray, width: 1)
                        } else {
                            Button(action: {
                                isImagePicker2Presented = true
                            }) {
                                Text("Select Image 2")
                                    .frame(width: 100, height: 100)
                                    .border(Color.gray, width: 1)
                            }
                            .sheet(isPresented: $isImagePicker2Presented) {
                                ImagePicker(selectedImage: $viewModel.userInput.image2)
                            }
                        }
                    }
                }
                
                TextField("Enter prompt", text: $viewModel.userInput.prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.generateImage {
                        shouldNavigate = true
                    }
                }) {
                    Text("Generate Image")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: OutputView(imageUrl: viewModel.outputImageUrl ?? ""), isActive: $shouldNavigate) {
                    EmptyView()
                }
            }
            .padding()
            .alert(item: $viewModel.alertMessage) { alertMessage in
                Alert(title: Text("Result"), message: Text(alertMessage.message), dismissButton: .default(Text("OK")))
            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            OutputView(imageUrl: viewModel.outputImageUrl ?? "")
        }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
