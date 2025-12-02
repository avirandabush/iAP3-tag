//
//  MetadataService.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 02/12/2025.
//

import Foundation
import ID3TagEditor

class MetadataService {
    let tagEditor = ID3TagEditor()
    
    func readMetadata(from url: URL?) -> FileMetadata? {
        guard let url else { return nil }
        var metadata = FileMetadata()
        
        do {
            let tag = try tagEditor.read(from: url.path)
            
            if let title = tag?.frames[.title] as? ID3FrameWithStringContent {
                metadata.title = title.content
            }
            if let artist = tag?.frames[.artist] as? ID3FrameWithStringContent {
                metadata.artist = artist.content
            }
            if let album = tag?.frames[.album] as? ID3FrameWithStringContent {
                metadata.album = album.content
            }
            if let subtitle = tag?.frames[.subtitle] as? ID3FrameWithStringContent {
                metadata.subtitle = subtitle.content
            }
            if let genre = tag?.frames[.genre] as? ID3FrameGenre {
                metadata.genre.description = genre.description
            }
        } catch {
            print("Failed to read tag: \(error)")
        }
        
        return metadata
    }
    
    func writeMetadata(_ metadata: FileMetadata, at url: URL?) {
        guard let url else { return }
        
        let allowed = url.startAccessingSecurityScopedResource()
        defer { if allowed { url.stopAccessingSecurityScopedResource() } }
        
        do {
            if let oldTag = try tagEditor.read(from: url.path) {
                oldTag.frames[.title] = ID3FrameWithStringContent(content: metadata.title)
                oldTag.frames[.artist] = ID3FrameWithStringContent(content: metadata.artist)
                oldTag.frames[.album] = ID3FrameWithStringContent(content: metadata.album)
                
                try tagEditor.write(tag: oldTag, to: url.path)
            } else {
                let builder = ID32v3TagBuilder()
                _ = builder.title(frame: ID3FrameWithStringContent(content: metadata.title))
                _ = builder.artist(frame: ID3FrameWithStringContent(content: metadata.artist))
                _ = builder.album(frame: ID3FrameWithStringContent(content: metadata.album))
                
                let newTag = builder.build()
                try tagEditor.write(tag: newTag, to: url.path)
            }
        } catch {
            print("Failed to write tag: \(error)")
        }
    }
}
