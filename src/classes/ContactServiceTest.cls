@IsTest
private class ContactServiceTest {

    static final String PRIMARY = 'Primary';

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
                    TestUtility.createUser(standardProfileId, 'david.benioff' + i + '@apex.com')
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
            } else if (i > 12 && i <= 24) {
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
        List<Contact> contactsToInsert = new List<Contact>();
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.INSERTING_NEW_RECORD
        ]?.Id;

        for (Integer i = 0; i <= 3; i++) {
            contactsToInsert.add(
                    new Contact(
                            FirstName = 'Linus',
                            LastName = 'Torvalds',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        //when
        Test.startTest();
        insert contactsToInsert;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnOwnerUpdate() {
        //given
        List<Contact> contacts = new List<Contact>();
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.UPDATING_OWNER_FIELD
        ]?.Id;

        for (Integer i = 0; i <= 3; i++) {
            contacts.add(
                    new Contact(
                            FirstName = 'Linus',
                            LastName = 'Torvalds',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert contacts;

        User newOwner = [SELECT Id FROM User LIMIT 1];

        for (Contact contact : contacts) {
            contact.OwnerId = newOwner.Id;
        }
        //when
        Test.startTest();
        update contacts;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnStatusUpdate() {
        //given
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.UPDATING_STATUS_FIELD
        ]?.Id;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i <= 3; i++) {
            contacts.add(
                    new Contact(
                            FirstName = 'Linus',
                            LastName = 'Torvalds',
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert contacts;

        for (Contact contact : contacts) {
            contact.Status__c = PRIMARY;
        }
        //when
        Test.startTest();
        update contacts;
        Test.stopTest();
    }
}