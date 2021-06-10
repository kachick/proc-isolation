# coding: utf-8
# frozen_string_literal: true

require_relative '../helper'

class TestProcIsolation < Test::Unit::TestCase
  def test_versioning
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

  def test_proc_isolate!
    prc = proc { 42 }
    assert_instance_of(Proc, prc.isolate!)
    assert_same(prc, prc.isolate!)
    assert do
      !prc.isolate!.lambda?
    end
    assert_equal(42, prc.isolate!.call)

    foo = 42
    prc = proc { foo }

    assert_raise_with_message(ArgumentError, /can not isolate a Proc because it accesses outer variables/) do
      prc.isolate!
    end
    assert_equal(42, prc.call)
  end

  def test_proc_isolate_bang_as_an_unbound_method
    unbound = Proc.instance_method(:isolate!)

    assert_raise_with_message(TypeError, /bind argument must be an instance of Proc/) do
      unbound.bind(Object.new)
    end
  end

  def test_lambda_isolate!
    lmd = -> { 42 }
    assert_instance_of(Proc, lmd.isolate!)
    assert_same(lmd, lmd.isolate!)
    assert do
      lmd.isolate!.lambda?
    end
    assert_equal(42, lmd.isolate!.call)

    foo = 42
    lmd = -> { foo }

    assert_raise_with_message(ArgumentError, /can not isolate a Proc because it accesses outer variables/) do
      lmd.isolate!
    end
    assert_equal(42, lmd.call)
  end

  def test_proc_isolate
    prc = proc { 42 }
    assert_instance_of(Proc, prc.isolate)
    assert_not_same(prc, prc.isolate)
    assert do
      !prc.isolate.lambda?
    end
    assert_equal(42, prc.isolate.call)

    foo = 42
    prc = proc { foo }

    assert_raise_with_message(ArgumentError, /can not isolate a Proc because it accesses outer variables/) do
      prc.isolate
    end
  end

  def test_proc_isolate_as_an_unbound_method
    unbound = Proc.instance_method(:isolate)

    assert_raise_with_message(TypeError, /bind argument must be an instance of Proc/) do
      unbound.bind(Object.new)
    end
  end

  def test_lambda_isolate
    lmd = -> { 42 }
    assert_instance_of(Proc, lmd.isolate)
    assert_not_same(lmd, lmd.isolate)
    omit_if(!lmd.isolate.lambda?) do
      assert do
        lmd.isolate.lambda?
      end
    end
    assert_equal(42, lmd.isolate.call)

    foo = 42
    lmd = -> { foo }

    assert_raise_with_message(ArgumentError, /can not isolate a Proc because it accesses outer variables/) do
      lmd.isolate
    end
  end
end
