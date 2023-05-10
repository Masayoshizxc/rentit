# SwiftyMenuBar

[![Build Status](https://travis-ci.com/JonathanScala/SwiftyMenuBar.svg?branch=master)](https://travis-ci.com/JonathanScala/SwiftyMenuBar)
[![Version](https://img.shields.io/cocoapods/v/SwiftyMenuBar.svg?style=flat)](https://cocoapods.org/pods/SwiftyMenuBar)
[![License](https://img.shields.io/cocoapods/l/SwiftyMenuBar.svg?style=flat)](https://github.com/JonathanScala/SwiftyMenuBar/blob/master/LICENSE?raw=true)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyMenuBar.svg?style=flat)](https://cocoapods.org/pods/SwiftyMenuBar)

<p align="center">
  <img src="https://github.com/JonathanScala/SwiftyMenuBar/blob/master/Example/images/preview.gif?raw=true" alt="preview" width="300"/>
</p>

## Getting Started
### MenubarController
```swift
let titles = ["T1", "T2", "T3", "T4"]
let vcs: [UIViewController] = [
    UIViewController(),
    UIViewController(),
    UIViewController(),
    UIViewController()
]
let menu: MenuBarController = MenuBarController(viewControllers: vcs, titles: titles)
addChild(menu)
view.addSubview(menu.view)
```

### MenuBarConfigurations
```swift
let config = MenuBarConfigurations()
config.itemsPerPage = 3.5
config.font = UIFont.systemFont(ofSize: 15, weight: .bold)
config.barColor = .white
config.textColor = .unselectedGray
config.selectedColor = .black
config.staticSize = true
config.sliderColor = .black
menu.configuration = config
```

### MenuBar
```swift
let conf = MenuBarConfigurations()
conf.itemsPerPage = 3.5
conf.font = UIFont.systemFont(ofSize: 22, weight: .bold)
conf.barColor = .clear
conf.textColor = .white
conf.selectedColor = .white
conf.staticSize = false
conf.sliderColor = .clear
let menuBar: MenuBar = MenuBar(
    titles: [
        "Today",
        "Sept 7",
        "Sept 8",
        "Sept 9",
        "Sept 10"
    ],
    configuration: conf
)
view.addSubview(menuBar)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftyMenuBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyMenuBar'
```

## Author

Jonathan Scala, jonathan1234scala@gmail.com

## License

SwiftyMenuBar is available under the MIT license. See the LICENSE file for more info.
