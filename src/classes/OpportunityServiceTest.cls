@IsTest
private class OpportunityServiceTest {

    @TestSetup
    static void setup() {
        List<User> usersToInsert = new List<User>();
        List<Sales_Team_User__c> salesTeamUsers = new List<Sales_Team_User__c>();
        Id standardProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User']?.Id;

        insert new Sales_Team__c(
                Name = 'test',
                Notification_Type__c = NotificationHelper.INSERTING_NEW_RECORD
        );

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

        for (Integer i = 0; i <= 12; i++) {
            salesTeamUsers.add(
                    new Sales_Team_User__c(
                            Username__c = 'david.benioff' + i + '@apex.com',
                            Interested_Notification_Types__c = NotificationHelper.INSERTING_NEW_RECORD
                    )
            );
        }
        insert salesTeamUsers;
    }

    @IsTest
    static void notifyOnInsertTest() {
        //given
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        Id salesTeamId = [
                SELECT Id
                FROM Sales_Team__c
                WHERE Notification_Type__c = :NotificationHelper.INSERTING_NEW_RECORD
        ]?.Id;

        for (Integer i = 0; i <= 3; i++) {
            opportunitiesToInsert.add(
                    new Opportunity(
                            Name = 'testOpp',
                            StageName = 'New',
                            CloseDate = System.today(),
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        //when
        Test.startTest();
        insert opportunitiesToInsert;
        Test.stopTest();
    }
}