# coding: utf-8
# frozen_string_literal: true

require_relative 'helper'

class TestProcIsolation < Test::Unit::TestCase
  include Proc::IsolationAssertions

  def setup
    nil
  end

  def test_constant_version
    assert do
      Proc::Isolation::VERSION.instance_of?(String)
    end

    assert do
      Proc::Isolation::VERSION.frozen?
    end

    assert do
      Gem::Version.correct?(Proc::Isolation::VERSION)
    end
  end

  def test_proc_isolate
    assert_nil(-> {}.isolate)
  end

  def teardown
    nil
  end
end
