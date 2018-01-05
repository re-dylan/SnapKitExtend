# SnapKitExtend

Add some extension for SnapKit.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- Swift 3.0+
- iOS 8.0+

## Installation

SnapKitExtend is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SnapKitExtend', :git=>"https://github.com/re-dylan/SnapKitExtend.git"
```

## Usage
### Safe area layout
``` swift
class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let box = UIView()
        self.view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.safeAreaTopLayoutGuide)
            make.bottom.equalTo(self.snp.safeAreaBottomLayoutGuide)
            make.right.left.equalToSuperview()
        }
    }
}
```
### Views layout
``` swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        redView.backgroundColor = .red
        let greenView = UIView()
        greenView.backgroundColor = .green
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        let views =  [redView, greenView, blueView]
        views.snp.distributeViewsAlong(axis: .vertical, fixedItemLength: 100) { make in
            make.width.equalTo(100)
        }
    }
}
```

## Author

re-dylan, dylan@liao.com

## License

SnapKitExtend is available under the MIT license. See the LICENSE file for more info.
