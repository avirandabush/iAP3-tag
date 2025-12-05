//
//  MetadataService.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 02/12/2025.
//

import Foundation
import AVFoundation
import ID3TagEditor

class MetadataService {
    let tagEditor = ID3TagEditor()
    
    func readMetadata(from url: URL?) -> OperationResult<FileMetadata>? {
        guard let url else { return OperationResult(success: false, message: "Invalid file URL.") }
        
        var metadata = FileMetadata()
        
        do {
            let tag = try tagEditor.read(from: url.path)
            
            if let title = tag?.frames[.title] as? ID3FrameWithStringContent {
                metadata.title = title.content
            }
            
            if let album = tag?.frames[.album] as? ID3FrameWithStringContent {
                metadata.album = album.content
            }
            
            if let albumArtist = tag?.frames[.albumArtist] as? ID3FrameWithStringContent {
                metadata.albumArtist = albumArtist.content
            }
            
            if let artist = tag?.frames[.artist] as? ID3FrameWithStringContent {
                metadata.artist = artist.content
            }
            
            if let composer = tag?.frames[.composer] as? ID3FrameWithStringContent {
                metadata.composer = composer.content
            }
            
            if let conductor = tag?.frames[.conductor] as? ID3FrameWithStringContent {
                metadata.conductor = conductor.content
            }
            
            if let contentGrouping = tag?.frames[.contentGrouping] as? ID3FrameWithStringContent {
                metadata.contentGrouping = contentGrouping.content
            }
            
            if let copyright = tag?.frames[.copyright] as? ID3FrameWithStringContent {
                metadata.copyright = copyright.content
            }
            
            if let encodedBy = tag?.frames[.encodedBy] as? ID3FrameWithStringContent {
                metadata.encodedBy = encodedBy.content
            }
            
            if let encoderSettings = tag?.frames[.encoderSettings] as? ID3FrameWithStringContent {
                metadata.encoderSettings = encoderSettings.content
            }
            
            if let fileOwner = tag?.frames[.fileOwner] as? ID3FrameWithStringContent {
                metadata.fileOwner = fileOwner.content
            }
            
            if let lyricist = tag?.frames[.lyricist] as? ID3FrameWithStringContent {
                metadata.lyricist = lyricist.content
            }
            
            if let mixArtist = tag?.frames[.mixArtist] as? ID3FrameWithStringContent {
                metadata.mixArtist = mixArtist.content
            }
            
            if let publisher = tag?.frames[.publisher] as? ID3FrameWithStringContent {
                metadata.publisher = publisher.content
            }
            
            if let subtitle = tag?.frames[.subtitle] as? ID3FrameWithStringContent {
                metadata.subtitle = subtitle.content
            }
            
            if let beatsPerMinute = tag?.frames[.beatsPerMinute] as? ID3FrameWithStringContent {
                metadata.beatsPerMinute = beatsPerMinute.size
            }
            
            if let originalFilename = tag?.frames[.originalFilename] as? ID3FrameWithStringContent {
                metadata.originalFilename = originalFilename.content
            }
            
            if let lengthInMilliseconds = tag?.frames[.lengthInMilliseconds] as? ID3FrameWithStringContent {
                metadata.lengthInMilliseconds = lengthInMilliseconds.size
            }
            
            if let sizeInBytes = tag?.frames[.sizeInBytes] as? ID3FrameWithIntegerContent {
                metadata.sizeInBytes = sizeInBytes.value
            }
            
            if let genre = tag?.frames[.genre] as? ID3FrameGenre {
                metadata.genre.description = genre.description
            }
            
            if let discPosition = tag?.frames[.discPosition] as? ID3FramePartOfTotal {
                metadata.discPosition = discPosition
            }
            
            if let trackPosition = tag?.frames[.trackPosition] as? ID3FramePartOfTotal {
                metadata.trackPosition = trackPosition
            }
            
            if let initialKey = tag?.frames[.initialKey] as? ID3FrameWithStringContent {
                metadata.initialKey = initialKey.content
            }
            
            return OperationResult(success: true, message: "", value: metadata)
        } catch {
            return OperationResult(success: false, message: "Failed to read file's metadata.", value: metadata)
        }
    }
    
