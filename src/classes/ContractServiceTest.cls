@IsTest
private class ContractServiceTest {
    static final String ACTIVATED = 'Activated';

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

        insert new Account(Name = 'accountForContract');
    }

    @IsTest
    static void notifyOnInsertTest() {
        //given
        List<Contract> contractsToInsert = new List<Contract>();
        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.INSERTING_NEW_RECORD)?.Id;
        Id accountId = TestUtility.selectAccountByName('accountForContract')?.Id;

        for (Integer i = 0; i <= 3; i++) {
            contractsToInsert.add(
                    new Contract(
                            Name = 'test',
                            Sales_Team__c = salesTeamId,
                            AccountId = accountId
                    )
            );
        }
        //when
        Test.startTest();
        insert contractsToInsert;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnOwnerUpdate() {
        //given
        List<Contract> contracts = new List<Contract>();

        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.UPDATING_OWNER_FIELD)?.Id;
        Id accountId = TestUtility.selectAccountByName('accountForContract')?.Id;

        for (Integer i = 0; i <= 3; i++) {
            contracts.add(
                    new Contract(
                            Name = 'test',
                            Sales_Team__c = salesTeamId,
                            AccountId = accountId
                    )
            );
        }
        insert contracts;

        User newOwner = [SELECT Id FROM User LIMIT 1];

        for (Contract contract : contracts) {
            contract.OwnerId = newOwner.Id;
        }
        //when
        Test.startTest();
        update contracts;
        Test.stopTest();
    }

    @IsTest
    static void notifyOnStatusUpdate() {
        //given
        Id salesTeamId = TestUtility.selectSalesTeamByNotificationType(NotificationHelper.UPDATING_STATUS_FIELD)?.Id;
        Id accountId = TestUtility.selectAccountByName('accountForContract')?.Id;

        List<Contract> contracts = new List<Contract>();
        for (Integer i = 0; i <= 3; i++) {
            contracts.add(
                    new Contract(
                            Name = 'test',
                            Sales_Team__c = salesTeamId,
                            AccountId = accountId
                    )
            );
        }
        insert contracts;

        for (Contract contract : contracts) {
            contract.Status = ACTIVATED;
        }
        //when
        Test.startTest();
        update contracts;
        Test.stopTest();
    }
}