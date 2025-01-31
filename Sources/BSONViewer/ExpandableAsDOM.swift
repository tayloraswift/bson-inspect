import JavaScriptKit

protocol ExpandableAsDOM
{
    func expand(in node:JSObject)
}
extension ExpandableAsDOM
{
    func attach(toggle:JSObject, container:JSObject)
    {
        _ = toggle.addEventListener?("click", JSClosure.init
        {
            _ in

            if  case .boolean(true) = container.hasChildNodes?()
            {
                _ = container.replaceChildren?()
            }
            else
            {
                self.expand(in: container)
            }

            return .undefined
        })
    }
}
