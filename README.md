# DocScanView
VisionKit Document Scanner wrapped into a SwiftUI View

## Usage
1. Copy the example swift file into your project.
2. Use the DocScanView with it's optional closures to handle any error or if the user cancelled the scan
3. Add an NSCameraUsageDescription to the Info.plist
4. Enjoy!

```
//hold the results
@State var images: [UIImage] = []
...
var body: some View {
    DocScanView(results: $images) {
        //do something if the user cancelled the scan
    } failedWith: { error in
        //handle any error
        print("\(error.localizedDescription)")
    }
}
```
