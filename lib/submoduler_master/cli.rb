# frozen_string_literal: true

require 'optparse'
require_relative 'init_command'
require_relative 'validate_command'

module SubmodulerMaster
  class CLI
    COMMANDS = {
      'init' => 'Initialize a new Submoduler project',
      'validate' => 'Validate a Submoduler project structure'
    }.freeze

    def self.run(args)
      new(args).run
    end

    def initialize(args)
      @args = args
      @command = nil
      @options = {}
    end

    def run
      if @args.empty? || @args.include?('--help') || @args.include?('-h')
        display_help
        return 0
      end

      @command = @args.shift

      unless COMMANDS.key?(@command)
        puts "Error: Unknown command '#{@command}'"
        display_help
        return 1
      end

      execute_command
    rescue StandardError => e
      puts "Error: #{e.message}"
      1
    end

    private

    def execute_command
      case @command
      when 'init'
        InitCommand.new(@args).execute
      when 'validate'
        ValidateCommand.new(@args).execute
      else
        puts "Error: Command '#{@command}' not implemented"
        1
      end
    end

    def display_help
      puts "Submoduler Master - Manage multiple Submoduler projects"
      puts ""
      puts "Usage: bin/submoduler_master.rb <command> [options]"
      puts ""
      puts "Available commands:"
      COMMANDS.each do |cmd, desc|
        puts "  #{cmd.ljust(12)} #{desc}"
      end
      puts ""
      puts "Run 'bin/submoduler_master.rb <command> --help' for command-specific options"
    end
  end
end
