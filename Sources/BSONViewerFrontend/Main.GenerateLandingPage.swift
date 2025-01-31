import ArgumentParser
import HTML

extension Main
{
    struct GenerateLandingPage:ParsableCommand
    {
        static let configuration:CommandConfiguration = .init(
            commandName: "generate-landing-page",
            abstract: "Generate the landing page for BSON Inspector")

        func run()
        {
            let html:HTML = Self.html(version: Version.string)
            print("\(html)")
        }
    }
}
extension Main.GenerateLandingPage
{
    private
    static func html(version:String) -> HTML
    {
        .init
        {
            $0[.html, { $0.lang = "en" }]
            {
                $0[.head]
                {
                    $0[.meta] { $0.charset = "utf-8" }
                    $0[.meta]
                    {
                        $0.name = "viewport"
                        $0.content = "width=device-width, initial-scale=1.0"
                    }
                    $0[.script]
                    {
                        $0.src = "\(version)/main.js"
                    }
                    $0[.title] = "BSON Inspector"
                }
            }
        }
    }
}
