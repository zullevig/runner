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
    
    func listDependencies(_ request: Request) throws -> Future<[WorkItem]> {
        let workItemID: Int = try request.parameters.next(Int.self)
        return WorkItem.find(workItemID, on: request).flatMap(to: [WorkItem].self)  { workItem in
            guard let unwrappedWorkItem = workItem else { throw Abort.init(HTTPStatus.notFound) }
            let dependencies = try unwrappedWorkItem.dependencies.query(on: request).all()
            return dependencies
        }
    }
    
    func listOutputs(_ request: Request) throws -> Future<[Object]> {
        let workItemID: Int = try request.parameters.next(Int.self)
        return WorkItem.find(workItemID, on: request).flatMap(to: [Object].self)  { workItem in
            guard let unwrappedWorkItem = workItem else { throw Abort.init(HTTPStatus.notFound) }
            let outputs = try unwrappedWorkItem.outputs.query(on: request).all()
            return outputs
        }
    }
    
    func listIngredients(_ request: Request) throws -> Future<[Object]> {
        let workItemID: Int = try request.parameters.next(Int.self)
        return WorkItem.find(workItemID, on: request).flatMap(to: [Object].self)  { workItem in
            guard let unwrappedWorkItem = workItem else { throw Abort.init(HTTPStatus.notFound) }
            let ingredients = try unwrappedWorkItem.ingredients.query(on: request).all()
            return ingredients
        }
    }

    func listCueItems(_ request: Request) throws -> Future<[CueItem]> {
        let workItemID: Int = try request.parameters.next(Int.self)
        return WorkItem.find(workItemID, on: request).flatMap(to: [CueItem].self)  { workItem in
            guard let unwrappedWorkItem = workItem else { throw Abort.init(HTTPStatus.notFound) }
            let cueItems = try unwrappedWorkItem.cueItems.query(on: request).all()
            return cueItems
        }
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
    
    func listWorkItems(_ request: Request) throws -> Future<[WorkItem]> {
        let jobID: Int = try request.parameters.next(Int.self)
        return Job.find(jobID, on: request).flatMap(to: [WorkItem].self)  { job in
            guard let unwrappedJob = job else { throw Abort.init(HTTPStatus.notFound) }
            let workItems = try unwrappedJob.workItems.query(on: request).all()
            return workItems
        }
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

final class WorkItemEventController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[WorkItemEvent]> {
        let models = WorkItemEvent.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<WorkItemEvent> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = WorkItemEvent.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<WorkItemEvent> {
        let model = try request.content.decode(WorkItemEvent.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<WorkItemEvent> {
        let model = try request.content.decode(WorkItemEvent.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<WorkItemEvent> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = WorkItemEvent.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}

final class JobEventController {
    // API fetch all request example
    func list(_ request: Request) throws -> Future<[JobEvent]> {
        let models = JobEvent.query(on: request).all()
        return models
    }
    
    // API fetch item by ID request example
    func get(_ request: Request) throws -> Future<JobEvent> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = JobEvent.find(modelID, on: request).unwrap(or: NotFound())
        return model
    }
    
    // API create item request example
    func create(_ request: Request) throws -> Future<JobEvent> {
        let model = try request.content.decode(JobEvent.self)
        return model.create(on: request)
    }
    
    // API update item request example
    func update(_ request: Request) throws -> Future<JobEvent> {
        let model = try request.content.decode(JobEvent.self)
        return model.update(on: request)
    }
    
    // API delete item request example
    func delete(_ request: Request) throws -> Future<JobEvent> {
        let modelID: Int = try request.parameters.next(Int.self)
        let model = JobEvent.find(modelID, on: request).unwrap(or: NotFound())
        return model.delete(on: request)
    }
}

