# coding: us-ascii
# frozen_string_literal: true

# Copyright (C) 2021 Kenichi Kamiya

require 'warning'

require_relative 'isolation/version'
require_relative '../proc_isolation'

Warning.ignore(/lambda without a literal block is deprecated/, __FILE__)

class Proc
  module Isolation
    module ProcPrepender
      # `...` can't be used... :<
      def initialize(*args, isolate: false, **kw_args, &block)
        ret = super(*args, **kw_args, &block)
        isolate() if isolate
        ret
      end
    end

    module KernelPrepender
      module_function

      def proc(*args, isolate: false, **kw_args, &block)
        ret = super(*args, **kw_args, &block)
        ret.isolate if isolate
        ret
      end

      def lambda(*args, isolate: false, **kw_args, &block)
        ret = super(*args, **kw_args, &block)
        ret.isolate if isolate
        ret
      end
    end
  end

  prepend Isolation::ProcPrepender
end

module Kernel
  prepend Proc::Isolation::KernelPrepender
end
