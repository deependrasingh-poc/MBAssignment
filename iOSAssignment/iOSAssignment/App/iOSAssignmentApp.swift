//
//  iOSAssignmentApp.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import SwiftUI

@main
struct iOSAssignmentApp: App {
    
    @State private var showSplash = true
    @StateObject private var universityViewModel =
            UniversityViewModel(service: UniversityService())

       var body: some Scene {
           WindowGroup {
               if showSplash {
                   SplashView()
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               showSplash = false
                           }
                       }
               } else {
                   UniversityListView(viewModel: universityViewModel)
               }
           }
       }
}
