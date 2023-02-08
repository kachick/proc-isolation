- _**This repository has been archived**_.
- _**No longer maintained**_.
- _**All versions have been removed from https://rubygems.org to free up valuable namespace for other developers**_.


# proc-isolation

An evil tool, this gem expose hidden feature around [Proc#isolate](https://github.com/ruby/ruby/blob/72a4e1d3bbbdfff71ec2c6b2ddb3b9323193cacd/doc/ractor.md#given-block-isolation) in CRuby.  \
Do not use in your production code, stop to use just only fun in your sandbox. :)

---

[![Build Status](https://github.com/kachick/proc-isolation/actions/workflows/test_behaviors.yml/badge.svg?branch=main)](https://github.com/kachick/proc-isolation/actions/workflows/test.yml?query=branch%3Amain)

## Usage

Require Ruby 3.0 or later


### Overview

```ruby
require 'proc/isolation'

prc = ->{ 42 }
prc.isolate #=> New isolated Proc instance will be returned

prc.isolate! #=> The Proc instance will be isolated

local_variable = 42
-> { local_variable }.isolate #=> can not isolate a Proc because it accesses outer variables (local_variable). (ArgumentError)
```

## Links

* [Repository](https://github.com/kachick/proc-isolation)
* [API documents](https://kachick.github.io/proc-isolation/)
