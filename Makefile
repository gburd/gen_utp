TARGET=		utp
DIALYZER= 	dialyzer
REBAR= 		rebar

.PHONY: plt analyze all deps compile get-deps clean

all: deps compile

deps: get-deps

get-deps:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

plt: compile
	$(DIALYZER) --build_plt --output_plt .$(TARGET).plt \
		-pa deps/*/ebin ebin \
		--apps kernel stdlib

analyze: compile
	$(DIALYZER) --plt .$(TARGET).plt \
		-pa deps/*/ebin ebin

repl:
	erl -pz deps/*/ebin -pa ebin
