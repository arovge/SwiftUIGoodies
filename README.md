# SwiftUIGoodies
A collection of SwiftUI addons that I've found useful over time.

### Install

In your `Package.swift`, add this line:

```swift
.package(url: "https://github.com/arovge/SwiftUIGoodies", from: "0.1.0")
```

In the relevant target(s) you'd like to use this package in, add this to the target dependencies:

```swift
dependencies: [
    .product(name: "SwiftUIGoodies", package: "SwiftUIGoodies")
]
```

Then simply use `import SwiftUIGoodies` in the appropriate file(s) to use these goodies

### Views
- `LegacyContentUnavailableView` (iOS 14+)
    - A wrapper around `ContentUnavailableView` 
- `LegacyLabeledContent` (iOS 13+)
    - A wrapper around `LabeledContent` 
- `SimplePicker` (iOS 13+)
    - A wrapper around `SwiftUI.Picker` that eliminates possible run time errors when the selection and tagged item types are different.
- `AdvancedPicker` (iOS 15+)
    - A more advanced picker than `SwiftUI.Picker` and `SimplePicker`, offering search and clear functionality.

### Styles
- `LabeledContent`
    - `vertical` (iOS 16+)
        - A `.labeledContentStyle(_:)` for laying content out in a vertical container
        - Label visibility is only supported on iOS 18+
    - `fitting` (iOS 16+)
        - A `.labeledContentStyle(_:)` style for conditionally using `.vertical` or `.automatic` (horizontal) labeled content styling depending on the available space in the `LabeledContent`'s container
- `Label`
    - `vertical` (iOS 14+)
        - A `.labelStyle(_:)` style for rendering a label in a vertical container
- `Button`
    - `loading` (iOS 15+)
        - A `.buttonStyle(_:)` style for disabling + showing a loading action happening from a button press
        - Disables the button and shows a `ProgressView()` in place of the label when the style is used
        - Style is used when the `.loading(_:)` environment value is active
