//
//  LatinWordsDtailView.swift
//  challange
//
//  Created by Inti Albuquerque on 21/06/22.
//

import SwiftUI

struct LatinWordsDetailView: View {
    let title: String
    let content: String
    var body: some View {
        ScrollView {
            LazyVStack {
                Text(content)
                    .lineLimit(nil)
            }
        }
        .padding(30)
        .navigationTitle(Text(title))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct LatinWordsDtailView_Previews: PreviewProvider {
    static var previews: some View {
        LatinWordsDetailView(title: "test", content: "test")
    }
}
