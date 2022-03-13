@IsTest
public with sharing class TestUtility {

    @IsTest
    static void test() {}

    /**
     * @param profileId
     * @param username
     *
     * @return single User record
     */
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


    /**
     * @param name
     *
     * @return single Account record
     */
    public static Account selectAccountByName(String name) {
        return [SELECT Id FROM Account WHERE Name = :name LIMIT 1];
    }

    /**
     * @param notificationType
     *
     * @return return single Sales_Team__c record, because there is only one team per notificationType
     */
    public static Sales_Team__c selectSalesTeamByNotificationType(String notificationType) {
        return [
                SELECT Id, Notification_Type__c
                FROM Sales_Team__c
                WHERE Notification_Type__c = :notificationType
        ];
    }
}