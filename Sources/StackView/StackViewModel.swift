//
//  StackViewModel.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import SwiftUI

public class StackViewModel: ViewModel, ObservableObject {

    public let id: UUID = UUID()
    public let viewType = StackView.self

    @Published var stack: [StackItem]

    init(stack: [StackItem]) {

        self.stack = stack
    }
    
    public convenience init(viewModel: any StackableViewModel) {
        
        self.init(stack: [])
        push(viewModel)
    }
    
    public func push<V>(_ viewModel: V) where V : StackableViewModel {
        
        var viewModel = viewModel
        viewModel.stackViewModel = self
        let stackItem = StackItem(viewModel: viewModel, transition: .move(edge: .trailing), zIndex: Double(stack.count))
        
        withAnimation {

            stack.append(stackItem)
        }
    }
    
    public func pop() {
        
        withAnimation {
            
            let _ = stack.popLast()
        }
    }
    
    public func popToRoot() {
        
        withAnimation {
            
            stack = stack.filter({ $0.id == stack.first?.id })
        }
    }

    func reduce(items: [StackItem], transition: AnyTransition) -> [StackItem] {
        
        items.map { item in
            
            var updatedItem = item
            updatedItem.transition = transition
            
            return updatedItem
        }
    }
}

struct StackItem: Identifiable {

    let id = UUID()
    let viewModel: any StackableViewModel
    var transition: AnyTransition
    var zIndex: Double
}
