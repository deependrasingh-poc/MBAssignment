//
//  UniversityDetailView.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import SwiftUI

struct UniversityDetailView: View {
    @Environment(\.dismiss) var dismiss
    let university: University

    var body: some View {
        content
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                backToolbarItem {
                        dismiss()
                    }
                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(Color.cyan, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
    }

    // MARK: - Main Content
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleSection
            countrySection
            stateSection
            websiteSection
            Spacer()
        }
    }
    
    @ToolbarContentBuilder
    func backToolbarItem(dismiss: @escaping () -> Void) -> some ToolbarContent {
        if #available(iOS 26.0, *) {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismiss) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            .sharedBackgroundVisibility(.hidden)
        } else {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismiss) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
        }
    }
    // MARK: - Sections
    @ViewBuilder
    private var titleSection: some View {
        Text(university.name)
            .font(.title)
            .bold()
    }

    @ViewBuilder
    private var countrySection: some View {
        Text("Country: \(university.country)")
    }

    @ViewBuilder
    private var stateSection: some View {
        if let state = university.stateProvince {
            Text("State: \(state)")
        }
    }

    @ViewBuilder
    private var websiteSection: some View {
        if !university.webPages.isEmpty {
            VStack(alignment: .leading, spacing: 4) {
                Text("Website:")
                    .font(.headline)
                ForEach(university.webPages, id: \.self) { page in
                    if let url = URL(string: page) {
                        Link(page, destination: url)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


