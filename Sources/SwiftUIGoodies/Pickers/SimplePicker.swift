import SwiftUI

/// A simple wrapper around `SwiftUI.Picker`.
/// This component has the added benefit of moving the picker selection detection mechanism from runtime to compile time, eliminating footguns.
///
/// SwiftUI relies on selectable options having the `.id(_:)` or `.tag(_:)` environment modifier to identify the option. Most pickers will use `ForEach`,
/// which will automatically add the modifier if the content conforms to `Identifiable`, or using the relevant `id: KeyPatch<T, ID>` argument provided.
///
/// But what if the binding provided as the `selection` is a different type than the provided `.tag(_:)` or `.id(_:)`? Then the picker will fail at runtime instead of at compile time.
///
/// This component ensures the types are equivalent using generics on the initializers.
///
/// This component also automatically adds a `Not set` option if the `selection` binding is optional and tags it appropriately for selection.
public struct SimplePicker<
    SelectionValue: Hashable,
    Item: Identifiable & Hashable,
    Content: View
>: View {
    let title: String
    @Binding var selection: SelectionValue
    let items: [Item]
    let content: (Item) -> Content
    let allowOptionalSelection: Bool
    
    public var body: some View {
        Picker(title, selection: $selection) {
            if allowOptionalSelection {
                Text("Not set")
                    .tag(Item?.none)
            }
            ForEach(items) { item in
                content(item)
                    .tag(item)
            }
        }
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        selection: Binding<SelectionValue>,
        _ items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Item {
        self.title = title
        self._selection = selection
        self.items = items
        self.content = content
        self.allowOptionalSelection = false
    }
}

extension SimplePicker {
    public init(
        _ title: String,
        selection: Binding<SelectionValue>,
        _ items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) where SelectionValue == Optional<Item> {
        self.title = title
        self._selection = selection
        self.items = items
        self.content = content
        self.allowOptionalSelection = true
    }
}
