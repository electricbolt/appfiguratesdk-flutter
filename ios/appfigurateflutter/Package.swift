// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppfigurateFlutter",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "appfigurateflutter", targets: ["appfigurateflutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/electricbolt/appfiguratesdk", exact: "3.2.1")
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
