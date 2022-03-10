//
//  Logger.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 03.03.22.
//

import Foundation

import Foundation

open class Logger {

    public enum Format: Int, CaseIterable {
        case short, middle, long
    }

    public enum Level: Int, Comparable, CaseIterable {
        case error, warning, info, debug, verbose
        public static func < (lhs: Logger.Level, rhs: Logger.Level) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        public var stringValue: String {
            switch self {
            case .debug:
                return "debug"
            case .error:
                return "error"
            case .info:
                return "info"
            case .verbose:
                return "verbose"
            case .warning:
                return "warning"
            }
        }
        public var codeValue: String {
            switch self {
            case .debug:
                return "D"
            case .error:
                return "E"
            case .info:
                return "I"
            case .verbose:
                return "V"
            case .warning:
                return "W"
            }
        }

        public var symbol: String {
            switch self {
            case .error:
                return "‼️"
            case .info:
                return "✅"
            case .verbose, .debug:
                return "**"
            case .warning:
                return "⚠️"
            }
        }

        public init?(stringValue: String) {
            let matches = Self.allCases.filter { $0.stringValue == stringValue }
            if let first = matches.first {
                self = first
            } else {
                return nil
            }
        }
    }
    
    public static var level = RuntimeInfo.isRelease ? Level.info : Level.verbose
    public static var loggerType: Logger.Type = (RuntimeInfo.isUnderSwiftUIPreview || RuntimeInfo.isRelease) ? Logger.self : Logger.self

    public static var id = "App"
    public static var format = Format.short

    public static func getLogger(_ type: Any.Type, level: Level = .verbose) -> Logger {
        return loggerType.init(String(describing: type), level: level)
    }

    public static func getLogger(_ name: String, level: Level = .verbose) -> Logger {
        return loggerType.init(name, level: level)
    }

    public static func getLogger(_ name: String, typeSuffix: Any.Type, level: Level = .verbose) -> Logger {
        return loggerType.init(name + " \(String(describing: typeSuffix))", level: level)
    }
    
    public static func getLogger(_ tags: String..., level: Level = .verbose) -> Logger {
        return loggerType.init(tags.joined(separator: ";"), level: level)
    }

    public let name: String
    public let level: Level

    public required init(_ name: String, level: Level = .debug) {
        self.name = name
        self.level = level
    }

    open func initialize(function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .verbose, category: name, message: "(Memory) +++", function: function, file: file, line: line, dso: dso)
    }

    open func initialize(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .verbose, category: name, message: "(Memory) +++ \(message)", function: function, file: file, line: line, dso: dso)
    }

    open func deinitialize(function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .verbose, category: name, message: "(Memory) ~~~", function: function, file: file, line: line, dso: dso)
    }

    open func deinitialize(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .verbose, category: name, message: "(Memory) ~~~ \(message)", function: function, file: file, line: line, dso: dso)
    }

    open func verbose(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .verbose, category: name, message: message, function: function, file: file, line: line, dso: dso)
    }

    open func verbose(_ message: String, if expression: @autoclosure () -> Bool, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
       guard expression() else { return }
       verbose(message, function: function, file: file, line: line, dso: dso)
    }

    open func debug(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .debug, category: name, message: message, function: function, file: file, line: line, dso: dso)
    }

    open func info(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .info, category: name, message: message, function: function, file: file, line: line, dso: dso)
    }

    open func warning(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .warning, category: name, message: message, function: function, file: file, line: line, dso: dso)
    }

    open func error(_ message: String, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        log(level: .error, category: name, message: message, function: function, file: file, line: line, dso: dso)
    }

    open func error(_ error: Error, function: String = #function, file: String = #file, line: UInt = #line, dso: UnsafeRawPointer? = #dsohandle) {
        self.error(String(describing: error), function: function, file: file, line: line, dso: dso)
    }

    open func format(message: String, level: Level, function: String, file: String, line: UInt) -> String {
        let filename = ("\(file)" as NSString).lastPathComponent
        let location = "\(filename):\(line)"
        let id = "[\(name)]"
        let level = "[\(Self.id)/\(level.codeValue)] \(level.symbol)"
        let msg: String
        switch Self.format {
        case .short:
            msg = "\(level) \(location) → \(message)"
        case .middle:
            msg = "\(level) \(id) \(location) → \(message)"
        case .long:
            msg = "\(level) \(id) \(location) ⋆ \(function) → \(message)"
        }
        return msg
    }

    public func isEnabled(level: Level) -> Bool {
        guard Self.level >= level else {
            return false
        }
        guard self.level >= level else {
            return false
        }
        return true
    }

    // swiftlint:disable:next function_parameter_count
    open func log(level: Level, category: String, message: String,
                  function: String, file: String, line: UInt, dso: UnsafeRawPointer?) {
        guard isEnabled(level: level) else {
            return
        }
        let message = format(message: message, level: level, function: function, file: file, line: line)
        log(level: level, message: message, category: category, dso: dso)
    }

    open func log(level: Level, message: String, category: String, dso: UnsafeRawPointer?) {
        guard isEnabled(level: level) else {
            return
        }
        print(message)
    }
}

