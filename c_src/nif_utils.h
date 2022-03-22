#ifndef C_SRC_NIF_UTILS_H_
#define C_SRC_NIF_UTILS_H_

#include <string>
#include <stdint.h>

#include "erl_nif.h"

ERL_NIF_TERM make_atom(ErlNifEnv* env, const char* name);
ERL_NIF_TERM make_error(ErlNifEnv* env, const char* error);
ERL_NIF_TERM make_error(ErlNifEnv* env, ERL_NIF_TERM term);
ERL_NIF_TERM make_bad_options(ErlNifEnv* env, ERL_NIF_TERM term);
ERL_NIF_TERM make_badarg(ErlNifEnv* env);
ERL_NIF_TERM make_binary(ErlNifEnv* env, const uint8_t* buff, size_t length);
ERL_NIF_TERM make_binary(ErlNifEnv* env, const std::string& string);
ERL_NIF_TERM make_ok_result(ErlNifEnv* env, ERL_NIF_TERM term);

void consume_timeslice(ErlNifEnv *env, size_t bytes);

bool get_binary(ErlNifEnv* env, ERL_NIF_TERM term, ErlNifBinary* bin);
bool get_string(ErlNifEnv *env, ERL_NIF_TERM term, std::string* var);
bool get_boolean(ERL_NIF_TERM term, bool* val);

#endif  // C_SRC_NIF_UTILS_H_
