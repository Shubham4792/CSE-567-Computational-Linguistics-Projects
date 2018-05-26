:- ['sigmas.pl'].
:- ['taus.pl'].
:- ['tagCount.pl'].

% Compute all possible "solution(Probability,TagList)" for a given WordList
% ===================================================
viterbi_all(WordList,solution(P,Sequence)) :-
          sequences(WordList,[solution(1,['.'])],PSs),
          member(solution(P,Sequence1),PSs),
          reverse(Sequence1,['.'|Sequence]).
		  
% Base case: no more words to parse.
% ===================================================
sequences([],PSs,PSs).

% Recursive case: find max (of all taggings for Word * all transitions)
% ===================================================
sequences([Word|Words],PSs0,PSs) :-
     findall(PS2,
                   (tau(Word,T2,Count1), tagcount(T2,TC1), Prob1 is Count1/TC1,
                    findall(solution(Prob,[T2,T1|Ts]),
                                  (member(solution(Prob3,[T1|Ts]),PSs0),
                                     sigma(T1,T2,Count2), tagcount(T1,TC2), Prob2 is Count2/TC2,
                                     Prob is Prob1*Prob2*Prob3),
                               PSs),
                    max_key(PSs,PS2)),
                PSs1),
sequences(Words,PSs1,PSs).

% Find tagging with maximum Probability (tail-recursive, with accumulator) 
% ===================================================
max_key(PList,Max):-  max_key(PList,solution(0,[]),Max).
max_key([],X,X).
max_key([solution(P,_)|Rest],solution(N,L),M):- N > P, max_key(Rest,solution(N,L),M).
max_key([solution(P,L)|Rest],solution(N,_),M):- P > N, max_key(Rest,solution(P,L),M).
