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
}