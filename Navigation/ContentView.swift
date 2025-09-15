//
//  ContentView.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 15/09/2025.
//

import SwiftUI

struct DetailView: View {
    let passedNumber: Int
    
    var body: some View {
        Text("Detail View for \(passedNumber)")
    }
    
    init(forNumber passedNumber: Int) {
        print("Creating Detail View for \(passedNumber)")
        self.passedNumber = passedNumber
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Tap Me") {
                DetailView(forNumber: 7)
                // You can see the message ""Creating Detail..." in the console as SwiftUI immediately creates DetailView(forNumber: 7) — even if you never tap the link. It's because SwiftUI needs something concrete to attach to this NavigationLink, so it just builds the view right away.
                
                // This is usually fine for lightweight, static views. But it becomes problematic when:
                // - The detail view needs to be created only if the user navigates there.
                // - The destination view is heavy (lots of state, network calls, etc.)
                // - You have many destinations (like 1000 rows in a List).
                
                // PROBLEM: SwiftUI is eagerly building things that the user may never see - unnecessary CPU, Memory load
            }
            
            
            // SOLUTION: Instead of providing a full View immediately, you can provide just the data (state) that describes what you want to navigate to, and let SwiftUI build the detail view on demand.
            List(0..<10) { number in
                NavigationLink("Select \(number)", value: number) // Instead of directly embedding a View for the destination, you attach a value
            }
            .navigationDestination(for: Int.self) { selectedNumber in // “Whenever a NavigationLink has an Int value (it gives us that value in the 'selectedNumber' constant), here’s how to build the destination view.”
                DetailView(forNumber: selectedNumber)
            }
            .navigationDestination(for: String.self) { text in // we can stack them - like saying "do this when you want to navigate to an Int, but do that when you want to navigate to a String."
                Text("String: \(text)")
            }
        }
    }
}

// NavigationLink("Select student", value: someStudent)
// Here, SwiftUI needs a way to:
// - Uniquely identify someStudent inside the navigation system.
// - Compare it to other students so it knows whether you’re still looking at the same detail view or a new one.
// To do this efficiently, SwiftUI doesn’t want to compare every property (like name, age, etc.) one by one each time.
// Instead, it uses a hash value — a small, consistent “fingerprint” of your data.

// Hashing is a computer science term that is the process of converting some data into a smaller representation in a consistent way. It's commonly used when downloading data: you download a movie, it's size is 10GB, but how can you be sure every single piece of data got downloaded successfully? With hashing, we can convert that 10GB movie into a short string – maybe 40 characters in total – that uniquely identifies it. The hash function needs to be consistent, which means if we hash the movie locally and compare it to the hash on the server, they should always be the same, and comparing two 40-character strings is much easier than comparing two 10GB files! Obviously there's no way to unhash data, because you can't convert just 40 characters back into a 10GB movie.

// Swift uses Hashable a lot internally. For example, when you use a Set rather than an array, everything you put in there must conform to the Hashable protocol. This is what makes sets so fast compared to arrays: when you say "does the set contain this particular object?" Swift will compute the hash of your object, then search for that in the set rather than trying to compare every property against every object.

#Preview {
    ContentView()
}
