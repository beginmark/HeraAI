//
//  UserInputViewModel.swift
//  HeraAI
//
//  Created by ali arvas on 8.07.2024.
//

import SwiftUI
import Replicate
import Foundation

struct ReplicateOutput: Codable {
    let output: [String]
}

class UserInputViewModel: ObservableObject {
    @Published var userInput = UserInput(image1: nil, image2: nil, prompt: "")
    @Published var outputImageUrl: String?
    @Published var alertMessage: AlertMessage?

    private let replicate = Replicate.Client(token: "YOUR_API_TOKEN")

    func setImage1(_ image: UIImage) {
        DispatchQueue.main.async {
            self.userInput.image1 = image
        }
    }
    
    func setImage2(_ image: UIImage) {
        DispatchQueue.main.async {
            self.userInput.image2 = image
        }
    }
    
    func setPrompt(_ prompt: String) {
        DispatchQueue.main.async {
            self.userInput.prompt = prompt
        }
    }
    
    func clearInputs() {
        DispatchQueue.main.async {
            self.userInput = UserInput(image1: nil, image2: nil, prompt: "")
        }
    }

    func generateImage(completion: @escaping () -> Void) {
        guard let image1 = userInput.image1,
              let image2 = userInput.image2,
              !userInput.prompt.isEmpty else {
            DispatchQueue.main.async {
                self.alertMessage = AlertMessage(message: "Please provide two images and a prompt.")
            }
            return
        }
        
        Task {
            do {
                let model = try await replicate.getModel("stability-ai/stable-diffusion")
                if let latestVersion = model.latestVersion {
                    let image1Data = image1.jpegData(compressionQuality: 0.8)!
                    let image2Data = image2.jpegData(compressionQuality: 0.8)!
                    let image1Encoded = image1Data.uriEncoded(mimeType: "image/jpeg")
                    let image2Encoded = image2Data.uriEncoded(mimeType: "image/jpeg")
                    
                    let input: [String: Replicate.Value] = [
                        "prompt": .string(userInput.prompt),
                        "image1": .string(image1Encoded),
                        "image2": .string(image2Encoded)
                    ]
                    
                    let prediction = try await replicate.run("stability-ai/stable-diffusion:latest", input: input, ReplicateOutput.self)
                    
                    if let outputUrl = prediction?.output.first {
                        DispatchQueue.main.async {
                            self.outputImageUrl = outputUrl
                            completion()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.alertMessage = AlertMessage(message: "No output URL found.")
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.alertMessage = AlertMessage(message: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct AlertMessage: Identifiable {
    let id = UUID()
    let message: String
}
