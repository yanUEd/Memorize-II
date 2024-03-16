//
//  ContentView.swift
//  Memorize II
//
//  Created by zhou on 2024/3/14.
//

import SwiftUI

struct ContentView: View {
    var animalEmojis = ["🐶", "🐱", "🐹", "🐭", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
    var fruitEmojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🥥"]
    var sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🥊"]
    
    @State var emojis: [String] = []
    @State var color: Color = .accentColor
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            cards
            Spacer()
            chooseTheme
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 8) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(color)
            }
        }
        .padding()
    }
    
    var chooseTheme: some View {
        HStack {
            themeButton(name: "Animal", content: animalEmojis, symbol: "pawprint", themeColor: .brown)
            themeButton(name: "Fruit", content: fruitEmojis, symbol: "carrot", themeColor: .orange)
                .padding(.horizontal, 40)
            themeButton(name: "Sport", content: sportEmojis, symbol: "football", themeColor: .blue)
        }
    }
    
    func themeButton(name: String, content: [String], symbol: String, themeColor: Color) -> some View {
        Button(action: {
            let index = Int.random(in: 4..<8)
            emojis = randomEmojis(content: content, numberOfPairs: index)
            color = themeColor
        }, label: {
            VStack {
                Image(systemName: symbol).font(.title2)
                Text(name).font(.subheadline)
            }
        })
    }
    
    func randomEmojis(content: [String], numberOfPairs: Int) ->  [String] {
        var result: [String] = []
        let shuffledContent = content.shuffled()
        for index in 0...numberOfPairs {
            result.append(shuffledContent[index])
            result.append(shuffledContent[index])
        }
        return result.shuffled()
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let card = RoundedRectangle(cornerRadius: 12)
            Group {
                card.fill(.white).strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            card.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
