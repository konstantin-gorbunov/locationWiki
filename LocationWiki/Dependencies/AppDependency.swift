//
//  AppDependency.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

protocol Dependency {
    var dataProvider: DataProvider { get }
}

class AppDependency: Dependency {

    let dataProvider: DataProvider = LocalLocationDataProvider()
}
