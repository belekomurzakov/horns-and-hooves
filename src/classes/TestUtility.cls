@IsTest
public with sharing class TestUtility {
    @IsTest
    static void test() {
    }

    public static User createUser(Id profileId, String username) {
        return new User(
                FirstName = 'David',
                LastName = 'Benioff',
                Username = username,
                Email = 'david.benioff@apex.com',
                Alias = 'mb',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                ProfileId = profileId,
                LanguageLocaleKey = 'en_US'
        );
    }

    public static Account selectAccountByName(String name) {
        return [SELECT Id FROM Account WHERE Name = :name];
    }

    public static Sales_Team__c selectSalesTeamByNotificationType(String notificationType) {
        return [
                SELECT Id, Notification_Type__c
                FROM Sales_Team__c
                WHERE Notification_Type__c = :notificationType
        ];
    }
}