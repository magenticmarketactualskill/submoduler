# frozen_string_literal: true

require_relative '../test_helper'
require 'submoduler_master/cli'

module SubmodulerMaster
  class TestCLIIntegration < Minitest::Test
    def setup
      @tmpdir = Dir.mktmpdir
      @original_dir = Dir.pwd
      Dir.chdir(@tmpdir)
      # Create .git directory to simulate git repo
      FileUtils.mkdir_p('.git')
    end

    def teardown
      Dir.chdir(@original_dir)
      FileUtils.rm_rf(@tmpdir)
    end

    def test_cli_with_help_flag
      output = capture_io do
        exit_code = SubmodulerMaster::CLI.run(['--help'])
        assert_equal 0, exit_code
      end

      assert_match(/Submoduler Master/, output[0])
      assert_match(/Usage:/, output[0])
      assert_match(/Available commands:/, output[0])
    end

    def test_cli_with_no_arguments
      output = capture_io do
        exit_code = SubmodulerMaster::CLI.run([])
        assert_equal 0, exit_code
      end

      assert_match(/Usage:/, output[0])
    end

    def test_cli_with_unknown_command
      output = capture_io do
        exit_code = SubmodulerMaster::CLI.run(['unknown'])
        assert_equal 1, exit_code
      end

      assert_match(/Unknown command/, output[0])
    end

    def test_cli_init_command
      output = capture_io do
        exit_code = SubmodulerMaster::CLI.run(['init', '--project', 'test_project'])
        assert_equal 0, exit_code
      end

      # Should have some output about initialization
      assert_match(/Initializing Submoduler project/, output[0])
    end

    def test_cli_validate_command
      # First create a project to validate
      SubmodulerMaster::CLI.run(['init', '--project', 'test_project'])
      
      output = capture_io do
        exit_code = SubmodulerMaster::CLI.run(['validate', '--project', 'test_project'])
        assert_equal 0, exit_code
      end

      # Should have some output about validation
      assert_match(/Validating Submoduler project/, output[0])
    end
  end
end
