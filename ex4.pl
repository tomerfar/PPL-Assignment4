:- module('ex4',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(a, asimov).
author(h, herbert).
author(m, morris).
author(t, tolkien).

genre(s, science).
genre(l, literature).
genre(sf, science_fiction).
genre(f, fantasy).

book(inside_the_atom, a, s, s(s(s(s(s(zero)))))).
book(asimov_guide_to_shakespeare, a, l, s(s(s(s(zero))))).
book(i_robot, a, sf, s(s(s(zero)))).
book(dune, h, sf, s(s(s(s(s(zero)))))).
book(the_well_at_the_worlds_end, m, f, s(s(s(s(zero))))).
book(the_hobbit, t, f, s(s(s(zero)))).
book(the_lord_of_the_rings, t, f, s(s(s(s(s(s(zero))))))).

% You can add more facts.


% Signature: max_list(Lst, Max)/2
% Purpose: true if Max is the maximum church number in Lst, false if Lst is empty.

% Base case: empty list
max_list([], false).

% Recursive case: compare head with max of tail
max_list([H|T], Max) :-
    max_list(T, TailMax),
    max_num(H, TailMax, Max).

% max_num(A, B, Max): Max is the greater of Church numerals A and B

% Case: if one value is false (list was empty), the other is max
max_num(A, false, A).
max_num(false, B, B).

% Case: both zero
max_num(zero, zero, zero).

% Case: one is zero, one is successor
max_num(s(X), zero, s(X)).
max_num(zero, s(Y), s(Y)).

% Case: both successors — recursively compare inner numbers
max_num(s(X), s(Y), s(Res)) :-
    max_num(X, Y, Res).


% Signature: author_of_genre(GenreName, AuthorName)/2
% Purpose: true if an author by the name AuthorName has written a book belonging to the genre named GenreName.
author_of_genre(GenreName, AuthorName) :-
        book(_, AuthorID, GenreID, _),
        author(AuthorID, AuthorName),
        genre(GenreID, GenreName).


% Signature: longest_book(AuthorName, BookName)/2
% Purpose: true if the longest book that an author by the name AuthorName has written is titled BookName.
longest_book(AuthorName, BookName) :-
    author(AuthorID, AuthorName),
    findall(Length-Name,
            book(Name, AuthorID, _, Length),
            Pairs),
    % Extract all lengths from the [Length-Name] pairs
    findall(L, member(L-_, Pairs), Lengths),
    max_list(Lengths, Max),
    member(Max-BookName, Pairs).

