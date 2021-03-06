@IsTest
private class SalesTeamUserServiceTest {

    @TestSetup
    static void setup() {
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

        insert new User(
                FirstName = 'Marc',
                LastName = 'Benioff',
                Username = 'marc.benioff@apex.com',
                Email = 'marc.benioff@apex.com',
                Alias = 'mb',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User']?.Id,
                LanguageLocaleKey = 'en_US'
        );
    }

    @IsTest
    static void setSalesTeamTest() {
        //given
        Sales_Team_User__c salesTeamUser = new Sales_Team_User__c(
                First_Name__c = 'test',
                Last_Name__c = 'tester',
                Interested_Notification_Types__c = NotificationHelper.INSERTING_NEW_RECORD
        );
        //when
        Test.startTest();
        SalesTeamUserService.setSalesTeam(new List<Sales_Team_User__c>{ salesTeamUser });
        Test.stopTest();
        //then
        System.assertEquals(
                [SELECT Id FROM Sales_Team__c WHERE Notification_Type__c = :NotificationHelper.INSERTING_NEW_RECORD]?.Id,
                salesTeamUser.Sales_Team__c,
                'Sales Team User should have related Sales Team based on his Interested Notification Type'
        );
    }


    @IsTest
    static void setSalesTeamUserIdTest() {
        //given
        Sales_Team_User__c salesTeamUser = new Sales_Team_User__c(
                First_Name__c = 'test',
                Last_Name__c = 'tester',
                Username__c = 'marc.benioff@apex.com',
                Interested_Notification_Types__c = NotificationHelper.INSERTING_NEW_RECORD
        );
        //when
        Test.startTest();
        SalesTeamUserService.setSalesTeamUserId(new List<Sales_Team_User__c>{
                salesTeamUser
        });
        Test.stopTest();
        //then
        User user = [SELECT Id, Username, FirstName, LastName FROM User WHERE Username = :salesTeamUser.Username__c];

        System.assertEquals(user.Id, salesTeamUser.Id__c);
        System.assertEquals(user.Username, salesTeamUser.Username__c);
        System.assertEquals(user.FirstName, salesTeamUser.First_Name__c);
        System.assertEquals(user.LastName, salesTeamUser.Last_Name__c);
    }

    @IsTest
    static void setSalesTeamOnUpdateTest() {
        //given
        Sales_Team_User__c salesTeamUser = new Sales_Team_User__c(
                First_Name__c = 'test',
                Last_Name__c = 'tester',
                Username__c = 'marc.benioff@apex.com',
                Interested_Notification_Types__c = NotificationHelper.INSERTING_NEW_RECORD
        );
        insert salesTeamUser;
        salesTeamUser.Interested_Notification_Types__c = NotificationHelper.UPDATING_STATUS_FIELD;
        //when
        Test.startTest();
        update salesTeamUser;
        Test.stopTest();
        //then
        System.assertEquals(
                TestUtility.selectSalesTeamByNotificationType(NotificationHelper.UPDATING_STATUS_FIELD)?.Id,
                [SELECT Id, Sales_Team__c FROM Sales_Team_User__c WHERE Username__c = 'marc.benioff@apex.com']?.Sales_Team__c,
                'Sales Team User should have associated to Sales Team based on interested notification type'
        );
    }
}