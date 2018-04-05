
# iOS Proficiency Exercise

Xcode 9.2, iOS 8

LunchTime(App Name) displays photos with headings and descriptions..

## Architecture

- `HomeViewController`:  Use TableView(CollectionView is also great),

View
- `HomeTableViewCell`:  Cell with Photos/headings/descriptions

ViewModel
- `HomeViewModel`: Request Data from  service; parse with JSON

- `HomeCellViewModel`:  HomeCellViewModel

Model
- `CanadaModel`: A model according to REST service

- `PhotoModel`: Another model according to REST service

- `HomeModel`: Suppose to have pageIndex/totalCount/pageSize...



## Request
Use AFNetworking instead of  NSURLConnection

```objective-c
- (RACSignal *)netWorkRacSignal
```

## Pod
Pod Parse JSON and  download Image

```objective-c
pod 'CocoaLumberjack', '~> 2.0.0-rc'
pod 'AFNetworking', '~>2.6.0'
pod 'SDWebImage', '~>3.7'
pod 'JSONModel', '~> 1.0.1'
pod 'Masonry','~>0.6.1'
pod 'ReactiveCocoa', '2.5'
pod 'RealReachability'

target 'LunchTime' do

target 'LunchTimeTests' do
inherit! :search_paths
pod 'Kiwi', '~> 2.3.1'
pod 'OCMock'
end
end

```

## Unit Tests
includes a suite of unit tests within the Tests subdirectory. These tests can be run simply be executed the test action on the platform framework you would like to test.

- `HomeViewModelTest.m`





