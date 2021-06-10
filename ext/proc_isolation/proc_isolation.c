// #include "ruby.h"
#include "ruby/ruby.h"

VALUE rb_proc_isolate(VALUE);
// typedef struct rb_proc_t;

// #define GetCoreDataFromValue(obj, type, ptr) ((ptr) = CoreDataFromValue((obj), type))

// #define GetProcPtr(obj, ptr) \
//   GetCoreDataFromValue((obj), rb_proc_t, (ptr))

// static typedef struct {
//     // const struct rb_block VALUE;
//     unsigned int is_from_method: 1;	/* bool */
//     unsigned int is_lambda: 1;		/* bool */
//     unsigned int is_isolated: 1;        /* bool */
// } rb_proc_t;


// VALUE
// rb_proc_lambda_p(VALUE procval)
// {
//     rb_proc_t *proc;
//     GetProcPtr(procval, proc);

//     return proc->is_lambda ? Qtrue : Qfalse;
// }

// VALUE
// rb_proc_isolated_p(VALUE procval)
// {
//     rb_proc_t *proc;
//     GetProcPtr(procval, proc);

//     return proc->is_isolated ? Qtrue : Qfalse;
// }


        // proc->is_isolated = TRUE;

void
Init_proc_isolation(void)
{
  rb_define_method(rb_cProc, "isolate", rb_proc_isolate, 0);
  // rb_define_method(rb_cProc, "isolated?", rb_proc_isolated_p, 0);
}
