% Define the initial balances of the accounts
account(account1, 500).
account(account2, 300).

% Predicate to create an account
create_account(AccountId, InitialBalance) :-
    format('Created account ~w with initial balance: ~w~n', [AccountId, InitialBalance]).

% Predicate to deposit money into an account
deposit(AccountId, Amount) :-
    account(AccountId, OldBalance),
    NewBalance is OldBalance + Amount,
    format('Deposited ~w into ~w. New balance: ~w~n', [Amount, AccountId, NewBalance]).

% Predicate to check the balance of an account
check_balance(AccountId) :-
    account(AccountId, Balance),
    format('Balance of ~w: ~w~n', [AccountId, Balance]).

% Predicate to transfer money from one account to another
transfer_money(FromAccount, ToAccount, Amount) :-
    % Check if the FromAccount exists and has enough balance
    check_balance(FromAccount, OldBalance),
    (   OldBalance >= Amount
    ->  % Deduct the amount from the FromAccount
        NewBalance is OldBalance - Amount,
        % Add the amount to the ToAccount
        check_balance(ToAccount, OldBalance2),
        NewBalance2 is OldBalance2 + Amount,
        % Print the new balances
        format('New balance of ~w: ~w~n', [FromAccount, NewBalance]),
        format('New balance of ~w: ~w~n', [ToAccount, NewBalance2])
    ;   write('Error: Insufficient balance.'), nl, fail
    ).
