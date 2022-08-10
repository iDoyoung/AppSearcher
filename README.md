# AppSearcher iOS
### Info.
- iOS Deployment Target: 13.0
- Xcode Version 13.4.1 
- Interface: UIKit
- Design Architecture: VIP
- 22.8.4 ~ 22.8.10

### Filepath tree
AppSearcher

    │   ├── Resources
    │   │   ├── Assets.xcassets
    │   │   │   ├── AccentColor.colorset
    │   │   │   │   └── Contents.json
    │   │   │   ├── AppIcon.appiconset
    │   │   │   │   └── Contents.json
    │   │   │   └── Contents.json
    │   │   └── Base.lproj
    │   │       └── LaunchScreen.storyboard
    │   ├── Sources
    │   │   ├── Entry
    │   │   │   ├── AppDelegate.swift
    │   │   │   └── SceneDelegate.swift
    │   │   ├── Models
    │   │   │   ├── FetchSearchedApps.swift
    │   │   │   └── SearchedApp.swift
    │   │   ├── Scenes
    │   │   │   ├── AppDetail
    │   │   │   │   ├── AppDetailInteractor.swift
    │   │   │   │   ├── AppDetailPresenter.swift
    │   │   │   │   ├── AppDetailRouter.swift
    │   │   │   │   ├── AppDetailViewController.swift
    │   │   │   │   └── Views
    │   │   │   │       ├── AppDescriptionView.swift
    │   │   │   │       ├── AppHeaderView.swift
    │   │   │   │       ├── AppInfosView.swift
    │   │   │   │       └── AppPreviewCollectionViewCell.swift
    │   │   │   ├── PreviewDetail
    │   │   │   │   ├── PreviewDetailInteractor.swift
    │   │   │   │   ├── PreviewDetailPresenter.swift
    │   │   │   │   ├── PreviewDetailRouter.swift
    │   │   │   │   └── PreviewDetailViewController.swift
    │   │   │   └── SearchApp
    │   │   │       ├── SearchAppInteractor.swift
    │   │   │       ├── SearchAppPresenter.swift
    │   │   │       ├── SearchAppRouter.swift
    │   │   │       └── SearchAppViewController.swift
    │   │   ├── Services
    │   │   │   └── Networking
    │   │   │       ├── APIEndpoints.swift
    │   │   │       ├── Endpoint.swift
    │   │   │       ├── NetworkService.swift
    │   │   │       └── Networkconfiguration.swift
    │   │   ├── Utils
    │   │   │   ├── CacheManager.swift
    │   │   │   └── UIImageView+LoadImage.swift
    │   │   └── Workers
    │   │       └── SearchedAppWorker.swift
    │   └── Supportings
    │       └── Info.plist
    └── AppSearcherTests
        ├── AppDetail
        │   ├── AppDetailInteractorTests.swift
        │   ├── AppDetailPresenterTests.swift
        │   └── AppDetailViewControllerTests.swift
        ├── NetworkServiceTests.swift
        ├── SearchApp
        │   ├── SearchAppInteractorTests.swift
        │   └── SearchAppPresenterTests.swift
        └── Seeds.swift
