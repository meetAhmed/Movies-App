//
//  MAnalytics.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 11/04/2025.
//

import Foundation

/*
 Method Swizzling:
 Method Swizzling is a technique used to replace or modify method implementations dynamically at runtime.
 Method swizzling uses dynamic dispatch to alter method behavior.
 Extending or modifying the behavior of existing methods in frameworks or third-party libraries without subclassing.
 Debugging or logging purposes, such as tracking method calls or measuring performance.
 
 ============================
 ============================
 
 Objective-C runtime:
 Objective-C runtime is a runtime library that provides support for the properties of the Objective-C language.
 
 ============================
 ============================
 
 objc_getClassList(buffer, bufferCount) -> Int
 
 This is a method of Objective-C runtime. The Objective-C runtime library automatically registers all the classes defined in our source code.
 We can also create class definitions at runtime and register it with the objc_addClass function.
 
 This method two arguments:
 
 buffer: An array of class values. Total num of registered classes or up to buffer count, whichever is less.
 
 bufferCount: Integer value, represents the space allocated in the buffer.
 
 If we do not pass any arguments, then this method only returns registered classes count. If we pass arguments, then it also fills the buffer with class values.
 
 ============================
 ============================
 
 class_copyMethodList(_:_:)
 Describes the instance methods implemented by a class.
 
 ============================
 ============================
 
 UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(numberOfClasses))
 
 This line allocates memory to store the class pointers. AnyClass represents a pointer to a class type in Objective-C.
 
 ============================
 ============================
 
 objc_getClassList(AutoreleasingUnsafeMutablePointer(classList), numberOfClasses)
 
 In Objective-C, memory management for objects is handled through reference counting and autorelease pools. When we create an object in Objective-C, it is typically retained until it is explicitly released. The autorelease pool is a mechanism that helps manage memory by delaying the release of objects until the end of the current run loop or event cycle.
 
 Swift is built on top of the Objective-C runtime, which means that it also uses autorelease pools for managing Objective-C objects. However, in Swift, we don't usually deal directly with autorelease pools because Swift uses Automatic Reference Counting (ARC) for memory management.
 
 The AutoreleasingUnsafeMutablePointer is a special type of pointer used in situations where we need to pass a pointer to an Objective-C object to a function, and we want to ensure that it will be properly managed by the autorelease pool.
 
 ============================
 ============================
 
 class_getInstanceMethod(_:_:) -> Method?
 
 Method is a pointer.
 
 This function returns a method for a given class and method selector.
 
 ============================
 ============================
 
 class_getClassMethod(_:_:) This method is used to get the static or class methods, for which we do not need to create a class instance or object.
 
 ============================
 ============================
 
 let swizzledImplementation: @convention(block) (AnyObject, AnyObject) -> Void = { instance, arg in
 
 @convention(block): This is a Swift attribute used to specify how the block of code will be called.
 
 In this case, it indicates that the block follows the Objective-C block calling convention. Blocks in Objective-C (and thus in Swift when used with @convention(block)) are closures that are able to be passed around and executed.
 
 This block or closure takes 2 parameters and returns void or nothing.
 
 @convention(c): When we want to use a C function as a callback.
 
 ============================
 ============================
 
 _ : IMP = imp_implementationWithBlock(swizzledImplementationBlock)
 
 This function is part of the Objective-C runtime and is used to convert a block into an IMP (Implementation Pointer).
 
 ============================
 ============================
 
 method_getTypeEncoding(_:)
 
 Returns a C string describing a method's parameter and return types.
 
 ============================
 ============================
 */

public class MAnalytics {
    public func initizalize() {
        self.trackAndReport()
    }
}

private extension MAnalytics {
    /*
     This method tracks and reports analytics data by analyzing the registered classes in the application.
     
     - The method first retrieves the count of registered classes using `objc_getClassList`. If no classes are found, it returns early.
     - For each class in the class list, it calls `analyzeClassDetails` to further process and track analytics data.
     - Finally, the allocated memory for the class list is deallocated to prevent memory leaks.
     
     The purpose of this method is to inspect all classes in the app and analyze their methods for analytics tracking.
     */
    func trackAndReport() {
        // if we do not pass any buffer, this will return count of registered classes
        let classCount = objc_getClassList(nil, 0)
        
        // If no classes found, return early
        guard classCount > 0 else { return }
        
        // Allocate memory for class list
        let classList = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(classCount))
        
        // Use an autoreleasing pointer
        objc_getClassList(AutoreleasingUnsafeMutablePointer(classList), classCount)
        
        for i in 0..<Int(classCount) {
            analyzeClassDetails(targetClass: classList[i])
        }
        
