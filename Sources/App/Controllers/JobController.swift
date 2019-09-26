import Vapor

final class ObjectController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[Object]> {
        let models = Object.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<Object> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = Object.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<Object> {
        let model = try request.content.decode(Object.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<Object> {
        let model = try request.content.decode(Object.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<Object> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = Object.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}

final class CueItemController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[CueItem]> {
        let models = CueItem.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<CueItem> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = CueItem.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<CueItem> {
        let model = try request.content.decode(CueItem.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<CueItem> {
        let model = try request.content.decode(CueItem.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<CueItem> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = CueItem.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}

final class WorkItemController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[WorkItem]> {
        let models = WorkItem.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<WorkItem> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = WorkItem.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<WorkItem> {
        let model = try request.content.decode(WorkItem.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<WorkItem> {
        let model = try request.content.decode(WorkItem.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<WorkItem> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = WorkItem.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}

final class JobController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[Job]> {
        let models = Job.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<Job> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = Job.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<Job> {
        let model = try request.content.decode(Job.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<Job> {
        let model = try request.content.decode(Job.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<Job> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = Job.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}
