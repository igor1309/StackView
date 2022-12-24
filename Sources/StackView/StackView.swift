//
//  StackView.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import SwiftUI

public struct StackView: View {

    @ObservedObject private var viewModel: StackViewModel
    @Namespace private var namespace

    public init(viewModel: StackViewModel) {
        
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        ZStack {
            
            ForEach(viewModel.stack) { item in

                createStackableView(item.viewModel, namespace: namespace)
                    .transition(item.transition)
                    .zIndex(item.zIndex)
            }
        }
    }
}

extension StackView {
    
    func createStackableView(_ viewModel: any StackableViewModel, namespace: Namespace.ID) -> some View {

        AnyView(createAnyStackableView(viewModel, namespace: namespace))
    }
    
    func createAnyStackableView(_ viewModel: some StackableViewModel, namespace: Namespace.ID) -> any View {
        
        viewModel.viewType.init(viewModel: viewModel, namespace: namespace)
    }
}