        // Free the memory allocated for the class list
        classList.deallocate()
    }
    
    /*
     This method analyzes the details of a given class, specifically focusing on its methods.
     
     - First, the method checks if the `targetClass` is valid. If not, it returns early.
     - It retrieves the `Bundle` associated with the `targetClass` to determine which bundle the class belongs to.
     - The app's bundle identifier is then fetched to ensure that the class is part of the main app bundle (ignoring system and third-party frameworks).
     - If the class belongs to the app's bundle, it proceeds to fetch the list of methods defined for that class.
     - For each method, the method calls `analyzeMethodDetails` to perform further analysis and tracking.
     
     The main goal of this method is to analyze only the methods of classes belonging to the main app and not external frameworks or system classes.
     */
    func analyzeClassDetails(targetClass: AnyClass?) {
        guard let targetClass else { return }
        
        // Get the bundle for the class
        let classBundle = Bundle(for: targetClass)
        
        // Get the app's bundle identifier
        guard let appBundle = Bundle.main.bundleIdentifier else { return }
        
        // Only proceed if the class belongs to the main app bundle (ignore system and third-party frameworks)
        guard classBundle.bundleIdentifier.stringValue == appBundle else { return }
        
        // Get the list of methods for the target class and store the count of methods
        var methodCount: UInt32 = 0
        guard let methods = class_copyMethodList(targetClass, &methodCount) else { return }
        
        for i in 0..<Int(methodCount) {
            analyzeMethodDetails(targetMethod: methods[i], targetClass: targetClass)
        }
    }
    
    /*
     This method analyzes a target method from the given class and performs the following tasks:
     - Skip methods that are initializers (methods starting with "init").
     - Skip methods that have parameters, and only handle methods with no parameters.
     - Swizzle the method's implementation by creating a custom block that tracks the method call and executes the original method.
     
     The end result is that whenever a method without parameters is called, it logs the call and executes the original method.
     */
    func analyzeMethodDetails(targetMethod: Method, targetClass: AnyClass) {
        let className = String(describing: targetClass)
        let methodName = NSStringFromSelector(method_getName(targetMethod))
        
        // Check if the method is an initializer (methods that start with "init")
        // If it is an initializer, skip swizzling it and log the action
        if methodName.hasPrefix("init") {
            // track event
            print("MAnalytics \(className).\(methodName) init called")
            return
        }
        
        // Get the number of arguments for the method and subtract 2:
        // - The first argument is always the `self` (instance of the class).
        // - The second argument is always the `_cmd` (the selector being called).
        // By subtracting 2, we get the count of the actual parameters passed to the method.
        let methodArgsCount = method_getNumberOfArguments(targetMethod) - 2
        
        // Ensure the method has no parameters (methodArgsCount == 0).
        // If the method has any parameters, we skip swizzling it.
        guard methodArgsCount == 0 else {
            // track event
            print("MAnalytics \(className).\(methodName) has multiple parameters")
            return
        }
        
        // get and store the actual implementation or block of code for target method
        let targetMethodImpl = method_getImplementation(targetMethod)
        
        // create new implementation using a convention block
        // @convention(block) -> indicates that block will follow Objective-C calling convention.
        // block or closure has 2 parameters, returns nothing
        //
        // In swizzle method, we will first call the target method and then print target method parameter details.
        let swizzledImplementationBlock: @convention(block) (AnyObject) -> Void = { instance in
            // type alias for the target method signature
            // target method follows C calling convention
            //
            // AnyObject: instance on which method is called.
            // Selector: name of method being called.
            // AnyObject: parameter which target method takes.
            typealias TargetMethodType = @convention(c) (AnyObject, Selector) -> Void
            
            // unsafeBitCast is used to convert target method impl to specific function type.
            let method = unsafeBitCast(targetMethodImpl, to: TargetMethodType.self)
            
            // call the method
            method(instance, method_getName(targetMethod))
            
            // track event
            print("MAnalytics \(className).\(methodName) called")
        }
        
        // convert the block to an IMP (Implementation Pointer)
        let swizzledImpl: IMP = imp_implementationWithBlock(swizzledImplementationBlock)
        
        // method_getTypeEncoding: return C string which describe method's parameters and return type
        let methodTypeEncoding = method_getTypeEncoding(targetMethod)
        
        // create new selector for the swizzled method
        let swizzledSelector = NSSelectorFromString("swizzled_\(methodName)")
        
        // add the swizzled method to the class
        if class_addMethod(targetClass, swizzledSelector, swizzledImpl, methodTypeEncoding) {
            // get the newly added swizzled method
            if let swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector) {
                // exchange the implementations
                method_exchangeImplementations(targetMethod, swizzledMethod)
            }
        }
    }
}
