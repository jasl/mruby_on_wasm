#ifndef MRUBY_ENGINE_H_
#define MRUBY_ENGINE_H_

#include <stdlib.h>
#include <mruby.h>
#include <mruby/irep.h>

typedef struct mruby_engine_state {
    struct mrb_state *mrb_state;
} mruby_engine_state;

#ifdef __cplusplus
extern "C" {
    int main(int argc, char *argv[])
    mruby_engine_state* me_open();
    void me_exec(mruby_engine_state* state);
    void me_close(mruby_engine_state* state);
}
#endif

#endif
