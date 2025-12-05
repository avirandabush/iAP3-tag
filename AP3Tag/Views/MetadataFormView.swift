//
//  MetadataFormView.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 26/11/2025.
//

import SwiftUI
import ID3TagEditor

struct MetadataFormView: View {
    @ObservedObject var appVM: AppViewModel
    @State private var editableFile = FileMetadata()
    
    var body: some View {
        Group {
            if let selectedFile = appVM.selectedFile {
                ScrollView {
                    VStack {
                        Text("\(selectedFile.url.lastPathComponent)")
                            .font(.title)
                            .padding(16)
                        
                        Divider()
                        
                        if let _ = appVM.selectedFileMetadata {
                            metadataField(title: "Name", binding: $appVM.editableFile.title)
                            metadataField(title: "Artist", binding: $appVM.editableFile.artist)
                            metadataField(title: "Album", binding: $appVM.editableFile.album)
                            metadataField(title: "Album Artist", binding: $appVM.editableFile.albumArtist)
                            metadataField(title: "Composer", binding: $appVM.editableFile.composer)
                            
                            metadataField(title: "Conductor", binding: $appVM.editableFile.conductor)
                            metadataField(title: "Content Grouping", binding: $appVM.editableFile.contentGrouping)
                            metadataField(title: "Lyricist", binding: $appVM.editableFile.lyricist)
                            metadataField(title: "Mix Artist", binding: $appVM.editableFile.mixArtist)
                            metadataField(title: "Publisher", binding: $appVM.editableFile.publisher)
                            metadataField(title: "Subtitle", binding: $appVM.editableFile.subtitle)
                            metadataField(title: "Beats Per Minute", binding: .intBinding($appVM.editableFile.beatsPerMinute))
                            metadataField(title: "Original Filename", binding: $appVM.editableFile.originalFilename)
                            //                            metadataField(title: "Genre", binding: $appVM.editableFile.genre.description)
                            metadataSplitField(title: "Disc Position", bindingPart: .intBinding($appVM.editableFile.discPosition.part), bindingTotal: .intBinding($appVM.editableFile.discPosition.total))
                            metadataSplitField(title: "Track Position", bindingPart: .intBinding($appVM.editableFile.trackPosition.part), bindingTotal: .intBinding($appVM.editableFile.trackPosition.total))
                            metadataField(title: "Initial Key", binding: $appVM.editableFile.initialKey)
                            metadataStrictField(title: "Size In Bytes", value: "\(appVM.editableFile.sizeInBytes ?? 0)")
                            metadataStrictField(title: "Length In Milliseconds", value: "\(appVM.editableFile.lengthInMilliseconds ?? 0)")
                            metadataStrictField(title: "Copyright", value: appVM.editableFile.copyright)
                            metadataStrictField(title: "Encoded By", value: appVM.editableFile.encodedBy)
                            metadataStrictField(title: "Encoder Settings", value: appVM.editableFile.encoderSettings)
                            metadataStrictField(title: "File Owner", value: appVM.editableFile.fileOwner)
                        }
                        
                        Spacer()
                    }
                }
            } else {
                Text("Choose file to start.")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.4))
        .onAppear {
            if let url = self.appVM.selectedFile?.url {
                appVM.readMetadata(from: url)
                editableFile = appVM.selectedFileMetadata ?? FileMetadata()
            }
        }
        .onChange(of: appVM.selectedFile) { _, newValue in
            if let url = newValue?.url {
                appVM.readMetadata(from: url)
                editableFile = appVM.selectedFileMetadata ?? FileMetadata()
            } else {
                appVM.clearSelectedFile()
            }
        }
    }
    
    private func metadataStrictField(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 4) {
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .lineLimit(nil)
                .multilineTextAlignment(.trailing)
            
        }
        .padding(.top, 8)
    }
    
    private func metadataField(title: String, binding: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            
            TextField(title, text: binding)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.top, 8)
    }
    
    private func metadataSplitField(title: String, bindingPart: Binding<String>, bindingTotal: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            
            HStack {
                Text("Number")
                    .font(.caption)
                TextField(title, text: bindingPart)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 16)
                
                Text("From")
                    .font(.caption)
                TextField(title, text: bindingTotal)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.top, 8)
    }
}

extension Binding where Value == String {
    static func intBinding(_ intBinding: Binding<Int?>) -> Binding<String> {
        Binding<String>(
            get: { String(intBinding.wrappedValue ?? 0) },
            set: { intBinding.wrappedValue = Int($0) ?? 0 }
        )
    }
    
    static func intBinding(_ intBinding: Binding<Int>) -> Binding<String> {
        Binding<String>(
            get: { String(intBinding.wrappedValue) },
            set: { intBinding.wrappedValue = Int($0) ?? 0 }
        )
    }
}


#Preview {
    MetadataFormView(appVM: AppViewModel())
}
