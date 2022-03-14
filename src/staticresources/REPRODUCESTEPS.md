## Inserting new record
### Account:
```Apex
List<Account> accounts = new List<Account>();
for (Integer i = 0; i < 10; i++) {
    accounts.add(
            new Account(
                    Name = 'test',
                    Industry = 'Biotechnology',
                    Type = 'Customer - Channel',
                    Sales_Team__c = 'a007Q00000511KLQAY' // Name: Attractive heroes, Type: Inserting new record
            )
    );
}

insert accounts;
```
### Contact:
```Apex
List<Contact> contacts = new List<Contact>();
for (Integer i = 0; i < 10; i++) {
    contacts.add(
            new Contact(
                    FirstName = 'David',
                    LastName = 'Benioff',
                    Department = 'Internal Operations',
                    Email = 'david.benioff' + i + '@apex.com',
                    Sales_Team__c = 'a007Q00000511KLQAY' //Attractive heroes
            )
    );
}

insert contacts;
```
### Opportunity:
```Apex
List<Opportunity> opportunities = new List<Opportunity>();
for (Integer i = 0; i < 10; i++) {
    opportunities.add(
            new Opportunity(
                    Name = 'New Opportunity',
                    StageName = 'New',
                    CloseDate = System.today(),
                    Sales_Team__c = 'a007Q00000511KLQAY' //Attractive heroes
            )
    );
}

insert opportunities;
```
### Contract:
```Apex
Account account = new Account(Name = 'test');
insert account;

List<Contract> contracts = new List<Contract>();
for (Integer i = 0; i < 10; i++) {
    contracts.add(
            new Contract(
                    Name = 'New Contract',
                    Status = 'Draft',
                    AccountId = account.Id,
                    Sales_Team__c = 'a007Q00000511KLQAY' //Attractive heroes
            )
    );
}

insert contracts;
```
## Updating Owner field
### Account:
```Apex
List<Account> accounts = new List<Account>();
for (Integer i = 0; i < 10; i++) {
    accounts.add(
            new Account(
                    Name = 'test',
                    Sales_Team__c = 'a007Q00000511KBQAY' //Name: Sales Power, Type: Updating Owner field
            )
    );
}

insert accounts;

for (Account a : accounts) {
    a.OwnerId = '0057Q0000035PntQAE'; //Name: John Lennon
}

update accounts;
```
### Contact:
```Apex
List<Contact> contacts = new List<Contact>();
for (Integer i = 0; i < 10; i++) {
    contacts.add(
            new Contact(
                    FirstName = 'Jack',
                    LastName = 'Benioff',
                    Department = 'Internal Operations',
                    Email = 'jack.benioff' + i + '@apex.com',
                    Sales_Team__c = 'a007Q00000511KBQAY' //Name: Sales Power, Type: Updating Owner field
            )
    );
}

insert contacts;

for (Contact c : contacts) {
    c.OwnerId = '0057Q0000035PntQAE'; //Name: John Lennon
}

update contacts;
```
### Opportunity:
```Apex
List<Opportunity> opportunities = new List<Opportunity>();
for (Integer i = 0; i < 10; i++) {
    opportunities.add(
            new Opportunity(
                    Name = 'New Opportunity',
                    StageName = 'New',
                    CloseDate = System.today(),
                    Sales_Team__c = 'a007Q00000511KBQAY' //Name: Sales Power, Type: Updating Owner field
            )
    );
}

insert opportunities;

for (Opportunity o : opportunities) {
    o.OwnerId = '0057Q0000035PntQAE'; //Name: John Lennon
}

update opportunities;
```
### Contract:
```Apex
Account account = new Account(Name = 'test');
insert account;

List<Contract> contracts = new List<Contract>();
for (Integer i = 0; i < 10; i++) {
    contracts.add(
            new Contract(
                    Name = 'New Contract',
                    Status = 'Draft',
                    AccountId = account.Id,
                    Sales_Team__c = 'a007Q00000511KBQAY' //Name: Sales Power, Type: Updating Owner field
            )
    );
}

insert contracts;

for (Contract c : contracts) {
    c.OwnerId = '0057Q0000035PntQAE'; //Name: John Lennon
}

update contracts;
```
## Updating Status field
### Account:
```Apex
List<Account> accounts = new List<Account>();
for (Integer i = 0; i < 10; i++) {
    accounts.add(
            new Account(
                    Name = 'test',
                    Sales_Team__c = 'a007Q00000511KGQAY' //Name: Sales Lovers, Type: Updating Status field
            )
    );
}

insert accounts;

for (Account a : accounts) {
    a.Status__c = 'Current Customer';
}

update accounts;
```
### Contact:
```Apex
List<Contact> contacts = new List<Contact>();
for (Integer i = 0; i < 10; i++) {
    contacts.add(
            new Contact(
                    FirstName = 'Carl',
                    LastName = 'Benioff',
                    Department = 'Internal Operations',
                    Email = 'carl.benioff' + i + '@apex.com',
                    Sales_Team__c = 'a007Q00000511KGQAY' //Name: Sales Lovers, Type: Updating Status field
            )
    );
}

insert contacts;

for (Contact c : contacts) {
    c.Status__c = 'Primary';
}

update contacts;
```
### Opportunity:
```Apex
List<Opportunity> opportunities = new List<Opportunity>();
for (Integer i = 0; i < 10; i++) {
    opportunities.add(
            new Opportunity(
                    Name = 'New Opportunity',
                    StageName = 'New',
                    CloseDate = System.today(),
                    Sales_Team__c = 'a007Q00000511KGQAY' //Name: Sales Lovers, Type: Updating Status field
            )
    );
}

insert opportunities;

for (Opportunity o : opportunities) {
    o.StageName = 'Prospect';
}

update opportunities;
```
### Contract:
```Apex
Account account = new Account(Name = 'test');
insert account;

List<Contract> contracts = new List<Contract>();
for (Integer i = 0; i < 10; i++) {
    contracts.add(
            new Contract(
                    Name = 'New Contract',
                    Status = 'Draft',
                    AccountId = account.Id,
                    Sales_Team__c = 'a007Q00000511KGQAY' //Name: Sales Lovers, Type: Updating Status field
            )
    );
}

insert contracts;

for (Contract c : contracts) {
    c.Status = 'In Approval Process';
}

update contracts;
```
