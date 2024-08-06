//
//  ReviewCard.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: review.authorImage)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ZStack {
                        Color.placeholder
                        
                        if let firstChar = review.authorName.first {
                            Text(String(firstChar))
                        }
                    }
                }
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                
                Text(review.authorName)
                    .poppins(.bold, 16)
            }
            
            Text(review.content.trim())
                .poppins(.light)
            
            Divider()
        }
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(review: dev.review)
    }
}
