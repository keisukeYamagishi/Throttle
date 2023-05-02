# Throttle
Throttle

This is my implementation of a throttle in Swift, inspired by Krunoslav Zaher's code. If you're looking to use a throttle that doesn't rely on Combine or RxSwift, I hope you'll find this code useful as a reference.

## Use it

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git@github.com:keisukeYamagishi/Throttle.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/keisukeYamagishi/Throttle.git
```

## Installation

### Swift Package Manager

`File` > `Swift Packages` > `Add Package Dependency`

Add `https://github.com/keisukeYamagishi/Throttle.git`

Select "Up to Next Major" or "1.0.0"

### Cocoapods


[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Write the following into the `Podfile`

```Swift
pod 'Throtlle'
```
Then, run the following command:

```bash
$ pod setup
$ pod install
```

## Usage

```Swift
import Throttle
import UIKit

final class ViewController: UIViewController {
    let throttle = Throttle()

    @IBAction func pushInButton(_: Any) {
        throttle
            .execute(interval: .seconds(3)) {
                print("Time passed")
            }
    }
}
```
