//
//  ContentView.swift
//  WordGarden
//
//  Created by CUEVA VASQUEZ, JUSTIN on 1/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gameStatusMessage = "How Mant Guesses to Uncover the Hidden Word?"
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var currentWordIndex = 0 //index in wordsToGuess
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    private let wordsToGuess = ["SWIFT" , "DOG" , "CAT"] ///All Caps
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text ("Words Guessed: \(wordsGuessed)")
                    Text ("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text ("Words to Guess: \(wordsToGuess.count - (wordsGuessed - wordsMissed))")
                    Text ("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            //TODO: Switch to wordsToGuess[currentWordIndex]
            Text(revealedWord)
                .font(.title)
            
            if playAgainHidden {
                
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .focused($textFieldIsFocused)
                    
                    Button("Guess a Letter:") {
                        //TODO: Guess a Letter button action here
                        textFieldIsFocused = false
                        lettersGuessed = lettersGuessed + guessedLetter
                        revealedWord = wordToGuess.map{ letter in
                            lettersGuessed.contains(letter) ? "\(letter)" : "_"
                        }.joined(separator: " ")
                        guessedLetter = ""
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else{
                Button("Another Word?") {
                    //TODO: Another Word action here
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            
          
            
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges:.bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            // CREATE A STRING FROM A REPEATING VALUE
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
            print(revealedWord)
        }
    }
}

#Preview {
    ContentView()
}
