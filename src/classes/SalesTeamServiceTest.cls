@IsTest
private class SalesTeamServiceTest {

    @TestSetup
    static void setup() {
        Sales_Team__c salesTeam = new Sales_Team__c(
                Name = 'test',
                Notification_Type__c = NotificationHelper.INSERTING_NEW_RECORD
        );

        insert salesTeam;
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
        SalesTeamUserService.setSalesTeam(new List<Sales_Team_User__c> {salesTeamUser});
        Test.stopTest();
        //then
        System.assertEquals(
                [SELECT Id FROM Sales_Team__c WHERE Notification_Type__c = :NotificationHelper.INSERTING_NEW_RECORD]?.Id,
                salesTeamUser.Sales_Team__c,
                'Sales Team User should have related Sales Team based on his Interested Notification Type'
        );
    }
}