    func writeMetadata(_ metadata: FileMetadata, at url: URL?) -> OperationResult<Void> {
        guard let url else {
            return OperationResult(success: false, message: "Invalid file URL.")
        }
        
        let allowed = url.startAccessingSecurityScopedResource()
        defer { if allowed { url.stopAccessingSecurityScopedResource() } }
        
        do {
            let fileSize = try FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int ?? 0
            
            if let oldTag = try tagEditor.read(from: url.path) {
                
                oldTag.frames[.title] = ID3FrameWithStringContent(content: metadata.title)
                oldTag.frames[.album] = ID3FrameWithStringContent(content: metadata.album)
                oldTag.frames[.albumArtist] = ID3FrameWithStringContent(content: metadata.albumArtist)
                oldTag.frames[.artist] = ID3FrameWithStringContent(content: metadata.artist)
                oldTag.frames[.composer] = ID3FrameWithStringContent(content: metadata.composer)
                oldTag.frames[.conductor] = ID3FrameWithStringContent(content: metadata.conductor)
                oldTag.frames[.contentGrouping] = ID3FrameWithStringContent(content: metadata.contentGrouping)
                oldTag.frames[.copyright] = ID3FrameWithStringContent(content: metadata.copyright)
                oldTag.frames[.encodedBy] = ID3FrameWithStringContent(content: metadata.encodedBy)
                oldTag.frames[.encoderSettings] = ID3FrameWithStringContent(content: metadata.encoderSettings)
                oldTag.frames[.fileOwner] = ID3FrameWithStringContent(content: metadata.fileOwner)
                oldTag.frames[.lyricist] = ID3FrameWithStringContent(content: metadata.lyricist)
                oldTag.frames[.mixArtist] = ID3FrameWithStringContent(content: metadata.mixArtist)
                oldTag.frames[.publisher] = ID3FrameWithStringContent(content: metadata.publisher)
                oldTag.frames[.subtitle] = ID3FrameWithStringContent(content: metadata.subtitle)
                oldTag.frames[.originalFilename] = ID3FrameWithStringContent(content: metadata.originalFilename)
                
                oldTag.frames[.beatsPerMinute] = ID3FrameWithIntegerContent(value: metadata.beatsPerMinute)
                oldTag.frames[.lengthInMilliseconds] = ID3FrameWithIntegerContent(value: metadata.lengthInMilliseconds)
                oldTag.frames[.sizeInBytes] = ID3FrameWithIntegerContent(value: fileSize)
                
                oldTag.frames[.genre] = ID3FrameGenre(
                    genre: metadata.genre.identifier,
                    description: metadata.genre.description
                )
                
                oldTag.frames[.discPosition] = ID3FramePartOfTotal(
                    part: metadata.discPosition.part,
                    total: metadata.discPosition.total
                )
                
                oldTag.frames[.trackPosition] = ID3FramePartOfTotal(
                    part: metadata.trackPosition.part,
                    total: metadata.trackPosition.total
                )
                
                try tagEditor.write(tag: oldTag, to: url.path)
            } else {
                let builder = ID32v3TagBuilder()
                    .title(frame: ID3FrameWithStringContent(content: metadata.title))
                    .album(frame: ID3FrameWithStringContent(content: metadata.album))
                    .albumArtist(frame: ID3FrameWithStringContent(content: metadata.albumArtist))
                    .artist(frame: ID3FrameWithStringContent(content: metadata.artist))
                    .composer(frame: ID3FrameWithStringContent(content: metadata.composer))
                    .conductor(frame: ID3FrameWithStringContent(content: metadata.conductor))
                    .contentGrouping(frame: ID3FrameWithStringContent(content: metadata.contentGrouping))
                    .copyright(frame: ID3FrameWithStringContent(content: metadata.copyright))
                    .encodedBy(frame: ID3FrameWithStringContent(content: metadata.encodedBy))
                    .encoderSettings(frame: ID3FrameWithStringContent(content: metadata.encoderSettings))
                    .fileOwner(frame: ID3FrameWithStringContent(content: metadata.fileOwner))
                    .lyricist(frame: ID3FrameWithStringContent(content: metadata.lyricist))
                    .mixArtist(frame: ID3FrameWithStringContent(content: metadata.mixArtist))
                    .publisher(frame: ID3FrameWithStringContent(content: metadata.publisher))
                    .subtitle(frame: ID3FrameWithStringContent(content: metadata.subtitle))
                    .originalFilename(frame: ID3FrameWithStringContent(content: metadata.originalFilename))
                    
                    .beatsPerMinute(frame: ID3FrameWithIntegerContent(value: metadata.beatsPerMinute))
                    .lengthInMilliseconds(frame: ID3FrameWithIntegerContent(value: metadata.lengthInMilliseconds))
                    .sizeInBytes(frame: ID3FrameWithIntegerContent(value: fileSize))
                    
                    .genre(frame: ID3FrameGenre(
                        genre: metadata.genre.identifier,
                        description: metadata.genre.description
                    ))
                    
                    .discPosition(frame: ID3FramePartOfTotal(
                        part: metadata.discPosition.part,
                        total: metadata.discPosition.total
                    ))
                    .trackPosition(frame: ID3FramePartOfTotal(
                        part: metadata.trackPosition.part,
                        total: metadata.trackPosition.total
                    ))
                
                let newTag = builder.build()
                try tagEditor.write(tag: newTag, to: url.path)
            }
            
            return OperationResult(success: true, message: "File metadata has been successfully saved.")
        
        } catch {
            return OperationResult(success: false, message: "Failed to save file's metadata: \(error.localizedDescription)")
        }
    }
}
