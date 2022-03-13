@IsTest
private class AccountServiceTest {

    @TestSetup
    static void setup() {
        Id standardProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User']?.Id;

        List<Sales_Team__c> salesTeamToInsert = new List<Sales_Team__c>();
        for (String type : NotificationHelper.notificationTypes) {
            salesTeamToInsert.add(
                    new Sales_Team__c(
                            Name = 'test',
                            Notification_Type__c = type
                    )
            );
        }
        insert salesTeamToInsert;

        List<User> usersToInsert = new List<User>();
        for (Integer i = 0; i <= 12; i++) {
            usersToInsert.add(
                    new User(
                            FirstName = 'David',
                            LastName = 'Benioff',
                            Username = 'david.benioff' + i + '@apex.com',
                            Email = 'david.benioff@apex.com',
                            Alias = 'mb',
                            TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            ProfileId = standardProfileId,
                            LanguageLocaleKey = 'en_US'
                    )
            );
        }
        insert usersToInsert;

        List<Sales_Team_User__c> salesTeamUsersToInsert = new List<Sales_Team_User__c>();
        for (Integer i = 0; i <= 36; i++) {
            if (i <= 12) {
                salesTeamUsersToInsert.add(
                        new Sales_Team_User__c(
                                Username__c = 'david.benioff' + i + '@apex.com',
                                Interested_Notification_Types__c = NotificationHelper.INSERTING_NEW_RECORD
                        )
                );
            } else if(i > 12 && i <= 24) {
                salesTeamUsersToInsert.add(
                        new Sales_Team_User__c(
                                Username__c = 'david.benioff' + i + '@apex.com',
                                Interested_Notification_Types__c = NotificationHelper.UPDATING_STATUS_FIELD
                        )
                );
            } else {
                salesTeamUsersToInsert.add(
                        new Sales_Team_User__c(
                                Username__c = 'david.benioff' + i + '@apex.com',
                                Interested_Notification_Types__c = NotificationHelper.UPDATING_OWNER_FIELD
                        )
                );
            }
        }
        insert salesTeamUsersToInsert;
    }

    @IsTest
    static void notifyOnInsertTest() {
        //given
        List<Account> accountsToInsert = new List<Account>();
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.INSERTING_NEW_RECORD
        ]?.Id;

        for (Integer i = 0; i <= 3; i++) {
            accountsToInsert.add(
                    new Account(
                            Name = 'test',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        //when
        Test.startTest();
        insert accountsToInsert;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnOwnerUpdate() {
        //given
        List<Account> accounts = new List<Account>();
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.UPDATING_OWNER_FIELD
        ]?.Id;

        for (Integer i = 0; i <= 3; i++) {
            accounts.add(
                    new Account(
                            Name = 'test',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert accounts;

        User newOwner = [SELECT Id FROM User LIMIT 1];

        for (Account account : accounts) {
            account.OwnerId = newOwner.Id;
        }
        //when
        Test.startTest();
        update accounts;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnStatusUpdate() {
        //given
        String CURRENT_CUSTOMER = 'Current Customer';

        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.UPDATING_STATUS_FIELD
        ]?.Id;

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i <= 3; i++) {
            accounts.add(
                    new Account(
                            Name = 'test',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert accounts;

        for (Account account : accounts) {
            account.Status__c = CURRENT_CUSTOMER;
        }
        //when
        Test.startTest();
        update accounts;
        Test.stopTest();
    }
}