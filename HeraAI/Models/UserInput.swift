//
//  Input.swift
//  HeraAI
//
//  Created by ali arvas on 8.07.2024.
//

import SwiftUI

struct UserInput: Identifiable {
    let id = UUID()
    var image1: UIImage?
    var image2: UIImage?
    var prompt: String
}
