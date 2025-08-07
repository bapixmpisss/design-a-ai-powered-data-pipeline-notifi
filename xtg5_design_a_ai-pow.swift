import Foundation

// Data Model: AI-Powered Data Pipeline Notifier

// MARK: - PipelineNotification
struct PipelineNotification: Identifiable, Codable {
    let id = UUID()
    var pipelineName: String
    var notificationType: NotificationType
    var message: String
    var timestamp: Date
    
    enum NotificationType: String, Codable {
        case dataIngestionSuccess
        case dataIngestionFailure
        case modelTrainingSuccess
        case modelTrainingFailure
        case modelDeploymentSuccess
        case modelDeploymentFailure
    }
}

// MARK: - DataPipeline
struct DataPipeline: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var notificationThreshold: Int
    var notifications: [PipelineNotification] = []
    
    mutating func addNotification(_ notification: PipelineNotification) {
        notifications.append(notification)
    }
}

// MARK: - AIModel
struct AIModel: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var version: String
    var pipeline: DataPipeline?
    
    enum Status: String, Codable {
        case training
        case deployed
        case failed
    }
    
    var status: Status = .training
}

// MARK: - Notifier
class Notifier {
    var pipelineNotifications: [PipelineNotification] = []
    
    func notify(pipelineNotification: PipelineNotification) {
        pipelineNotifications.append(pipelineNotification)
        print("Notification sent: \(pipelineNotification.message)")
    }
}

// Sample Data
let pipeline = DataPipeline(name: "MyPipeline", description: "My Data Pipeline", notificationThreshold: 10)
let model = AIModel(name: "MyModel", description: "My AI Model", version: "1.0", pipeline: pipeline)
let notification = PipelineNotification(pipelineName: pipeline.name, notificationType: .dataIngestionSuccess, message: "Data ingestion successful!", timestamp: Date())
let notifier = Notifier()
notifier.notify(pipelineNotification: notification)