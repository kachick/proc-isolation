# coding: us-ascii
# frozen_string_literal: true

# Copyright (C) 2021 Kenichi Kamiya

unless ->{}.respond_to?(:isolate)
  require_relative 'isolation.so'
end
