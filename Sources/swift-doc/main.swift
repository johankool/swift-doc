import ArgumentParser
import Foundation
import Logging
import LoggingGitHubActions

LoggingSystem.bootstrap { label in
    if ProcessInfo.processInfo.environment["GITHUB_ACTIONS"] == "true" {
        return GitHubActionsLogHandler.standardOutput(label: label)
    } else {
        return StreamLogHandler.standardOutput(label: label)
    }
}

let logger = Logger(label: "org.swiftdoc.swift-doc")

let fileManager = FileManager.default
let fileAttributes: [FileAttributeKey : Any] = [.posixPermissions: 0o744]

var standardOutput = FileHandle.standardOutput
var standardError = FileHandle.standardError

struct SwiftDoc: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for generating documentation for Swift code.",
        subcommands: [Generate.self, Coverage.self, Diagram.self]
    )
}

SwiftDoc.main()
