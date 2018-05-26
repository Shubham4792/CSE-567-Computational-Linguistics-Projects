:- ['unigram_spandey4.pl','bigram_spandey4.pl'].

calc_prob(ListWords,Prob):- calc_prob(ListWords,0,Prob).

calc_prob([_],N,N).
calc_prob([W1,W2|L],T,N):- bigram(X,W1,W2),Y is X+1, unigram(Z, W1), W is Z + 14783, M is log10(Y/W)+T, calc_prob([W2|L],M,N),!.
calc_prob([W1,W2|L],T,N):- Y is 1, unigram(Z, W1), W is Z + 14783, M is log10(Y/W)+T, calc_prob([W2|L],M,N),!.
calc_prob([W1,W2|L],T,N):- Y is 1, W is 14783, M is log10(Y/W)+T, calc_prob([W2|L],M,N),!.
