
import SwiftUI

@main
struct myprojecApp: App {
    struct Get : View {
        @State var gradient : ColorsModel
        var body : some View {
            #if os(iOS)
            ContentView(gradient: $gradient)
            #endif
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            Get(gradient: ColorsModel(colors: [.white]))
        }
    }
}
