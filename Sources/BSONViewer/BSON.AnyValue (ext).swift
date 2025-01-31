import BSON
import JavaScriptKit

extension BSON.AnyValue
{
    func attach(toggle dt:JSObject, container dd:JSObject)
    {
        switch self
        {
        case .document(let value):
            dt.className = .string("document")
            dd.className = .string("document")
            value.attach(toggle: dt, container: dd)

        case .list(let value):
            dt.className = .string("list")
            dd.className = .string("list")
            value.attach(toggle: dt, container: dd)

        case .binary(let value):
            dt.className = .string("binary")
            dd.innerText = .string("[ Binary Array = \(value.bytes.count) bytes ]")

        case .bool(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("bool")

        case .decimal128(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("decimal128")

        case .double(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("double")

        case .id(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("id")

        case .int32(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("int32")

        case .int64(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("int64")

        case .javascript(let code):
            guard
            case .object(let container) = JSObject.global.document.createElement("dl"),
            case .object(let dtjs) = JSObject.global.document.createElement("dt"),
            case .object(let ddjs) = JSObject.global.document.createElement("dd")
            else
            {
                return
            }

            ddjs.innerText = .string("\(code)")

            _ = container.appendChild?(dtjs)
            _ = container.appendChild?(ddjs)

            _ = dd.appendChild?(container)
            _ = dd.className = .string("javascript")

        case .javascriptScope(let scope, let code):
            guard
            case .object(let container) = JSObject.global.document.createElement("dl"),
            case .object(let dtjs1) = JSObject.global.document.createElement("dt"),
            case .object(let ddjs1) = JSObject.global.document.createElement("dd"),
            case .object(let dtjs2) = JSObject.global.document.createElement("dt"),
            case .object(let ddjs2) = JSObject.global.document.createElement("dd")
            else
            {
                return
            }

            ddjs1.className = .string("document")
            scope.attach(toggle: dtjs1, container: ddjs1)

            ddjs2.innerText = .string("\(code)")

            _ = container.appendChild?(dtjs1)
            _ = container.appendChild?(ddjs1)

            _ = container.appendChild?(dtjs2)
            _ = container.appendChild?(ddjs2)

            _ = dd.appendChild?(container)
            _ = dd.className = .string("javascript")

        case .max:
            dd.innerText = .string("max")
            dd.className = .string("max")

        case .millisecond(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("millisecond")

        case .min:
            dd.innerText = .string("min")
            dd.className = .string("min")

        case .null:
            dd.innerText = .string("null")
            dd.className = .string("null")

        case .pointer(let value, let id):
            dd.innerText = .string("\(value) \(id)")
            dd.className = .string("pointer")

        case .regex(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("regex")

        case .string(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("string")

        case .timestamp(let value):
            dd.innerText = .string("\(value)")
            dd.className = .string("timestamp")
        }
    }
}
