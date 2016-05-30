module wtf.manager;

import std.stdio;
import std.conv;
import std.variant;

import wtf.generator;
import wtf.parser;
import wtf.command;
import wtf.argument;
import wtf.parameter;

class Manager {
    protected const(Generator) _generator;
    protected const(Parser) _parser;
    protected Command[string] _commands;

    this(Generator generator = new Generator(), Parser parser = new Parser())
    {
        this._generator = to!(const Generator)(generator);
        this._parser = to!(const Parser)(parser);
    }

    void add(const string definition, const void delegate(const Variant[const string] parameters, const string raw) handler)
    {
        Command command = this._generator.from(definition, handler);

        this._commands[command.identifier] = command;
    }

    void fire(const string instruction)
    {
        Command command;
        Parameter[] parameters;

        bool found = this._parser.from(instruction, this._commands, &command, &parameters);

        if (! found) {
            throw new Exception("error");
        }

        Variant[string] mapped;

        foreach (Argument argument; command.arguments) {
            mapped[argument.identifier] = null;
        }

        foreach (Parameter parameter; parameters) {
            mapped[parameter.identifier] = parameter.value;
        }

        command.handler(mapped, instruction);
    }

    //const(Generator) getGenerator()
    //{
    //    return this._generator;
    //}

    //const(Parser) getParser()
    //{
    //    return this._parser;
    //}
}
