# DocScanView
VisionKit Document Scanner wrapped into a SwiftUI View

## Usage
1. Copy the example swift file into your project.
2. Use the DocScanView with it's optional closures to handle the result, error or if the user cancelled the scan (optional closures)

```
var body: some View {
    DocScanView() { result in
        //do somthing with the scanresult
    }
    cancelled: {
        //do something when user cancelled
    }
    failedWith: { error in
        //handle Error
    }
}
```
