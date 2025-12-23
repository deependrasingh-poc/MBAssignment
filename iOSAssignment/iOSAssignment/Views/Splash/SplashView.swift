//
//  SplashView.swift
//  iOSAssignment
//
//  Created by test on 23/12/25.
//
import SwiftUICore

struct SplashView: View {
    var body: some View {
        titleSection
    }
    
    @ViewBuilder
    private var titleSection: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("iOS Assignment")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

