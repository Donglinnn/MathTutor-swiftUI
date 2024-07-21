//
//  ContentView.swift
//  Math Tutor
//
//  Created by Che-lun Hu on 2024/7/21.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    private let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    @State private var answer = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var textFieldIsDisabled = false
    @State private var guessButtonDisabled = false
    @FocusState private var textFieldIsFocused: Bool
    
    
    var body: some View {
        VStack {
            
            Group {
                Text(firstNumberEmojis)
                Text("+")
                Text(secondNumberEmojis)
            }
            .font(.system(size: 80))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .padding()
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber) = ")
                .font(.largeTitle)
            
            TextField("", text: $answer)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 60)
                .overlay {
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(.gray, lineWidth: 2.0)
                }
                .keyboardType(.numberPad)
                .focused($textFieldIsFocused)
                .disabled(textFieldIsDisabled)
            
            Spacer()
            
            Button("Guess") {
                textFieldIsFocused = false
                if answer == String(firstNumber + secondNumber) {
                    playsound(soundName: "correct")
                } else {
                    playsound(soundName: "wrong")
                }
                answer = ""
                textFieldIsDisabled = true
                guessButtonDisabled = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(answer.isEmpty || guessButtonDisabled)
            
            Spacer()
            
        }
        .padding()
        .onAppear(perform: {
            firstNumber = Int.random(in: 1...10)
            secondNumber = Int.random(in: 1...10)
            firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
            secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
        })
    }
    
    func playsound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("🥲 Could not read file named \(soundName) 🥲")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("🥲 ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview {
    ContentView()
}
