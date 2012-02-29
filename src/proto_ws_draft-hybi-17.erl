%% ==========================================================================================================
%% MISULTIN - WebSocket - draft hybi 17
%%
%% >-|-|-(°>
%%
%% Copyright (C) 2011, Roberto Ostinelli <roberto@ostinelli.net>.
%% All rights reserved.
%%
%% Code portions from Joe Armstrong have been originally taken under MIT license at the address:
%% <http://armstrongonsoftware.blogspot.com/2009/12/comet-is-dead-long-live-websockets.html>
%%
%% BSD License
%%
%% Redistribution and use in source and binary forms, with or without modification, are permitted provided
%% that the following conditions are met:
%%
%%  * Redistributions of source code must retain the above copyright notice, this list of conditions and the
%%       following disclaimer.
%%  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
%%       the following disclaimer in the documentation and/or other materials provided with the distribution.
%%  * Neither the name of the authors nor the names of its contributors may be used to endorse or promote
%%       products derived from this software without specific prior written permission.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
%% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
%% PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
%% ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
%% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
%% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
%% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.
%% ==========================================================================================================
-module('proto_ws_draft-hybi-17').
-behaviour(proto_ws).
-vsn("0.9-dev").

%% API
-export([handshake/3, handle_data/5, format_send/2]).

-export([required_headers/0]).

%% macros
-define(HYBI_COMMON, 'proto_ws_draft-hybi-10_17').

%% ============================ \/ API ======================================================================
required_headers() ->
    [
     {'Upgrade', "websocket"}, {'Connection', "Upgrade"}, {'Host', ignore},
     {'Sec-Websocket-Key', ignore}, {'Sec-WebSocket-Version', "13"}
    ].

%% ----------------------------------------------------------------------------------------------------------
%% Function: -> iolist() | binary()
%% Description: Callback to build handshake data.
%% ----------------------------------------------------------------------------------------------------------
-spec handshake(Req::#req{}, Headers::http_headers(), {Path::string(), Origin::string(), Host::string()}) -> iolist().
handshake(Req, Headers, {Path, Origin, Host}) ->
    ?HYBI_COMMON:handshake(Req, Headers, {Path, Origin, Host}).

%% ----------------------------------------------------------------------------------------------------------
%% Function: -> {Acc1, websocket_close | {Acc1, websocket_close, DataToSendBeforeClose::binary() | iolist()} | {Acc1, continue, NewState}
%% Description: Callback to handle incomed data.
%% ----------------------------------------------------------------------------------------------------------
-spec handle_data(Data::binary(),
                  State::websocket_state() | term(),
                  {Socket::socket(), SocketMode::socketmode()},
                  Acc::term(),
                  WsCallback::fun()) ->
                         {term(), websocket_close} | {term(), websocket_close, binary()} | {term(), continue, websocket_state()}.
handle_data(Data, St, Tuple, Acc, WsCallback) ->
    ?HYBI_COMMON:handle_data(Data, St, Tuple, Acc, WsCallback).

%% ----------------------------------------------------------------------------------------------------------
%% Function: -> binary() | iolist()
%% Description: Callback to format data before it is sent into the socket.
%% ----------------------------------------------------------------------------------------------------------
-spec format_send(Data::iolist(), State::term()) -> binary().
format_send(Data, State) ->
    ?HYBI_COMMON:format_send(Data, State).

%% ============================ /\ API ======================================================================


%% ============================ \/ INTERNAL FUNCTIONS =======================================================

%% ============================ /\ INTERNAL FUNCTIONS =======================================================
