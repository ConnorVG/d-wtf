module wtf.parser;

import std.stdio;
import std.regex : regex, ctRegex, matchAll, Captures;
import std.array : split;
import std.variant;

import wtf.command;
import wtf.parameter;

debug { } else {
    auto matcher = ctRegex!(`(([^"\s"])+)|"((?:[^"])+)"`);
}

class Parser {
    const bool from(
        const string instruction,
        Command[string] commands,
        Command* command,
        Parameter[]* parameters
    ) {
        debug auto matcher = regex(`(([^"\s"])+)|"((?:[^"])+)"`);

        writeln("instruction: '", instruction, "'");

        const string[] parts = split(instruction, ' ');

        if (parts.length == 0) {
            throw new Exception("error!");
        }

        const string identifier = parts[0];

        if (identifier !in commands) {
            throw new Exception("error!");
        }

        *command = commands[identifier];
        *parameters = [];

        if (command.arguments.length == 0) {
            return true;
        }

        auto matches = matchAll(instruction, matcher);
        int i = 0;
        int argument = 0;
        foreach (Captures!(string, ulong) part; matches) {
            if (i == 0) {
                i++;

                continue;
            }

            string param = (part.back() == "" ? part.front() : part.back());

            // @todo
            *parameters ~= Parameter("message", Variant(param));
        }

        return true;
    }
}
