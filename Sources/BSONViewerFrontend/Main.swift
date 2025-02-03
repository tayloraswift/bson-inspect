import ArgumentParser

@main
struct Main:ParsableCommand
{
    static let configuration:CommandConfiguration = .init(
        commandName: "bson-inspect-frontend",
        subcommands: [GenerateLandingPage.self])
}
