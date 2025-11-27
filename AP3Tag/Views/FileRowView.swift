//
//  FileRowView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI

struct FileRowView: View {
    let url: URL
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "music.note")
                    .foregroundStyle(.blue)
                
                Text(url.lastPathComponent)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.vertical, 4)
            
            Divider()
        }
    }
}

#Preview {
    FileRowView(url: URL(string: "http://example.com/file.mp3")!)
}
