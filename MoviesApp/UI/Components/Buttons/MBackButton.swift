//
//  CustomBackButton.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 18/07/2024.
//

import SwiftUI

struct MBackButton: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(Color.appBackground.opacity(0.5))
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 5)
                    }
                }
            }
    }
}
