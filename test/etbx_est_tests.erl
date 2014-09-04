-module(etbx_est_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

est_test_() ->
    [?_assertEqual({est_rec,[{est_part, chunk, <<"!">>},
                             {est_part, property, foo},
                             {est_part, chunk, <<"hi ">>}]},
                   etbx_est:compile(<<"hi {{foo}}!">>)),
     ?_assertEqual({est_rec,[{est_part, chunk, <<"!">>},
                             {est_part, property, foo},
                             {est_part, chunk, <<"hi ">>}]},
                   etbx_est:compile(<<"hi {{'foo'}}!">>)),
     ?_assertEqual({est_rec,[{est_part, chunk, <<"!">>},
                             {est_part, property, <<"foo">>},
                             {est_part, chunk, <<"hi ">>}]},
                   etbx_est:compile(<<"hi {{  <<\"foo\">> }}!">>)),
     ?_assertEqual({est_rec,[{est_part, chunk, <<"!">>},
                             {est_part, property, foo},
                             {est_part, chunk, <<"hi ">>}]},
                   etbx_est:compile(<<"hi {{foo}}!">>)),
     ?_assertEqual({est_rec,[{est_part, property, bar},
                             {est_part, property, foo}]},
                   etbx_est:compile(<<"%'foo'%%bar%">>, "%(.*)%")),
     ?_assertEqual({est_rec,[{est_part, chunk, <<"hi mom!">>}]},
                   etbx_est:compile(<<"hi mom!">>)),
     ?_assertEqual({est_rec,[{est_part, property, baz},
                             {est_part, property, bar},
                             {est_part, chunk, <<"foo">>}]},
                   etbx_est:compile(<<"foo<'bar'><baz>">>, <<"<(.*)>">>)),
     ?_assertEqual([<<"foo">>, "bar", <<"baz">>],
                   etbx_est:render({est_rec,[{est_part, property, baz},
                                             {est_part, property, bar},
                                             {est_part, chunk, <<"foo">>}]},
                                   [{foo, moo},
                                    {bar, "bar"},
                                    {baz, <<"baz">>}]))].