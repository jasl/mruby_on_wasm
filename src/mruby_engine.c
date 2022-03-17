#include "mruby_engine.h"

mruby_engine_state* me_init() {
    mruby_engine_state* state = malloc(sizeof(mruby_engine_state));
    state->mrb_state = mrb_open();

    return state;
}

