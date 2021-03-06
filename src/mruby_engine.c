#include "cvector.h"
#include "mruby_engine.h"

const uint8_t hello[] = {
                        0x52,0x49,0x54,0x45,0x30,0x33,0x30,0x30,0x00,0x00,0x00,0x41,0x4d,0x41,0x54,0x5a,
                        0x30,0x30,0x30,0x30,0x49,0x52,0x45,0x50,0x00,0x00,0x00,0x25,0x30,0x33,0x30,0x30,
                        0x00,0x00,0x00,0x19,0x00,0x01,0x00,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x05,
                        0x08,0x01,0x38,0x01,0x69,0x00,0x00,0x00,0x00,0x45,0x4e,0x44,0x00,0x00,0x00,0x00,
                        0x08,
                        };

mruby_engine_state* me_init() {
    mruby_engine_state* state = malloc(sizeof(mruby_engine_state));
    state->mrb_state = mrb_open();

    return state;
}

void me_exec(mruby_engine_state* state) {
    mrb_state* mrb = state->mrb_state;
    mrb_load_irep(mrb, hello);
}

void me_close(mruby_engine_state* state) {
    mrb_state* mrb = state->mrb_state;
    mrb_close(mrb);
    free(state);
}

int main(__attribute__ ((unused)) int argc, __attribute__ ((unused)) char *argv[]) {}
