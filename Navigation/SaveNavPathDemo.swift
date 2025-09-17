//
//  SaveNavPathDemo.swift
//  Navigation
//
//  Created by Purnaman Rai (College) on 17/09/2025.
//

// If the user quits the app and comes back later, can we put them back exactly where they were in the navigation stack? just like Safari restores your open tabs.

import SwiftUI

@Observable
class NavPathStorage { // all the loading and saving of path data happens invisibly
//  var path: [Int] {
    var path: NavigationPath {
        didSet {
            savePath()
        }
    }
    
    private let pathURL = URL.documentsDirectory.appending(path: "SavedPath")
    
    func savePath() {
        // Following line required only when NavigationPath is used:
        
        // NavigationPath only requires types to be Hashable. But saving to disk requires them to also be Codable. As a result, Swift can't verify at compile time that there is a valid Codable representation of the navigation path, so we need to request it and see what comes back.
        guard let pathCodableRepresentation: NavigationPath.CodableRepresentation = path.codable else { return } // attempts to retrieve the Codable navigation path and bails out immediately if we get nothing back - it will either return the data ready to be encoded to JSON, or return 'nil' if at least one object in the path cannot be encoded.
        
        do {
        //  let encodedPath = try JSONEncoder().encode(path)
            let encodedPath = try JSONEncoder().encode(pathCodableRepresentation)
            try encodedPath.write(to: pathURL)
        } catch {
            print("Failed to save latest navigation state")
        }
    }
    
    init() {
        if let savedPath = try? Data(contentsOf: pathURL) {
        //  if let decodedPath = try? JSONDecoder().decode([Int].self, from: savedPath) {
            if let decodedPath = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: savedPath) {
            //  path = decodedPath
                path = NavigationPath(decodedPath)
                return
            }
        }
        
    //  path = []
        path = NavigationPath()
    }
}

struct NumberView: View {
    let number: Int
    
    var body: some View {
        NavigationLink("Go to Number \(number + 1)", value: number + 1)
            .navigationTitle("Number: \(number)")
    }
}

struct SaveNavPathDemo: View {
    @State private var navigation = NavPathStorage()
    let startingNumber = 0
    
    var body: some View {
        NavigationStack(path: $navigation.path) { // When the user navigates, navigation.path updates - triggers .didSet, which saves automatically - When the app restarts, init() restores the saved path.
            NumberView(number: startingNumber)
                .navigationDestination(for: Int.self) { nextNumber in
                    NumberView(number: nextNumber)
                }
        }
    }
}

#Preview {
    SaveNavPathDemo()
}
