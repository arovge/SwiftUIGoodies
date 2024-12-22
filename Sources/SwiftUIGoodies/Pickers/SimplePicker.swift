import SwiftUI

/// A simple wrapper around `SwiftUI.Picker`.
/// This component has the added benefit of moving the picker selection detection mechanism from runtime to compile time, eliminating footguns.
///
/// SwiftUI relies on selectable options having the `.id(_:)` or `.tag(_:)` environment modifier to identify the option. Most pickers will use `ForEach`,
/// which will automatically add the modifier if the content conforms to `Identifiable`, or using the relevant `id: KeyPatch<T, ID>` argument provided.
///
/// But what if the binding provided as the `selection` is a different type than the provided `.tag(_:)` or `.id(_:)`? Then the picker will fail at runtime instead of at compile time.
///
/// This component ensures the types are equivalent using generics on the initializers. It supports both the `selection` being the same type as the given `Item` as well as the same type as `Item.ID`.
///
/// This component also automatically adds a `Not set` option if the `selection` binding is optional and tags it appropriately for selection.
public struct SimplePicker<
    SelectionValue: Hashable,
    Item: Identifiable & Hashable,
    Content: View
>: View {
    let title: String
    let items: [Item]
    @Binding var selection: SelectionValue
    let content: (Item) -> Content
    let allowOptionalSelection: Bool
    
    public var body: some View {
        Picker(title, selection: $selection) {
            if allowOptionalSelection {
                Text("Not set")
                    .tag(Item?.none)
                    .tag(Item.ID?.none)
            }
            
            ForEach(items) { item in
                content(item)
                    .tag(item)
                    .tag(item.id)
            }
        }
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        _ items: [Item],
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Item {
        self.title = title
        self.items = items
        self._selection = selection
        self.content = content
        self.allowOptionalSelection = false
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        _ items: [Item],
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Optional<Item> {
        self.title = title
        self.items = items
        self._selection = selection
        self.content = content
        self.allowOptionalSelection = true
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        _ items: [Item],
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Item.ID {
        self.title = title
        self.items = items
        self._selection = selection
        self.content = content
        self.allowOptionalSelection = false
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        _ items: [Item],
        selection: Binding<SelectionValue>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Optional<Item.ID> {
        self.title = title
        self.items = items
        self._selection = selection
        self.content = content
        self.allowOptionalSelection = true
    }
}

#Preview {
    PreviewSimplePicker()
}

private struct Option: Identifiable, Hashable {
    let id: Int
    let name: String
}

private let options = [
    Option(id: 1, name: "A"),
    Option(id: 2, name: "B"),
    Option(id: 3, name: "C"),
    Option(id: 4, name: "D")
]

private struct PreviewSimplePicker: View {
    @State var nonOptionalItem = options[0]
    @State var optionalItem = Option?.none
    @State var nonOptionalItemID = options[1].id
    @State var optionalItemID = Option.ID?.none
    
    var body: some View {
        Form {
            Section(header: Text("Non-optional item")) {
                SimplePicker(
                    "Option",
                    options,
                    selection: $nonOptionalItem
                ) { option in
                    Text(option.name)
                }
            }
            Section(header: Text("Optional item")) {
                SimplePicker(
                    "Option",
                    options,
                    selection: $optionalItem
                ) { option in
                    Text(option.name)
                }
            }
            Section(header: Text("Non-optional item ID")) {
                SimplePicker(
                    "Option",
                    options,
                    selection: $nonOptionalItemID
                ) { option in
                    Text(option.name)
                }
            }
            Section(header: Text("Optional item ID")) {
                SimplePicker(
                    "Option",
                    options,
                    selection: $optionalItemID
                ) { option in
                    Text(option.name)
                }
            }
        }
    }
}
