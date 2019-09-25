import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { request in
        return "It works!"
    }
    
    // Basic "Hello, world!" parameter example
    router.get("hello") { request in
        return "Hello, world!"
    }
    
    // MARK: - API with Controller Examples
    let testModelAPIController = TestModelAPIController()
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
