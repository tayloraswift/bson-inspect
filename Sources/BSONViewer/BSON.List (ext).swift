import BSON
import JavaScriptKit

extension BSON.List:ExpandableAsDOM
{
    func expand(in node:JSObject)
    {
        guard case .object(let dl) = JSObject.global.document.createElement("dl")
        else
        {
            return
        }

        do
        {
            var elements:BSON.ListDecoder = self.parsed
            while let next:BSON.FieldDecoder<Int> = try elements[+]
            {
                guard
                case .object(let dt) = JSObject.global.document.createElement("dt"),
                case .object(let dd) = JSObject.global.document.createElement("dd")
                else
                {
                    continue
                }

                dt.innerText = .string("\(next.key)")
                next.value.attach(toggle: dt, container: dd)

                _ = dl.appendChild?(dt)
                _ = dl.appendChild?(dd)
            }
        }
        catch
        {
            print(error)
        }

        _ = node.appendChild?(dl)
    }
}
