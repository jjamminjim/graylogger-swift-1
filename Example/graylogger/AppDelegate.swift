//
//  AppDelegate.swift
//  graylogger
//
//  Created by jjamminjm on 06/27/2017.
//  Copyright (c) 2017 jjamminjm. All rights reserved.
//

import UIKit
import graylogger
import AFNetworking
import AnalyticsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	var bbTestLog:GraylogInput = {
		let endpoint = GraylogEndpoint.http(host: "107.21.12.75", port: 12301)
		let log = GraylogInput(endpoint: endpoint)
		
//		endpoint.network = CachedNetworkProvider(cacheProvider: MemoryCacheProvider())
//		endpoint.network = CachedNetworkProvider(cacheProvider: CoreDataCacheProvider())
//		endpoint.network = AlamofireNetworkProvider()
//		endpoint.network = CachedNetworkProvider(cacheProvider: CoreDataCacheProvider(), networkProvider: AlamofireNetworkProvider())
//		endpoint.network = AFHTTPSessionManager()
//		endpoint.network = CachedNetworkProvider(cacheProvider: CoreDataCacheProvider(), networkProvider: AFHTTPSessionManager())
//		endpoint.reachability = ReachabilitySwiftProvider()
		
		return log
	}()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		AnalyticsKit.initializeLoggers([GraylogAnalyticsKitProvider(input:bbTestLog)])
		
        return true
    }
	
	var testData:[String:Any] {
		return [
				"NetworkProvider":"\(bbTestLog.endpoint.network.self)",
				"ReachabilityProvider":"\(String(describing: bbTestLog.endpoint.reachability))",
				"Test Date": Date(),
				"    Test Array    ": [1, 2, 3],
				"Test Dictionary": ["one":1, "two":2, "three":3],
				"NON-JSON array": [GraylogSessionError.reachabilityError, GraylogSessionError.emptyPayloadSerializationError(info: "Stuff here")],
//				"This should fail": GraylogSessionError.reachabilityError
				]
	}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
		AnalyticsKit.logEvent("Graylog App applicationWillResignActive", withProperties:self.testData)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		AnalyticsKit.logEvent("Graylog App applicationDidEnterBackground", withProperties:self.testData)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
		AnalyticsKit.logEvent("Graylog App applicationWillEnterForeground", withProperties:self.testData)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		AnalyticsKit.logEvent("Graylog App applicationDidBecomeActive", withProperties:self.testData)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		AnalyticsKit.logEvent("Graylog App applicationWillTerminate", withProperties:self.testData)
    }
}

