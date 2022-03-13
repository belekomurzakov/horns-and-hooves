public with sharing class AccountService {

    /**
     * Method populate text message content for inserted new accounts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of accounts
     */
    public static void notifyOnInsert(List<Account> newList) {
        Set<Id> accountsWithSalesTeam = new Set<Id>();

        String text = 'Hi,\n checkout new created new following accounts: ';
        for (Account account : newList) {
            if (!String.isBlank(account.Sales_Team__c)) {
                accountsWithSalesTeam.add(account.Sales_Team__c);
                text += '\nName: ' + account.Name +
                        ', Type: ' + account.Type +
                        ', Industry: ' + account.Industry;
            }
        }

        NotificationHelper.sendMessages(text, NotificationHelper.INSERTING_NEW_RECORD, accountsWithSalesTeam);
    }

    /**
     * Method will trigger on update event, send private messages for OwnerId and Status__c fields change.
     * Text messages are unique for both fields, and sending separately to different interested teams.
     *
     * @param oldMap map of accounts with old values
     * @param newMap map of accounts with new values
     */
    public static void notifyOnUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        Set<Id> accountsOnOwnerUpdate = new Set<Id>();
        Set<Id> accountsOnStatusUpdate = new Set<Id>();

        String textOwnerUpdate = 'Hi,\n notifying you on update of Owner field on following accounts: ';
        String textStatusUpdate = 'Hi,\n notifying you on update of Status field on following accounts: ';

        for (Id id : newMap.keySet()) {
            if (!String.isBlank(newMap.get(id).Sales_Team__c)) {
                if (oldMap.get(id).OwnerId != newMap.get(id).OwnerId) {
                    accountsOnOwnerUpdate.add(newMap.get(id).Sales_Team__c);
                    textOwnerUpdate += '\nAccount: ' + id +
                            ', ' + 'old owner: ' + oldMap.get(id).OwnerId +
                            ', ' + 'new owner: ' + newMap.get(id).OwnerId;
                }
                if (oldMap.get(id).Status__c != newMap.get(id).Status__c) {
                    accountsOnStatusUpdate.add(newMap.get(id).Sales_Team__c);
                    textStatusUpdate += '\nAccount: ' + id +
                            ', ' + 'old status: ' + oldMap.get(id).Status__c +
                            ', ' + 'new status: ' + newMap.get(id).Status__c;
                }
            }
        }

        NotificationHelper.sendMessages(textOwnerUpdate, NotificationHelper.UPDATING_OWNER_FIELD, accountsOnOwnerUpdate);
        NotificationHelper.sendMessages(textStatusUpdate, NotificationHelper.UPDATING_STATUS_FIELD, accountsOnStatusUpdate);
    }
}