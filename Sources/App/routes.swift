import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // MARK: - Object API with Controller
    let objectController = ObjectController()
    // API fetch all request example
    router.get("object", use: objectController.list)
    // API fetch item by ID request example
    router.get("object", Int.parameter, use: objectController.get)
    // API create item request example
    router.post("object", use: objectController.create)
    // API update item request example
    router.post("object", "update", use: objectController.update)
    // API delete item request example
    router.delete("object", Int.parameter, use: objectController.delete)
    
    // MARK: - CueItem API with Controller
    let cueItemController = CueItemController()
    // API fetch all request example
    router.get("cueitem", use: cueItemController.list)
    // API fetch item by ID request example
    router.get("cueitem", Int.parameter, use: cueItemController.get)
    // API create item request example
    router.post("cueitem", use: cueItemController.create)
    // API update item request example
    router.post("cueitem", "update", use: cueItemController.update)
    // API delete item request example
    router.delete("cueitem", Int.parameter, use: cueItemController.delete)
    
    // MARK: - WorkItem API with Controller
    let workItemController = WorkItemController()
    // API fetch all request example
    router.get("workitem", use: workItemController.list)
    // API fetch item by ID request example
    router.get("workitem", Int.parameter, use: workItemController.get)
    // API create item request example
    router.post("workitem", use: workItemController.create)
    // API update item request example
    router.post("workitem", "update", use: workItemController.update)
    // API delete item request example
    router.delete("workitem", Int.parameter, use: workItemController.delete)
    
    // MARK: - Job API with Controller
    let jobController = JobController()
    // API fetch all request example
    router.get("job", use: jobController.list)
    // API fetch item by ID request example
    router.get("job", Int.parameter, use: jobController.get)
    // API create item request example
    router.post("job", use: jobController.create)
    // API update item request example
    router.post("job", "update", use: jobController.update)
    // API delete item request example
    router.delete("job", Int.parameter, use: jobController.delete)

    // Basic "It works" example
    router.get { request in
        return "It works!"
    }
    
    // Basic "Hello, world!" parameter example
    router.get("hello") { request in
        return "Hello, world!"
    }
    
    // MARK: - API with Controller Examples
    let testModelAPIController = TestModelController()
    // API fetch all request example
    router.get("testmodel", use: testModelAPIController.list)
    // API fetch item by ID request example
    router.get("testmodel", Int.parameter, use: testModelAPIController.getModel)
    // API create item request example
    router.post("testmodel", use: testModelAPIController.create)    
    // API update item request example
    router.post("testmodel", "update", use: testModelAPIController.update)
    // API delete item request example
    router.delete("testmodel", Int.parameter, use: testModelAPIController.delete)

    // MARK: - Web Interface Examples

    // Web present all request example
    router.get("testweb") { request -> Future<View> in
        return TestModel.query(on: request).all().flatMap { results in
            let data = ["testlist": results]
            return try request.view().render("testview", data)
        }
    }
    
    // Web form post new item example
    router.post("testweb") { request in
        return try request.content.decode(TestModel.self).flatMap { item in
            return item.save(on: request).map { _ in
                return request.redirect(to: "testweb")
            }
        }
    }
}

