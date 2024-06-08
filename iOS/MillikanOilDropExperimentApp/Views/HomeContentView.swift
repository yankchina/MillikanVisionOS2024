import SwiftUI

struct HomeContentView: View {
    @State private var contentText: String = ""

    var body: some View {
        ScrollView {
            TextEditor(text: $contentText)
                .frame(width: 400, height: 300)
                .border(Color.gray, width: 1)  // Adding a border for visibility
                .padding()
        }
        .onAppear {
            loadLocalizedContent()
        }
    }

    private func loadLocalizedContent() {
        let locale = Locale.current.identifier.lowercased()
        print(locale)
        let fileName = "home.\(locale).txt" // Construct the file name based on language
        
        if let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
           let fileContents = try? String(contentsOfFile: filePath) {
            contentText = fileContents
        } else {
            // Fallback to English if specific language content is not found
            if let filePath = Bundle.main.path(forResource: "home.en_us.txt", ofType: nil),
               let fileContents = try? String(contentsOfFile: filePath) {
                contentText = fileContents
            }
        }
    }
}
