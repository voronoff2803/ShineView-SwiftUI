//
//  ContentView.swift
//  GlareViewTest
//
//  Created by Alexey Voronov on 24.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var animateTrigger = false
    
    var body: some View {
        
        Button(action: { animateTrigger.toggle() }) {
            Text("Shine View")
                .font(.system(size: 40, weight: .bold))
                .padding(30)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(18)
                .shineEffect(animationTrigger: $animateTrigger)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
