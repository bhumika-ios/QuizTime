//
//  Manager.SFX.swift
//  QuizTime
//
//  Created by Bhumika Patel on 18/04/23.
//

import Foundation
import AVFoundation

extension Manager {
    struct SFX {
        public static var shared = Manager.SFX()
        var audioPlayer: AVAudioPlayer!
        static func playSound(sound: Sound) {
            if let url = Bundle.main.url(forResource: sound.soundFile, withExtension: "wav") {
                do {
                    shared.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    shared.audioPlayer.volume = sound.volume
                    shared.audioPlayer.play()
                } catch {
                    print(error)
                }
            }

        }
        enum Sound {
            case correct
            case wrong
            case finished

            var soundFile: String {
                switch self {
                case .correct:
                    return "correct"
                case .wrong:
                    return "wrong"
                case .finished:
                    return "finished"
                }
            }

            var volume: Float {
                switch self {
                case .correct:
                    return 1
                case .wrong:
                    return 1
                case .finished:
                    return 0.6
                }
            }
        }
    }
}
