import SwiftUI

@available(iOS 14, *)
public struct LegacySearchUnavailableContent: View {
    var text: String? = nil
    
    public var body: some View {
        if #available(iOS 17, *) {
            if let text {
                ContentUnavailableView.search(text: text)
            } else {
                ContentUnavailableView.search
            }
        } else {
            LegacyContentUnavailableView {
                label()
            } description: {
                description()
            }
        }
    }
    
    @ViewBuilder
    func label() -> some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.secondary)
            .font(.largeTitle.bold())
            .padding(.bottom, 2.5)
        if let text {
            Text("No Results for \"\(text)\"")
                .bold()
        } else {
            Text("No Results")
                .bold()
        }
    }
    
    func description() -> some View {
        Text("Check the spelling or try a new search.")
            .foregroundColor(.secondary)
    }
}
