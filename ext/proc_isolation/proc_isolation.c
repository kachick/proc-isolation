#include "ruby/ruby.h"

VALUE rb_proc_isolate(VALUE);
VALUE rb_proc_isolate_bang(VALUE);

void
Init_proc_isolation(void)
{
  rb_define_method(rb_cProc, "isolate", rb_proc_isolate, 0);
  rb_define_method(rb_cProc, "isolate!", rb_proc_isolate_bang, 0);
}
