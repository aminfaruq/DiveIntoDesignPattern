//
//  CompositeExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/02/25.
//

import XCTest

final class CompositeExampleTests: XCTestCase {
    
    func testCompositeRealWorld() {
        print("\nClient: Applying 'default' theme for 'NSButton'")
        apply(theme: DefaultButtonTheme(), for: NSButton())
        
        print("\nClient: Applying 'night' theme for 'NSButton'")
        apply(theme: NightButtonTheme(), for: NSButton())
        
        print("\nClient: Let's use View Controller as a composite!")
        
        print("\nClient: Applying 'night button' theme for 'WelcomeViewController'...")
        apply(theme: NightButtonTheme(), for: WelcomeViewController())
        print()
        
        print("\nClient: Applying 'night label' theme for 'WelcomeViewController'...")
        apply(theme: NightLabelTheme(), for: WelcomeViewController())
        print()
        
        print("\nClient: Applying 'default button' theme for 'WelcomeViewController'...")
        apply(theme: DefaultButtonTheme(), for: WelcomeViewController())
        print()
        
        print("\nClient: Applying 'default label' theme for 'WelcomeViewController'...")
        apply(theme: DefaultLabelTheme(), for: WelcomeViewController())
        print()
    }
    
    func apply<T: Theme>(theme: T, for component: CompositeRealWorldComponent) {
        component.accept(theme: theme)
    }
    
}
