//
//  EditableNavTitle.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 19/09/2025.
//

import SwiftUI

struct EditableNavTitle: View {
    @State private var navigationTitle = "SwiftUI"

    var body: some View {
        NavigationStack {
            List {
                NavigationLink(navigationTitle) {
                    Text("Detail View for \(navigationTitle)")
                        .navigationTitle($navigationTitle)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationTitle("Editable Title")
        }

        // This is great for times when that title reflects the name of something entered by the user, because it means you don't need to add an extra textfield to your layout.
    }
}

#Preview {
    EditableNavTitle()
}
