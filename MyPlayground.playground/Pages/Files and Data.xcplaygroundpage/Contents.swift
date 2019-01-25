import UIKit

let fileURLPath = FileManager.documentDirectoryURL

let misteryBytes: [UInt8] = [
    240,            159,            152,            184,
    240,            159,            152,            185,
    0b1111_0000,    0b1001_1111,    0b1001_1000,    186,
    0xF0,           0x9F,           0x98,           187
]

let misteryDataURL  =   URL(fileURLWithPath: "mistery", relativeTo: fileURLPath).appendingPathExtension("txt")
let misteryData     =   Data(bytes: misteryBytes)

do {
    try misteryData.write(to: misteryDataURL)
} catch {
    error.localizedDescription
}

let savedMisteryData    =   try Data(contentsOf: misteryDataURL)
let string              =   String(data: savedMisteryData, encoding: .utf8) ?? ""

let stringURL = fileURLPath.appendingPathComponent("string").appendingPathExtension("txt")

try string.write(to: stringURL, atomically: true, encoding: .utf8)


struct Image: Codable {
    
    enum Kind: String, Codable {
        case scene
        case sticker
    }
    
    enum DecodingError: Error {
        case missingFile
    }
    
    let name:       String
    let kind:       Kind
    let pngData:    Data

}

extension Array where Element == Image {
    
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { throw Image.DecodingError.missingFile }
        
        let jsonDecoder =   JSONDecoder()
        let data        =   try Data(contentsOf: url)
        
        self = try jsonDecoder.decode([Image].self, from: data)
        
    }
    
}

let imagesa = try [Image](fileName: "images")
imagesa.map{ UIImage(data: $0.pngData) }

let images = [#imageLiteral(resourceName: "qr.JPG"), #imageLiteral(resourceName: "qr.JPG"), #imageLiteral(resourceName: "qr.JPG")]

let imageViews: [UIImageView] = images.map {
    let imageView = UIImageView(image: $0)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}

let spacerGuide     =   (0..<images.count - 1).map { _ in UILayoutGuide() }

let img = [
    (["monday", "tuesday", "wednesday"], imageViews),
    (["leftGap", "rightGap"], spacerGuide)
    ].flatMap { (keys, values: [Any]) in zip(keys, values) }

print(img)


