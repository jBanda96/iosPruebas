//: ### Factory Pattern
import CoreImage
import UIKit 

public protocol QR {
    var string: String? { get }
}


public struct Simple: QR {
    public let string: String?
}

public struct Web: QR {
    public var string: String? {
        return url?.absoluteString
    }
    
    private(set) var url: URL?
    
    public mutating func setUrl(string: String) {
        let url = URL(string: string)
        self.url = url
    }
    
    public mutating func setUrl(_ url: URL) {
        self.url = url
    }
}

public struct Sms: QR {
    public var string: String? {
        return String(format: "smsto:%@:%@", phone, text)
    }
    
    let phone: String
    let text: String
}

public struct Call: QR {
    public var string: String? {
        return String(format: "tel:%@", phone)
    }
    
    let phone: String
}

public struct QrGenerator {
    
    public func generateQr(with data: QR) -> UIImage? {
        let data = data.string?.data(using: .isoLatin1)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let output = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10, y: 10)) { 
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}


let simpleQr = Simple(string: "J&K")

var webQr = Web()
webQr.setUrl(URL(string: "http://www.google.com")!)

let card = Sms(phone: "5530544732", text: "Hello there!")
let call = Call(phone: "5530544732")

QrGenerator().generateQr(with: simpleQr)
QrGenerator().generateQr(with: webQr)
QrGenerator().generateQr(with: card)
QrGenerator().generateQr(with: call)
























// Product
struct CoDi {
    let name:       String
    let code:       Int
    let amount:     Double?
    let concept:    String
    let reference:  Int
}


extension CoDi: CustomStringConvertible {
    var description: String {
        return """
            CoDi(
                Name:       \(name),
                Code:       \(code),
                Amount:     \(String(describing: amount)),
                Concept:    \(concept),
                Reference:  \(reference)
            )
        """
    }
}

protocol Builder {
    func setName(_: String)
    func setCode(_: Int)
    func setAmount(_: Double)
    func setConcept(_: String)
    func setReference(_: Int)
}

class CoDiBuilder: Builder {
    private(set) var name:      String?
    private(set) var code:      Int?
    private(set) var amount:    Double?
    private(set) var concept:   String?
    private(set) var reference: Int?
    
    public func setName(_ name: String) {
        self.name = name
    }
    
    public func setCode(_ code: Int) {
        self.code = code
    }
    
    public func setAmount(_ amount: Double) {
        self.amount = amount
    }
    
    public func setConcept(_ concept: String) {
        self.concept = concept
    }
    
    public func setReference(_ reference: Int) {
        self.reference = reference
    }
    
    public func build() -> CoDi? {
        guard let name = name, let code = code, let concept = concept, let reference = reference else { return nil }
        return CoDi(name: name, code: code, amount: amount, concept: concept, reference: reference)
    }
}


let codiBuilder = CoDiBuilder()
codiBuilder.setName("Julio")
codiBuilder.setCode(1)
codiBuilder.setConcept("Sn")
codiBuilder.setReference(13543)

print(codiBuilder.build())
