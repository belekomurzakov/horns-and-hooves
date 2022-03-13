@IsTest
private class OpportunityServiceTest {

    static final String QUALIFICATION = 'Qualification';

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
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.INSERTING_NEW_RECORD)?.Id;

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

    @IsTest
    static void notifyOnOwnerUpdate() {
        //given
        List<Opportunity> opportunities = new List<Opportunity>();

        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.UPDATING_OWNER_FIELD)?.Id;

        for (Integer i = 0; i <= 3; i++) {
            opportunities.add(
                    new Opportunity(
                            Name = 'testOpp',
                            StageName = 'New',
                            CloseDate = System.today(),
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert opportunities;

        User newOwner = [SELECT Id FROM User LIMIT 1];

        for (Opportunity opportunity : opportunities) {
            opportunity.OwnerId = newOwner.Id;
        }
        //when
        Test.startTest();
        update opportunities;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnStatusUpdate() {
        //given
        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.UPDATING_STATUS_FIELD)?.Id;

        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 0; i <= 3; i++) {
            opportunities.add(
                    new Opportunity(
                            Name = 'testOpp',
                            StageName = 'New',
                            CloseDate = System.today(),
                            Sales_Team__c = salesTeamId
                    )
            );
        }
        insert opportunities;

        for (Opportunity opportunity : opportunities) {
            opportunity.StageName = QUALIFICATION;
        }
        //when
        Test.startTest();
        update opportunities;
        Test.stopTest();
    }
}