#include "ruby/ruby.h"

RUBY_EXTERN VALUE rb_proc_isolate;

void
Init_proc_isolation(void)
{
  rb_define_method(rb_cProc, "isolate", rb_proc_isolate, 0);
}
