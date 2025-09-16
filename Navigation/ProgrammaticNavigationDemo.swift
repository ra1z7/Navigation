//
//  ProgrammaticNavigationDemo.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 16/09/2025.
//

import SwiftUI

struct ProgrammaticNavigationDemo: View {
    @State private var path = [Int]() // This array acts as a history of what the user is looking at.
    // If it’s empty → the user is at the root view.
    // If it contains [32] → SwiftUI shows the root view, then pushes the view for 32.
    // If it contains [32, 64] → SwiftUI shows the root, then 32, then 64.
    
    var body: some View {
        NavigationStack(path: $path) { // This means the stack follows whatever is in the array.
            // When user taps Back → SwiftUI removes the last element.
            VStack {
                Button("Show 32") {
                    path = [32] // Replace the entire path with [32] - If you were deep in the stack, this resets back to root, then pushes 32.
                }
                
                Button("Show 64") {
                    path.append(64) // Add 64 to the current path - If you were already on 32, now the stack shows: root → 32 → 64
                }
                
                Button("Show 32 then 64") {
                    path = [32, 64] // Directly sets the path to two steps deep - User would need to hit Back twice to return to the root.
                }
                
                Button("Print Path Array") {
                    print(path)
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You Selected \(selection)")
                
                Button("Append 64") {
                    path.append(64)
                }
                
                Button("Print Path Array") {
                    print(path)
                }
                
                Button("Show Root") {
                    path = []
                }
                
                Button("Show 32 then 64") {
                    path = [32, 64]
                }
            }
        }
    }
}

#Preview {
    ProgrammaticNavigationDemo()
}
