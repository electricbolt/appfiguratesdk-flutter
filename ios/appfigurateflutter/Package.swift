// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppfigurateFlutter",
    platforms: [
        .iOS("15.0"),
    ],
    products: [
        .library(name: "appfigurateflutter", targets: ["appfigurateflutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/electricbolt/appfiguratesdk", exact: "4.0.2")
    ],
    targets: [
        .target(
            name: "appfigurateflutter",
            dependencies: [
	          .product(name: "AppfigurateLibrary", package: "appfiguratesdk")
            ],
            cSettings: [
                .headerSearchPath("include/appfigurateflutter")
            ]
        )
    ]
)
