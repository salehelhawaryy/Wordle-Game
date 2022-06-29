
main:- write('Welcome to Pro-Wordle!'),nl,
      write('----------------------'),nl,nl,
       build_kb,nl,nl,
	   write('Done building the words database...'),nl,nl,
       play.

build_kb:- write('Please enter a word and its category on separate lines:'),nl,
           read(A),
           (
           A==done;
           read(X),
           assert(word(A,X)),
           build_kb).
           
          
	
 is_category(A):-word(_,A).
 

 
categories(L):- setof(C,A^word(A,C),L).
       
        
available_length(L,Cat):-word(X,Cat), string_length(X,L).
 
 pick_word(W,X,C):- available_length(X,C),!,word(W,C),string_length(W,X).
 
 
 correct_letters([],_,[]).
 correct_letters(L1,L2,CL):-
                    L1=[H|T],
                    member(H,L2),
                    delete(L2,H,L5),
                    CL=[H|L3],
                    correct_letters(T,L5,L3).
                    
                    
 
 correct_letters(L1,L2,CL):-
                    L1=[H|T],
                    \+member(H,L2),
                    correct_letters(T,L2,CL). 
                    
                    
correct_positions(L,L2,CP):-
        cph(L,L2,CP,[]).

cph([],[_|_],Acc,Acc).
cph([_|_],[],Acc,Acc). 
cph([],[],Acc,Acc).

cph([H|T],[H1|T1],CP,Acc):-
                H=H1,
                append(Acc,[H],AccN),
                cph(T,T1,CP,AccN).
                
cph([H|T],[H1|T1],CP,Acc):-
                H\=H1,
                cph(T,T1,CP,Acc).
  
initializegame1:-
        write('Choose a category: '),nl,
        read(A),
        (\+is_category(A),nl,write('This category does not exist.'),nl,initializegame1;initializegame2(A)).


initializegame2(A):-
         write('Choose a length: '),nl,
        read(L),
        ((\+available_length(L,A),nl,write('No words with this length in this category.'),nl,initializegame2(A));nl,write('Game started. You have '),L1 is L+1, write(L1),write( ' guesses'),nl,nl,pick_word(Q,L,A),play2(L,L1,A,Q)).

 play:-
  write('The available categories are: '),
         categories(L),
        write(L),nl,
        initializegame1.
        
play2(L,N,C,W):-
        write('Enter a word composed of '),
        write(L),
        write(' letters'),nl,
        read(A),
        (A=W,write('You Won!');((string_length(A,N2),N2\=L),nl,write('Word is not composed of '),write(L) ,write(' letters. Try again.'),nl,write('->Remaining guesses are '),write(N),nl,nl,play2(L,N,C,W)); \+word(A,_),nl,write('Invalid Word '),nl,write('->Remaining Guesses '),write(N),nl,play2(L,N,C,W);(N=1,write('You Lost'));
         string_chars(A,L1),
         string_chars(W,L2),
        correct_letters(L1,L2,L3),
        write('Correct letters are: '),
        write(L3),nl,
        correct_positions(L1,L2,L4),
        write('Correct letters in correct positions are: '),
        write(L4),nl,nl,
        N1 is N-1,write('-> Remaining guesses are '),write(N1),nl,nl,play2(L,N1,C,W)).
        
        
        
        
        
        
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 