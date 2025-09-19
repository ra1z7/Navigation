//
//  ToolbarPlacements.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 19/09/2025.
//

import SwiftUI

struct ToolbarPlacements: View {
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(0..<10) { rowNum in
                NavigationLink(value: rowNum) {
                    Text("Row \(rowNum)")
                }
            }
            .navigationDestination(for: Int.self) { selectedRowNum in
                Text("Detail View for Row \(selectedRowNum)")
                    .navigationBarBackButtonHidden() // Hides the default back button
                    .toolbar {
                        ToolbarItemGroup(placement: .navigation) { // used for buttons that make the user move between data, such as going back and forward in a web browser.
                            Button("Custom Back Button", systemImage: "chevron.backward.circle") {
                                path = []
                            }
                            Button("Custom Forward Button", systemImage: "chevron.forward.circle") {
                                // code to go forward
                            }
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .destructiveAction) { // when the user needs to make a choice to destroy whatever it is they are working with, such as confirming they want to remove some data they created.
                    Button("Delete") {}
                }

                ToolbarItem(placement: .confirmationAction) { // when you want users to agree to something, such as agreeing to terms of service.
                    Button("Confirm") {}
                }

                ToolbarItem(placement: .cancellationAction) { // when the user needs to back out of changes they have made, such as discarding changes they have made.
                    Button("Cancel") {}
                }
                
                // These semantic placements come with two important benefits:
                //   - Because iOS has extra information about what your buttons do, it can add extra styling – a confirmation button can be rendered in bold, for example.
                //   - Second, these positions automatically adapt on other platforms, so your button will always appear in the correct place on iOS, macOS, watchOS, and more.
            }
        }
    }
}

#Preview {
    ToolbarPlacements()
}
