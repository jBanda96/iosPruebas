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



func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {
    case (true, false):
        return "Fizz"
    case (false, true):
        return "Buzz"
    case (true, true):
        return "FizzBuzz"
    default:
        return String(number)
    }
}

print(fizzbuzz(number: 15))


let url = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
    print((response as? HTTPURLResponse)?.statusCode ?? 0)
}
session.resume()
