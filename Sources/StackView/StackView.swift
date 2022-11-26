//
//  StackView.swift
//  
//
//  Created by Max Gribov on 26.11.2022.
//

import SwiftUI

public struct StackView: View {

    @ObservedObject var viewModel: StackViewModel

    public init(viewModel: StackViewModel) {
        
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        ZStack {
            
            ForEach(viewModel.stack) { item in

                createStackableView(item.viewModel)
                    .transition(item.transition)
                    .zIndex(item.zIndex)
            }
        }
    }
}

extension StackView {
    
    func createStackableView(_ viewModel: any StackableViewModel) -> some View {

        AnyView(createAnyStackableView(viewModel))
    }
    
    func createAnyStackableView(_ viewModel: some StackableViewModel) -> any View {
        
        viewModel.viewType.init(viewModel: viewModel)
    }
}
