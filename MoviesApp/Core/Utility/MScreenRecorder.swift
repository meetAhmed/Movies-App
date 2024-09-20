//
//  MScreenRecorder.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 19/09/2024.
//

import ReplayKit

enum MScreenRecorderError: Error {
    case invalidDir
    case screenRecorderNotFound
    case failedToStartRecording
}

protocol MScreenRecorder {
    func record() throws
    func stop() async throws
    var videoUrl: URL? { get }
}

class MScreenRecorderImpl: MScreenRecorder {
    private var instance: RPScreenRecorder
    
    init(instance: RPScreenRecorder = RPScreenRecorder.shared()) {
        self.instance = instance
    }
    
    private var fileName: String {
        "ScreenRecordVideo.mp4"
    }
    
    private var fileDir: URL? {
        FileManager.default.temporaryDirectory
    }
    
    var videoUrl: URL? {
        fileDir?.appendingPathComponent(fileName)
    }
    
    func record() throws {
        guard let videoUrl else {
            throw MScreenRecorderError.invalidDir
        }
        if FileManager.default.fileExists(atPath: videoUrl.path) {
            try FileManager.default.removeItem(at: videoUrl)
        }
        guard instance.isAvailable else {
            throw MScreenRecorderError.screenRecorderNotFound
        }
        instance.startRecording { error in
            if error == nil {
                NotificationCenter.default.post(name: .screenRecordingStarted, object: nil)
            }
        }
    }
    
    func stop() async throws {
        guard let videoUrl else {
            throw MScreenRecorderError.invalidDir
        }
        guard instance.isRecording else { return }
        try await instance.stopRecording(withOutput: videoUrl)
        await MainActor.run {
            NotificationCenter.default.post(name: .screenRecordingStopped, object: nil)
        }
    }
}
