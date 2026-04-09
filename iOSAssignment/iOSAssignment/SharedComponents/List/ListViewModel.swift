//
//  ListViewModel.swift
//  iOSAssignment
//
//  Created by test on 09/04/26.
//

import SwiftUI

@MainActor
protocol ListViewModel<Item>:AnyObject, ObservableObject {
    associatedtype Item: Identifiable

    var items: [Item] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String { get set }
    var showError: Bool { get set }

    func loadItems() async
}
