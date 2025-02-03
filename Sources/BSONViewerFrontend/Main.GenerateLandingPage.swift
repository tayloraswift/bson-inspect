import ArgumentParser
import HTML

extension Main
{
    struct GenerateLandingPage:ParsableCommand
    {
        static let configuration:CommandConfiguration = .init(
            commandName: "generate-landing-page",
            abstract: "Generate the landing page for BSON Inspector")

        @Argument
        var url:String

        func run()
        {
            print("\(self.html)")
        }
    }
}
extension Main.GenerateLandingPage
{
    private
    var html:HTML
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
                        $0.src = "\(self.url)/main.js"
                    }
                    $0[.title] = "BSON Inspector"
                }
            }
        }
    }
}
