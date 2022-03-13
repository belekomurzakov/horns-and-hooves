public with sharing class AccountService {

    /**
     * Method populate text message content for inserted new opportunities and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of opportunities
     */
    public static void notifyOnInsert(List<Account> newList) {
        Map<Id, Account> accountsWithSalesTeam = new Map<Id, Account>();
        String textMessage = 'Checkout new created accounts: ';

        for (Account Account : newList) {
            if (Account.Sales_Team__c != null) {
                accountsWithSalesTeam.put(Account.Sales_Team__c, Account);
                textMessage += '\nName: ' + Account.Name +
                        ', StageName: ' + Account.Type +
                        ', CloseDate: ' + Account.Industry;
            }
        }

        NotificationHelper.sendMessages(
                textMessage,
                NotificationHelper.selectSalesTeamUsers(
                        NotificationHelper.INSERTING_NEW_RECORD,
                        accountsWithSalesTeam.keySet()
                )
        );
    }
}