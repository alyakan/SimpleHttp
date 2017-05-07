## SimpleHTTP
`SimpleHTTP` is a simple, lightweight Networking framework that executes asynchronous http calls on background threads so as to maintain thread safety. It takes into consideration whether the device is running on a Cellular or a Wifi network in order to adjust http requests processing accordingly.

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 8.0+
- Xcode 8.0+

## Installation

### Manually

You can integrate SimpleHTTP into your project manually.

#### Git Submodules

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add SimpleHTTP as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/alyakan/SimpleHttp.git
$ git submodule update --init --recursive
```

- Open the new `SimpleHTTP` folder, and drag the `SimpleHTTP.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `SimpleHTTP.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `SimpleHTTP.xcodeproj` folders each with two different versions of the `SimpleHTTP.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from.

- Select the `SimpleHTTP.framework`.

- And that's it!

**Make sure to Build your project at any point before using the package.**

> The `SimpleHTTP.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

#### Embeded Binaries

- Download the latest release from https://github.com/alyakan/SimpleHttp.git
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Add the downloaded `SimpleHTTP.framework`.
- And that's it!

## Usage
Inside your `ViewController.swift`, or any file you wish to use the framework, add the line `import SimpleHTTP` before any class declaration, if you can't find `SimpleHTTP`, make sure that you have built your project by selecting `Product -> Build`.

For making a **GET** request, add the following where you want to make the HTTP call, change the url string to the api you want to request:

``` swift
if let request = SimpleHTTPRequest(url: URL(string: "https://reqres.in/api/users")!, httpMethod: .get) { // Create a SimpleHTTPRequest Object
    SimpleHTTP.enqueue(request: request) { // Enqueue the request, this part is mandatory.
    SimpleHTTP.execute { (response, data, err) in // Execute the request and handle the data in a completion block.
        print("Response: ", response ?? "No Response")
    }
}
```
For making a request an HTTP body such as a **POST** Request:

``` swift
var parameters: NSDictionary!
parameters = ["name": "paul rudd", "movies": ["I love you man"]]
if let simpleRequest = SimpleHTTPRequest(url: url, httpMethod: .post, parameters: self.parameters) {
    SimpleHTTP.enqueue(request: simpleRequest)
    SimpleHTTP.execute(currentReachabilityStatus, completionHandler: { (response, data, error) in // This is just another way to handle the completion block
        print("Response: ", response ?? "No Response")
    })
}
```

## License

SimpleHTTP is released under the MIT license. See [LICENSE](https://github.com/alyakan/SimpleHttp/blob/master/LICENSE) for details.
