PROFIX=./

REBAR=rebar3

all:
	@$(REBAR) compile
	@erl -pa _build/default/lib/*/ebin -s sblog