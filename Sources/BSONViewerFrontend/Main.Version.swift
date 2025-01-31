import _GitVersion
import ArgumentParser

extension Main
{
    struct Version:ParsableCommand
    {
        static var string:String { .init(cString: _GitVersion.swiftpm_git_version()) }

        func run() throws
        {
            print(Self.string)
        }
    }
}
