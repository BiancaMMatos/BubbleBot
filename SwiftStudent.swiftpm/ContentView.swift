import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Spacer()
        NavigationView {
            
            VStack {
                Spacer()
                Text("Welcome to BubbleBot!")
                    .font(.title)
                    .bold()
                Spacer()
                Image("Logo")
                Spacer()
                NavigationLink(destination: ChatView()) {
                    Text("Let's get started!")
                        .foregroundColor(Color.black)
                        .bold()
                        .padding()
                        .padding(.horizontal, 30)
                        .background(Color.yellow)
                        .cornerRadius(20)       
                }
                Spacer()
                Spacer()
            }
        }
        .navigationViewStyle(.stack)
        Spacer()
    }
}
