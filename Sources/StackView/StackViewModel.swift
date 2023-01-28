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
        push(viewModel, style: .instant)
    }
    
    public func push(_ viewModel: any StackableViewModel, transition: AnyTransition) {
        
        var viewModel = viewModel
        viewModel.stackViewModel = self
        let stackItem = StackItem(viewModel: viewModel, transition: transition, zIndex: Double(stack.count))
        
        withAnimation {

            stack.append(stackItem)
        }
    }
    
    public func push(_ viewModel: any StackableViewModel, style: TransitionStyle) {
        
        push(viewModel, transition: style.transition)
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

//MARK: - Types

extension StackViewModel {
    
    struct StackItem: Identifiable {
        
        let id = UUID()
        let viewModel: any StackableViewModel
        var transition: AnyTransition
        var zIndex: Double
    }
}

public extension StackViewModel {
    
    enum TransitionStyle {
        
        case sheet
        case link
        case alert
        case opacity
        case instant
        
        var transition: AnyTransition {
            
            switch self {
            case .sheet: return .move(edge: .bottom)
            case .link: return .move(edge: .trailing)
            case .alert: return .asymmetric(insertion: .scale.animation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.25)), removal: .scale.combined(with: .opacity))
            case .opacity: return .opacity
            case .instant: return .opacity.animation(.linear(duration: 0.01))
            }
        }
    }
    
}
