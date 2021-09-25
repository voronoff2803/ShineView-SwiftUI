# Shine-View-SwiftUI
Animated shine effect for your views

![Alt Text](https://github.com/voronoff2803/Shine-View-SwiftUI/blob/main/media/example.gif?raw=true)

```javascript
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
```
