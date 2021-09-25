//
//  GlareViewModifier.swift
//  SMS Virtual SwiftUI
//
//  Created by Alexey Voronov on 25.09.2021.
//

import SwiftUI

struct GlareView: View {
    @Binding var animateTrigger: Bool
    @State private var animation = false
    
    let angle = 10.0
    let glareWidth = 40.0
    let oppacity = 0.3
    
    func animate() {
        withAnimation(.timingCurve(0.6, 0.17, 0.59, 1.0, duration: 0.5).delay(0.25)){
                    animation = true
                }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            animation = false
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let angleRadians = angle * .pi / 180
            let fullHeight = ((geometry.size.height / 2) / (sin((.pi / 2) - angleRadians))) * 2 + 40
            let offset = (fullHeight / 2) * tan(angleRadians)
            
            Rectangle()
                .fill(Color.white.opacity(oppacity))
                .frame(width: glareWidth, height: fullHeight)
                .rotationEffect(Angle(radians: angleRadians), anchor: .center)
                .offset(x: animation ? geometry.size.width + offset : -glareWidth - offset, y: -20)
                .blendMode(.colorDodge)
        }
        .onChange(of: animateTrigger) { _ in
            animate()
        }
    }
}

struct GlareCard: ViewModifier {
    @Binding var animateTrigger: Bool
    
    @State private var glareTrigger = false
    @State private var cardAngle = 0.0
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            animateCardAngle(-6, 0.2)
            glareTrigger.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            animateCardAngle(0, 1.0)
        }
        
    }
    
    func animateCardAngle(_ angle: Double,_ duration: Double) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 0.2)) {
            cardAngle = angle
        }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GlareView(animateTrigger: $glareTrigger)
            )
            .clipped()
            .rotation3DEffect(.degrees(cardAngle), axis: (x: 0, y: -1, z: 0))
            .onAppear()
            .onChange(of: animateTrigger) { _ in
                startAnimation()
            }
    }
}

extension View {
    func shineEffect(animationTrigger: Binding<Bool>) -> some View {
        self.modifier(GlareCard(animateTrigger: animationTrigger))
    }
}
