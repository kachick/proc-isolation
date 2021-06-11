#include "ruby.h"

#if 1
#define CoreDataFromValue(obj, type) (type*)DATA_PTR(obj)
#else
#define CoreDataFromValue(obj, type) (type*)rb_data_object_get(obj)
#endif
#define GetCoreDataFromValue(obj, type, ptr) ((ptr) = CoreDataFromValue((obj), type))


#define GetProcPtr(obj, ptr) \
  GetCoreDataFromValue((obj), rb_proc_t, (ptr))

#ifndef rb_iseq_t
typedef struct rb_iseq_struct rb_iseq_t;
#define rb_iseq_t rb_iseq_t
#endif
struct rb_captured_block {
    VALUE self;
    const VALUE *ep;
    union {
	const rb_iseq_t *iseq;
	const struct vm_ifunc *ifunc;
	VALUE val;
    } code;
};

enum rb_block_handler_type {
    block_handler_type_iseq,
    block_handler_type_ifunc,
    block_handler_type_symbol,
    block_handler_type_proc
};

enum rb_block_type {
    block_type_iseq,
    block_type_ifunc,
    block_type_symbol,
    block_type_proc
};

struct rb_block {
  union {
	struct rb_captured_block captured;
	VALUE symbol;
	VALUE proc;
  } as;
  enum rb_block_type type;
};

typedef struct {
    const struct rb_block block;
    unsigned int is_from_method: 1;	/* bool */
    unsigned int is_lambda: 1;		/* bool */
    unsigned int is_isolated: 1;        /* bool */
} rb_proc_t;


VALUE rb_proc_isolate(VALUE);
VALUE rb_proc_isolate_bang(VALUE);
VALUE rb_proc_isolated_p(VALUE);

VALUE
rb_proc_isolated_p(VALUE procval)
{
    rb_proc_t *proc;
    GetProcPtr(procval, proc);

    return proc->is_isolated ? Qtrue : Qfalse;
}

void
Init_isolation(void)
{
  rb_define_method(rb_cProc, "isolate", rb_proc_isolate, 0);
  rb_define_method(rb_cProc, "isolate!", rb_proc_isolate_bang, 0);
  rb_define_method(rb_cProc, "isolated?", rb_proc_isolated_p, 0);
}
