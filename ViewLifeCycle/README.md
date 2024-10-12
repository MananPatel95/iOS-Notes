# UIViewController Lifecycle Notes

## Key Points for Interviews

### 1. Lifecycle Method Order
1. `loadView()`
2. `viewDidLoad()`
3. `viewWillAppear(_:)`
4. `viewDidAppear(_:)`
5. `viewWillDisappear(_:)`
6. `viewDidDisappear(_:)`

### 2. loadView() vs viewDidLoad()
- **loadView()**:
  * Creates view hierarchy
  * Rarely overridden unless creating views 100% programmatically
  * Don't call super if overriding
- **viewDidLoad()**:
  * One-time setup after view is loaded
  * Called only once in the lifecycle
  * Always call super.viewDidLoad()

### 3. viewWillAppear(_:) vs viewDidAppear(_:)
- **viewWillAppear(_:)**:
  * Prepare UI just before becoming visible
  * Called every time view is about to appear
  * Good for updating dynamic content
- **viewDidAppear(_:)**:
  * Called after view is visible
  * Start animations or time-sensitive operations
  * Good for analytics or logging

### 4. Layout Methods
- **viewWillLayoutSubviews()** and **viewDidLayoutSubviews()**:
  * Can be called multiple times (e.g., on rotation)
  * Use for layout adjustments before/after Auto Layout
- **viewWillLayoutSubviews()**: Make changes affecting subview layout
- **viewDidLayoutSubviews()**: Final adjustments after layout

### 5. Memory Management
- **didReceiveMemoryWarning()**:
  * Called when system is low on memory
  * Release any resources that can be recreated
- **deinit**:
  * Final cleanup when view controller is deallocated
  * Release any strong references to prevent retain cycles

### 6. Common Pitfalls
- Overloading viewDidLoad() instead of using viewWillAppear(_:)
- Not cleaning up in viewWillDisappear(_:) or viewDidDisappear(_:)
- Forgetting viewWillAppear(_:) and viewDidAppear(_:) can be called multiple times
- Accessing view's frame in viewDidLoad() (it might not be final)

### 7. Best Practices
- Use viewDidLoad() for one-time setup
- Update UI elements in viewWillAppear(_:)
- Start animations or time-sensitive operations in viewDidAppear(_:)
- Clean up and save state in viewWillDisappear(_:)
- Perform final cleanup in viewDidDisappear(_:)

### 8. Additional Notes
- Always call super for lifecycle methods (except custom loadView())
- Be mindful of retain cycles in closures
- Consider using childViewControllers for complex view hierarchies
- Understand the relationship between loadView(), nibName, and storyboards

### 9. Advanced Topics
- Understand how lifecycle methods work with container view controllers
- Know how to manage lifecycle with custom transitions
- Be familiar with UIViewController state restoration

**Remember**: Explain not just what each method does, but when and why you'd use it!

## Sample Code

```swift
import UIKit

class InterviewLifeCycleViewController: UIViewController {

    override func loadView() {
        super.loadView()
        print("1. loadView()")
        // - Creates the view hierarchy
        // - Called when view is accessed but is nil
        // - Override to create views programmatically
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("2. viewDidLoad()")
        // - Called once after view is loaded into memory
        // - Perform one-time setup
        // - Connect data structures to views
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("3. viewWillAppear(_:)")
        // - Called before the view is added to view hierarchy
        // - Prepare UI for display (e.g., show/hide elements)
        // - Triggered every time view is about to be displayed
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("4. viewDidAppear(_:)")
        // - Called after the view is added to view hierarchy
        // - Start animations or processes that should begin after view is visible
        // - Good place for analytics or logging view appearance
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("5. viewWillLayoutSubviews()")
        // - Called before the view lays out its subviews
        // - Make changes that affect subview layout
        // - Can be called multiple times (e.g., orientation change)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("6. viewDidLayoutSubviews()")
        // - Called after the view lays out its subviews
        // - Make final adjustments after Auto Layout
        // - Access final sizes and positions of subviews
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("7. viewWillDisappear(_:)")
        // - Called before the view is removed from view hierarchy
        // - Save changes, cancel operations
        // - Prepare for view to be hidden
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("8. viewDidDisappear(_:)")
        // - Called after the view is removed from view hierarchy
        // - Perform cleanup, stop services no longer needed
        // - View is no longer visible to user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning()")
        // - Called when system is low on memory
        // - Release any resources that can be recreated
    }

    deinit {
        print("deinit")
        // - Called when view controller is deallocated
        // - Perform final cleanup, release strong references
    }
}
```
