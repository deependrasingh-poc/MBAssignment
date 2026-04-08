//
//  UniversityDetailView.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import SwiftUI

struct UniversityDetailView: View {

    let university: University

    var body: some View {
        content
            .padding()
            .navigationTitle("Details")
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
        ForEach(university.webPages, id: \.self) { page in
            if let url = URL(string: page) {
                HStack(spacing: 4) {
                    Text("Website:")
                        .font(.headline)

                    Link(page, destination: url)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


