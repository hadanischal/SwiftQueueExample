# SwiftQueueExample
## Requirements:
* iOS 12.0+
* Xcode 10.2.1
* Swift 5.0

## Compatibility
This demo is expected to be run using Swift 5.0 and Xcode 10.2.x.

## Notices:
Implement an iOS native app using Swift 5.0 to demonstrate Swift Queue Example. The current version is working with Xcode Version Xcode 10.2.1

## Objective:
This is a simple Demo project which aims to display Swift Queue Example.
* This project was intended to work as a  Swift Queue Example demo projects for iOS using Swift. 
* The demo uses the [SwiftQueue Library](https://github.com/lucas34/SwiftQueue).
* This example will simply select the photo, and add image upload in queue.
* It create custom job by extending Job with onRun, onRetry and onRemove callbacks.
* Library rely on Operation and OperationQueue to make sure all tasks will run in order.

## Guidelines:

### 1. Installation
#### CocoaPods
* Open Terminal and navigate to the directory that contains your SwiftQueueExample project by using the cd command:
```
cd ~/Path/To/Folder/Containing/SwiftQueueExample
```
* Next, enter the following command:
```pod install```

### 2. Cuckoo GeneratedMocks
#### Cuckoo Mocks for Unit testing
* Open Terminal and navigate to the directory that contains your SwiftQueueExample project by using the cd command:
```
cd ~/Path/To/Folder/Containing/SwiftQueueExample
```
* Next, enter the following command:
```./Cuckoo-GeneratedMocks.sh```

