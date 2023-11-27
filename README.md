# CombineCocoa

<p align="center">
<img src="https://github.com/freak4pc/CombineCocoa/raw/main/Resources/logo.png" width="45%">
<br/><br/>
<a href="https://github.com/vicrolab/CombineCocoa/actions/workflows" target="_blank" alt="Build Status" title="Build Status"><img src="https://github.com/vicrolab/CombineCocoa/actions/workflows/tests.yml/badge.svg?branch=main" alt="Build Status" title="Build Status"></a>
<a href="https://github.com/apple/swift-package-manager" target="_blank"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="CombineCocoa supports Swift Package Manager (SPM)"></a>
<img src="https://img.shields.io/badge/platforms-iOS%2013.0-333333.svg" />
</p>


CombineCocoa attempts to provide publishers for common UIKit controls so you can consume user interaction as Combine emissions and compose them into meaningful, logical publisher chains.

**Note**: This is still a primal version of this, with much more to be desired. I gladly accept PRs, ideas, opinions, or improvements. Thank you ! :)

## Basic Examples
<p align="center"><img src="https://github.com/freak4pc/CombineCocoa/raw/main/Resources/example.gif"></p>

## Usage

tl;dr: 

```swift
import Combine
import CombineCocoa

textField.textPublisher // AnyPublisher<String, Never>
segmented.selectedSegmentIndexPublisher // AnyPublisher<Int, Never>
slider.valuePublisher // AnyPublisher<Float, Never>
button.tapPublisher // AnyPublisher<Void, Never>
barButtonItem.tapPublisher // AnyPublisher<Void, Never>
switch.isOnPublisher // AnyPublisher<Bool, Never>
stepper.valuePublisher // AnyPublisher<Double, Never>
datePicker.datePublisher // AnyPublisher<Date, Never>
refreshControl.isRefreshingPublisher // AnyPublisher<Bool, Never>
pageControl.currentPagePublisher // AnyPublisher<Int, Never>
tapGesture.tapPublisher // AnyPublisher<UITapGestureRecognizer, Never>
pinchGesture.pinchPublisher // AnyPublisher<UIPinchGestureRecognizer, Never>
rotationGesture.rotationPublisher // AnyPublisher<UIRotationGestureRecognizer, Never>
swipeGesture.swipePublisher // AnyPublisher<UISwipeGestureRecognizer, Never>
panGesture.panPublisher // AnyPublisher<UIPanGestureRecognizer, Never>
screenEdgePanGesture.screenEdgePanPublisher // AnyPublisher<UIScreenEdgePanGestureRecognizer, Never>
longPressGesture.longPressPublisher // AnyPublisher<UILongPressGestureRecognizer, Never>
scrollView.contentOffsetPublisher // AnyPublisher<CGPoint, Never>
scrollView.reachedBottomPublisher(offset:) // AnyPublisher<Void, Never>
nsObject.publisher(for: #selector(NSObject.someMethod))
```

## Installation

### Swift Package Manager

Add the following dependency to your **Package.swift** file:

```swift
.package(url: "https://github.com/vicrolab/CombineCocoa.git", from: "0.2.1")
```

## Future ideas 

* Support non `UIControl.Event`-based publishers (e.g. delegates).
* ... your ideas? :)

## Acknowledgments

* CombineCocoa is highly inspired by RxSwift's [RxCocoa](https://github.com/ReactiveX/RxSwift) in its essence, kudos to [Krunoslav Zaher](https://twitter.com/KrunoslavZaher) for all of his amazing work on this.
* Thanks to [Antoine van der Lee](https://twitter.com/twannl) for his tutorial on [Creating Custom Publishers](https://www.avanderlee.com/swift/custom-combine-publisher/). The idea to set up a control target inside the publisher was inspired by it.

## License

MIT, of course ;-) See the [LICENSE](LICENSE) file. 

The Apple logo and the Combine framework are property of Apple Inc.
