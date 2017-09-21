# ENMBadgedBarButtonItem - Swift

[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat-square)]()
[![CocoaPods](https://img.shields.io/cocoapods/v/ENMBadgedBarButtonItem.svg?style=flat-square)]()

A UIBarButtonItem that can be badged!

![Screenshot](screenshot.png)

---

### Usage
A `BadgedBarButtonItem` can be created programmatically or from a storyboard.

For programmatic use, a badged bar item can be instantiated with
```
let image = UIImage(imageLiteralResourceName: "barbuttonimage")
let buttonFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
let barButton = BadgedBarButtonItem(
    startingBadgeValue: 0,
    frame: buttonFrame,
    image: image
)

leftBarButton = barButton
leftBarButton?.addTarget(self, action: #selector(leftBarButtonTapped(_:)))
navigationItem.leftBarButtonItem = leftBarButton
```

From a storyboard, instantiation is as easy as creating an `IBOutlet` and connecting it in Interface Builder:
```
@IBOutlet fileprivate var rightBarButton: BadgedBarButtonItem!
```

Use the `BadgeProperties` class to customize the badge bar item's appearance and position.