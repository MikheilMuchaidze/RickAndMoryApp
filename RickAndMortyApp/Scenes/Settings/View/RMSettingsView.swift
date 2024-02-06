//
//  RMSettingsView.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 06.02.24.
//

import SwiftUI

struct RMSettingsView: View {
    private let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(viewModel.imageContainerColor))
                        .cornerRadius(6)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 5)
            .padding(.top, 5)
            .frame(height: 40, alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
        .scrollDisabled(true)
    }
}

#Preview {
    RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap { RMSettingsCellViewViewModel(type: $0, onTapHandler: {_ in }) }))
}
