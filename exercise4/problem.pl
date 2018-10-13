get_problem(BaseUrlProvider, Id, Prolog_Json_Types) :-
    call(BaseUrlProvider, BaseUrl),
    atom_concat(BaseUrl, Id, Url),
    http_get(Url, Reply, []),
    json_to_prolog(Reply, Prolog_Json_Types).

send_solution(UrlProvider, Json_Prolog_Types) :-
    prolog_to_json(Json_Prolog_Types, Json),
    call(UrlProvider, Url),
    http_post(Url, json(Json), _, []).
