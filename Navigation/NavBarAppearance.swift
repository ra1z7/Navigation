//
//  NavBarAppearance.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 18/09/2025.
//

import SwiftUI

struct NavBarAppearance: View {
    var body: some View {
        NavigationStack {
            List(0..<10) { number in
                Text("Row \(number)")
            }
            .navigationTitle("Title Goes Here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue) // this is only visible when the list scrolls under the navigation bar
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    NavBarAppearance()
}
