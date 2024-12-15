import SwiftUI

/// A more advanced picker than `SwiftUI.Picker` and `SimplePicker`.
///
/// This picker displays its content in a sheet. Along with quick buttons for clearing the current selection, dismissing, and search functionality.
///
/// This component is restricted to iOS 15+ as there is a SwiftUI bug on iOS 13/14 that breaks multiple `.sheet()` modifiers in a single view. Since this component uses a sheet for rendering its form, this is to prevent any usages of the compnent from indirectly breaking other screens its used on.
@available(iOS 15, *)
public struct AdvancedPicker<Item: Identifiable, Label: View>: View {
    let title: String
    let items: [Item]
    let text: KeyPath<Item, String>?
    @Binding var selection: Item?
    let label: (Item) -> Label
    @State var showPicker = false
    
    public init(
        _ title: String,
        _ items: [Item],
        text: KeyPath<Item, String>? = nil,
        selection: Binding<Item?>,
        @ViewBuilder label: @escaping (Item) -> Label
    ) {
        self.title = title
        self.items = items
        self.text = text
        self._selection = selection
        self.label = label
    }
    
    public var body: some View {
        Button {
            showPicker.toggle()
        } label: {
            LegacyLabeledContent {
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    if let selection {
                        label(selection)
                    } else {
                        Text("Not set")
                    }
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.footnote.weight(.medium))
                }
            } label: {
                Text(title)
                    .foregroundStyle(.foreground)
            }
        }
        .sheet(isPresented: $showPicker) {
            AdvancedPickerRoute(
                title,
                items,
                text: text,
                selection: $selection
            ) { item in
                label(item)
            }
        }
    }
}

@available(iOS 15, *)
private struct AdvancedPickerRoute<Item: Identifiable, Label: View>: View {
    @Environment(\.dismiss) var dismiss
    @State var search = ""
    let title: String
    let items: [Item]
    let text: KeyPath<Item, String>?
    @Binding var selection: Item?
    let label: (Item) -> Label
    
    init(
        _ title: String,
        _ items: [Item],
        text: KeyPath<Item, String>?,
        selection: Binding<Item?>,
        @ViewBuilder label: @escaping (Item) -> Label
    ) {
        self.title = title
        self.items = items
        self.text = text
        self._selection = selection
        self.label = label
    }
    
    var body: some View {
        NavigationView {
            if text != nil {
                content()
                    .searchable(text: $search)
            } else {
                content()
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        List(filteredItems) { item in
            Button {
                selection = item
                dismiss()
            } label: {
                LegacyLabeledContent {
                    if item.id == selection?.id {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.accentColor)
                    }
                } label: {
                    label(item)
                        .foregroundStyle(.foreground)
                }
            }
        }
        .overlay {
            if filteredItems.isEmpty {
                LegacySearchUnavailableContent(text: search)
            }
        }
        .navigationTitle("Select \(title)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Clear") {
                    selection = nil
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
    
    var filteredItems: [Item] {
        guard let text, !search.isEmpty else { return items }
        return items.filter { item in
            item[keyPath: text].localizedCaseInsensitiveContains(search)
        }
    }
}

private struct Option: Identifiable, Hashable {
    let id: Int
    let name: String
}
private let options = [
    Option(id: 1, name: "Paulie"),
    Option(id: 2, name: "Lou"),
    Option(id: 3, name: "Joey")
]

private struct PreviewAdvancedPicker: View {
    @State var option: Option? = options[1]
    
    var body: some View {
        if #available(iOS 15, *) {
            AdvancedPicker(
                "Person",
                options,
                text: \.name,
                selection: $option
            ) { option in
                Text(option.name)
            }
        }
    }
}

#Preview {
    Form {
        Picker("AAA", selection: .constant(Option?.none)) {
            Text("Not set")
                .tag(Option?.none)
        }
        PreviewAdvancedPicker()
    }
}
