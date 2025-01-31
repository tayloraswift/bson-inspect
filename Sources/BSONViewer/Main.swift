import BSON
import JavaScriptKit

@main
enum Main
{
    static func main()
    {
        guard
        case .object(let tray) = JSObject.global.document.createElement("div"),
        case .object(let list) = JSObject.global.document.createElement("dl")
        else
        {
            fatalError("Could not create elements")
        }

        tray.innerHTML = .string("Drop a BSON file")

        _ = tray.addEventListener?("dragover", JSClosure.init
        {
            _ = $0[0].preventDefault()
            return .undefined
        })

        _ = tray.addEventListener?("drop", JSClosure.init
        {
            let event:JSValue = $0[0]
            _ = event.preventDefault()

            guard
            case .object(let data) = event.dataTransfer
            else
            {
                return .undefined
            }

            print(data)
            print(data.files)

            guard data.files.length == 1
            else
            {
                print("Need exactly one file")
                return .undefined
            }

            guard
            case .object(let file) = data.files[0],
            case .object(let promise)? = file.bytes?()
            else
            {
                print("Not a file")
                return .undefined
            }

            _ = promise.then?(JSClosure.init
            {
                guard case .object(let typedArray) = $0[0]
                else
                {
                    print("Not bytes")
                    return .undefined
                }

                let bytes:[UInt8] = JSTypedArray<UInt8>.init(
                    unsafelyWrapping: typedArray).withUnsafeBytes
                {
                    [UInt8].init($0)
                }

                let bson:BSON.Document = .init(bytes: bytes[...])

                guard
                case .object(let name) = JSObject.global.document.createElement("dt"),
                case .object(let contents) = JSObject.global.document.createElement("dd")
                else
                {
                    print("Could not create elements")
                    return .undefined
                }

                bson.expand(in: contents)
                bson.attach(toggle: name, container: contents)

                _ = list.appendChild?(name)
                _ = list.appendChild?(contents)

                return .undefined
            })

            return .undefined
        })

        _ = JSObject.global.document.body.appendChild(tray)
        _ = JSObject.global.document.body.appendChild(list)
    }
}
