//
//  OutputView.swift
//  HeraAI
//
//  Created by ali arvas on 9.07.2024.
//

import SwiftUI

struct OutputView: View {
    let imageUrl: String
    
    var body: some View {
        VStack {
            Text("Generated Image")
                .font(.largeTitle)
                .padding()
            
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if phase.error != nil {
                        Text("Failed to load image")
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            } else {
                Text("Invalid URL")
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Output", displayMode: .inline)
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(imageUrl: "https://replicate.com/api/models/stability-ai/stable-diffusion/files/50fcac81-865d-499e-81ac-49de0cb79264/out-0.png")
    }
}
