public struct JobApplicant {
    public let name: String
    public let email: String
    public var status: Status
    
    public enum Status {
        case new
        case interview
        case hired
        case rejected
    }
}

public struct Email {
    public let subject: String
    public let messageBody: String
    public let recipientEmail: String
    public let senderEmail: String
}

public struct EmailFactory {
    
    public let senderEmail: String
    
    public func createEmail(ro recipient: JobApplicant) -> Email {
        let subject: String
        let messageBody: String
        
        switch recipient.status {
        case .new:
            subject = "We receive your application"
            messageBody = "Thanks for applying for a job here! " + "You shoukd hear from us in 17-42 business days."
        case .interview:
            subject = "We Want to Interview You"
            messageBody = "Thanks for your resume, \(recipient.name)! " + "Can you come in for an interview in 30 minutes?"
        case .hired:
            subject = "We Want to Hire You"
            messageBody = "Congratulations, \(recipient.name)! " +
                "We liked your code, and you smelled nice. " + "We want to offer you a position! Cha-ching! $$$"
        case .rejected:
            subject = "Thanks for Your Application"
                messageBody = "Thank you for applying, \(recipient.name)! " +
                "We have decided to move forward with other candidates. " + "Please remember to wear pants next time!"
        }
        
        return Email(subject: subject, messageBody: messageBody, recipientEmail: recipient.email, senderEmail: senderEmail)
    }
}


var jackson = JobApplicant(name: "Jackson Smith", email: "jackson.smith@example.com", status: .new)
let emailFactory = EmailFactory(senderEmail: "RaysMinions@RaysCoffeeCo.com")
print(emailFactory.createEmail(ro: jackson), "\n")

jackson.status = .interview
print(emailFactory.createEmail(ro: jackson), "\n")

jackson.status = .hired
print(emailFactory.createEmail(ro: jackson), "\n")