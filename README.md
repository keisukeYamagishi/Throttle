# Throttle
Throttle

This is my implementation of a throttle in Swift, inspired by Krunoslav Zaher's code. If you're looking to use a throttle that doesn't rely on Combine or RxSwift, I hope you'll find this code useful as a reference.

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
