//
//  File.swift
//  SwiftStudent
//
//  Created by Bianca Maciel Matos on 13/04/22.
//

import Foundation
import SwiftUI
import NaturalLanguage

struct ChatView: View {
    
    @State  var messageText = ""
    @State private var messages: [String] = []
    
    @FocusState private var keyboardIsFocused: Bool
    var textView : UITextView!
    
    @ObservedObject var identifier = SentimentIdentifier()
    
    @State private var question1: Bool = false
    
    @State private var question2: Bool = true
    @State private var questionTwo: Bool = false
    
    @State private var question3: Bool = true
    @State private var questionThree: Bool = false
    
    @State private var conclusion1: Bool = true
    @State private var conclusion2: Bool = true
    
    @State private var answer1: String = ""
    @State private var answer2: String = ""
    @State private var answer3: String = ""
    
    @State private var accuracy1: Int = 0
    @State private var accuracy2: Int = 0
    @State private var accuracy3: Int = 0
    
    @State private var confidence1: Double = 0.0
    @State private var confidence2: Double = 0.0
    @State private var confidence3: Double = 0.0
    
    @State private var isPositive: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                
                Text("BubbleBot")
                    .font(.headline)
                    .bold()
                
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color("sendMessage"))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        if message.contains("[IMAGE]") {
                            let newMessage = message.replacingOccurrences(of: "[IMAGE]", with: "")
                            HStack {
                                Image(newMessage)
                                    .resizable()
                                    .frame(width: 70, height: 50)
                                    .padding()
                                    .background(Color("botMessage"))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                        else {
                            HStack {
                                Text(message)
                                    .padding()
                                    .foregroundColor(Color.black)
                                    .background(Color("botMessage"))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                        
                    }
                }
                .rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color("AccentColor"))
            
            HStack(spacing: 5) {
                
                TextField("Type here", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .onSubmit {
                        if question1 {
                            accuracy1 = 1
                            answer1 = messageText
                            print("answer1: \(answer1)")
                            question1.toggle()
                        }
                        if questionTwo {
                            accuracy2 = 2
                            answer2 = messageText
                            print("answer2: \(answer2)")
                            questionTwo.toggle()
                        }
                        if questionThree {
                            accuracy3 = 3
                            answer3 = messageText
                            print("answer3: \(answer3)")
                            questionThree.toggle()
                        }
                        sendMessage(message: messageText)
                    }
                    .focused($keyboardIsFocused)
                
                Button {
                    sendMessage(message: messageText)
                    keyboardIsFocused = false
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(messageText.isEmpty ? Color("sendMessage") : Color("colorSend"))
                        .font(.system(size: 35))
                        .padding(.horizontal, 10)
                }
                
                //.padding()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .onAppear {
            openChat()
        }
    }
    
    func openChat() {
        
        let botMessages: [String] = ["Hello there!", "My name is Bubble, I am a robot... or maybe not 👀", "I am made with CoreML and my job here is to help you find out which brazilian food would you rather try 😋 based on Sentiment Analysis on the text you send me back.", "But for that, I need you to follow some rules:", "1. Please, don't be sarcastic with me (I'm really bad at understanding it)", "2. Reply me at once, not sending me more than just one message about a question I make.", "3. But don't be monosyllabic! I want to understand what do you think about what I'm asking you.", "Alright, let's go!"]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                messages.append(botMessages[0])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                messages.append(botMessages[1])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            withAnimation {
                messages.append(botMessages[2])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 14.5) {
            withAnimation {
                messages.append(botMessages[3])
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
            withAnimation {
                messages.append(botMessages[4])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 22) {
            withAnimation {
                messages.append(botMessages[5])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 26) {
            withAnimation {
                messages.append(botMessages[6])
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 31) {
            withAnimation {
                messages.append(botMessages[7])
            }
        }
        
        firstQuestion()
    }
    
    func sendMessage(message: String) {
        identifier.predict(message)
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = "" // letting the box empty again
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                messages.append(getBotResponse(identifier: identifier, message: messageText))
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                if question2 {
                    secondQuestion()
                    question2.toggle()
                }
            }
        }
        
        if !question2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    if question3 {
                        thirdQuestion()
                        question3.toggle()
                    }
                }
            }
        }
        
        if !question3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                withAnimation {
                    if conclusion1 {
                        messages.append("I think I know the perfect food for you!")
                        conclusion1.toggle()
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) {
                withAnimation {
                    if conclusion2 {
                        let sticker = compareResponses()
                        messages.append("It's called \(sticker.description) and is definely something that you're going to love when you come to Brazil!")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                if conclusion2 {
                                    let sticker = compareResponses()
                                    messages.append("[IMAGE]" + sticker.description)
                                    
                                    conclusion2.toggle()
                                    
                                }
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                withAnimation {
                        messages.append("I hope you had enjoy this experience! I always love talking to humans... I mean, to other people 😁 see you around")
                    
                }
            }
        }
        
    }
    
    func getBotResponse(identifier: SentimentIdentifier, message: String) -> String {
        
        if identifier.prediction == "positive" && conclusion2 {
            if accuracy1 == 1 {
                confidence1 = identifier.confidence + 1
                print("confidence1: \(confidence1)")
                accuracy1 = 0
            }
            if accuracy2 == 2 {
                confidence2 = identifier.confidence + 1
                print("confidence2: \(confidence2)")
                accuracy2 = 0
            }
            if accuracy3 == 3 {
                confidence3 = identifier.confidence + 1
                print("confidence3: \(confidence3)")
                accuracy3 = 0
            }
            
            return "That's great!"
            
        } else if identifier.prediction == "negative" && conclusion2 {
            if accuracy1 == 1 {
                confidence1 = identifier.confidence - 1
                print("confidence1: \(confidence1)")
                accuracy1 = 0
            }
            if accuracy2 == 2 {
                confidence2 = identifier.confidence - 1
                print("confidence2: \(confidence2)")
                accuracy2 = 0
            }
            if accuracy3 == 3 {
                confidence3 = identifier.confidence - 1
                print("confidence3: \(confidence3)")
                accuracy3 = 0
            }
            return "Really? Okay..."
            
        } else if identifier.prediction == "neutral" && conclusion2 {
            if accuracy1 == 1 {
                confidence1 = identifier.confidence
                print("confidence1: \(confidence1)")
                accuracy1 = 0
            }
            if accuracy2 == 2 {
                confidence2 = identifier.confidence
                print("confidence2: \(confidence2)")
                accuracy2 = 0
            }
            if accuracy3 == 3 {
                confidence3 = identifier.confidence
                print("confidence3: \(confidence3)")
                accuracy3 = 0
            }
            return "Okay, I respect your opinion."
        }
        else {
            return "It was nice to meet you, bye bye!"
        }
        
    }
    
    func firstQuestion() {
        question1.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 34.5) {
            withAnimation {
                messages.append("What do you think about drinking alcohol?")
            }
        }
    }
    
    func secondQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                messages.append("How do you feel about eating pork?")
            }
        }
        questionTwo.toggle()
        
    }
    
    func thirdQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                messages.append("And what about spicy food?")
            }
        }
        questionThree.toggle()
    }
    
    func compareResponses() -> Images {
        if (confidence1 > confidence2 && confidence1 > confidence3) {
            return .caipirinha
        }
        else if (confidence2 > confidence1 && confidence2 > confidence3) {
            return .feijoada
        }
        else {
            return .acaraje
        }
    }
    
    func setImages(image: Images) -> Image {
        return Image(image.description)
    }
}

enum Images: CustomStringConvertible {
    
    case caipirinha, feijoada, acaraje
    
    var description: String {
        switch self {
        case .caipirinha: return "caipirinha"
        case .feijoada: return "feijoada"
        case .acaraje: return "acarajé"
        }
    }
    
}
