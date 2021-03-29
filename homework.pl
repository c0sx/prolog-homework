surname(aleksandrov).
surname(ivanov).
phone(`+79101234567`).
phone(`+79102345678`).
phone(`+79998887733`).
street(street1).
street(street2).
street(street3).
street(street4).
street(street5).
bankname(unitbank).
bankname(otherbank).

phonebook([
  record(aleksandrov, `+79101234567`, address(moscow, street1, house1, flat1)), 
  record(ivanov, `+79102345678`, address(moscow, street2, house2, flat2)),
  record(aleksandrov, `+79998887733`, address(piterburg, street3, house3, flat3))
]).

cars([
  car(aleksandrov, honda, black, 1000),
  car(ivanov, mazda, silver, 5000),
  car(aleksandrov, mitsubishi, red, 3000)
]).

banks([
  bank(unitbank, address(moscow, street4, house4, flat4)),
  bank(otherbank, address(piterburg, street5, house5, flat5))
]).

accounts([
  account(aleksandrov, unitbank, 10001, 1500),
  account(aleksandrov, otherbank, 3000, 5000),
  account(ivanov, otherbank, 10002, 2000)
]).

% a) По № телефона найти: Фамилию, Марку автомобиля, Стоимость автомобиля (может быть несколько);
find_a(Phone, X) :-
    Record = record(Surname, Phone, _),
    X = car(Surname, _, _, _),
    surname(Surname), phone(Phone),
    phonebook(Phones), cars(Cars),
    member(Record, Phones), member(X, Cars).

% в) Используя сформированное в пункте а) правило, по № телефона найти: только Марку автомобиля (автомобилей может быть несколько);
find_b(Phone, X) :-
    Car = car(_, X, _, _),
    find_a(Phone, Car).

% с) Используя простой, не составной вопрос: 
% по Фамилии (уникальна в городе, но в разных городах есть однофамильцы) и Городу проживания 
% найти: Улицу проживания, Банки, в которых есть вклады и №телефона.
find_c(Surname, City, X) :- 
    X = item(Street, BankName, Phone),
    street(Street), bankname(BankName), phone(Phone),
    Address = address(City, Street, _, _),
    BankAddress = address(City, _, _, _),
    Bank = bank(BankName, BankAddress),
    Account = account(Surname, BankName, _, _),
    Record = record(Surname, Phone, Address),
   	phonebook(Phones),
    accounts(Accounts),
    banks(Banks),
    member(Record, Phones), member(Account, Accounts), member(Bank, Banks).
