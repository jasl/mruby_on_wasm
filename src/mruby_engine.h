#ifndef MRUBY_ENGINE_H
#define MRUBY_ENGINE_H

#include <stdlib.h>
#include <mruby.h>

typedef struct mruby_engine_state {
    struct mrb_state *mrb_state;
} mruby_engine_state;

#ifdef __cplusplus
extern "C" {
    mruby_engine_state* me_init();
}
#endif

#endif
