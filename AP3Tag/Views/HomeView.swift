//
//  HomeView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack {
            HSplitView {
                FilesView(viewModel: viewModel)
                    .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity)
                
                MetadataFormView(appVM: viewModel)
                    .frame(width: 400)
            }
            .frame(minWidth: 1000, minHeight: 500)
            
            if viewModel.showToast {
                VStack {
                    Spacer()
                    
                    if viewModel.showToast {
                        Text(viewModel.toastMessage)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(.black.opacity(0.85))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.bottom, 30)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .animation(.easeInOut(duration: 0.25), value: viewModel.showToast)
            }
        }
        
        .navigationTitle("")
        
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                LeftToolbar(viewModel: viewModel)
            }
            
            ToolbarItem(placement: .principal) {
                Text("AP3Tag - Files Metadata Editor")
                    .padding()
            }
            
            ToolbarItem(placement: .automatic) {
                RightToolbar(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: AppViewModel())
}
