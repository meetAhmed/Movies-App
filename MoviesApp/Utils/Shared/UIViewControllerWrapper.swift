//
//  UIViewControllerWrapper.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import SwiftUI
import UIKit

struct UIViewControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    let viewController: VC
    
    func makeUIViewController(context: Context) -> VC {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VC, context: Context) {}
}
