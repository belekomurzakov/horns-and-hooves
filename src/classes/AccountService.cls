public with sharing class AccountService {

    /**
     * Method populate text message content for inserted new accounts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of accounts
     */
    public static void notifyOnInsert(List<Account> newList) {
        Map<Id, Account> accountsWithSalesTeam = new Map<Id, Account>();

        String text = 'Checkout new created accounts: ';
        for (Account Account : newList) {
            if (Account.Sales_Team__c != null) {
                accountsWithSalesTeam.put(Account.Sales_Team__c, Account);
                text += '\nName: ' + Account.Name +
                        ', Type: ' + Account.Type +
                        ', Industry: ' + Account.Industry;
            }
        }

        NotificationHelper.sendMessages(text, NotificationHelper.INSERTING_NEW_RECORD, accountsWithSalesTeam.keySet());
    }

    public static void notifyOnUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        Map<Id, Account> accountsOnOwnerUpdate = new Map<Id, Account>();
        Map<Id, Account> accountsOnStatusUpdate = new Map<Id, Account>();

        String textOwnerUpdate = 'Hi,\n notifying you on update of Owner field on following accounts: ';
        String textStatusUpdate = 'Hi,\n notifying you on update of Status field on following accounts: ';

        for (Id id : newMap.keySet()) {
            if (!String.isBlank(newMap.get(id).Sales_Team__c)) {

                if (oldMap.get(id).Owner != newMap.get(id).Owner) {
                    accountsOnOwnerUpdate.put(Account.Sales_Team__c, Account);
                    textOwnerUpdate += '\nAccount: ' + id +
                            ', ' + 'old owner: ' + oldMap.get(id).Owner +
                            ', ' + 'new owner: ' + newMap.get(id).Owner;
                }

                if (oldMap.get(id).Status__c != newMap.get(id).Status__c) {
                    accountsOnStatusUpdate.put(Account.Sales_Team__c, Account);
                    textStatusUpdate += '\nAccount: ' + id +
                            ', ' + 'old status: ' + oldMap.get(id).Status__c +
                            ', ' + 'new status: ' + newMap.get(id).Status__c;
                }
            }
        }

        NotificationHelper.sendMessages(textOwnerUpdate, NotificationHelper.UPDATING_OWNER_FIELD, accountsOnOwnerUpdate.keySet());
        NotificationHelper.sendMessages(textStatusUpdate, NotificationHelper.UPDATING_STATUS_FIELD, accountsOnStatusUpdate.keySet());
    }
}