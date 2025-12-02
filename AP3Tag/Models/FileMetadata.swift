//
//  FileMetadata.swift
//  AP3Tag
//
//  Created by Aviran Dabush on 28/11/2025.
//

import Foundation
import AppKit
import ID3TagEditor

struct FileMetadata: Equatable {
    var size: Int = 0
    var version: String = ""
    var artist: String = ""
    var composer: String = ""
    var conductor: String = ""
//    var contentGrouping: String = ""
    var copyright: String = ""
    var encodedBy: String = ""
    var encoderSettings: String = ""
    var fileOwner: String = ""
    var lyricist: String = ""
    var mixArtist: String = ""
    var publisher: String = ""
    var subtitle: String = ""
    var albumArtist: String = ""
    var title: String = ""
    var trackPosition: ID3FramePartOfTotal = ID3FramePartOfTotal(part: 0, total: 0)
    var discPosition: ID3FramePartOfTotal = ID3FramePartOfTotal(part: 0, total: 0)
    var album: String = ""
    var recordingDateTime: String = ""
    var recordingYear: Int = 0
//    var recordingDayMonth: ID3FrameRecordingDayMonth = ID3FrameRecordingDayMonth(day: 0, month: 0)
//    var recordingHourMinute: ID3FrameRecordingHourMinute = ID3FrameRecordingHourMinute(hour: 0, minute: 0)
    var genre: ID3FrameGenre = ID3FrameGenre(genre: nil, description: nil)
//    var attachedPicture: NSImage?
//    var unsynchronisedLyrics: String = ""
    var comments: String = ""
}
