%%%-------------------------------------------------------------------
%% @doc sblog public API
%% @end
%%%-------------------------------------------------------------------

-module(sblog_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", cowboy_static, {priv_file, sblog, "index.html"}},
			{"/base", sblog_base_handler, []},
			{"/static/[...]", cowboy_static, {priv_dir, sblog, "static"}}
		]}
	]),
	
	{ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
		{env, [{dispatch, Dispatch}]}
	]),

	sblog_sup:start_link().    

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
