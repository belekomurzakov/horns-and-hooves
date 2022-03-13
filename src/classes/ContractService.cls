public with sharing class ContractService {

    /**
     * Method populate text message content for inserted new Contracts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of Contracts
     */
    public static void notifyOnInsert(List<Contract> newList) {
        Map<Id, Contract> contractsWithSalesTeam = new Map<Id, Contract>();

        String text = 'Checkout new created contracts: ';
        for (Contract Contract : newList) {
            if (Contract.Sales_Team__c != null) {
                contractsWithSalesTeam.put(Contract.Sales_Team__c, Contract);
                text += '\nName: ' + Contract.Name +
                        ', Status: ' + Contract.Status +
                        ', EndDate: ' + Contract.EndDate;
            }
        }

        NotificationHelper.sendMessages(text, NotificationHelper.INSERTING_NEW_RECORD, contractsWithSalesTeam.keySet());
    }

    /**
     * Method will trigger on update event, send private messages for OwnerId and Status fields change.
     * Text messages are unique for both fields, and sending separately to different interested teams.
     *
     * @param oldMap map of contracts with old values
     * @param newMap map of contracts with new values
     */
    public static void notifyOnUpdate(Map<Id, Contract> oldMap, Map<Id, Contract> newMap) {
        Set<Id> contractsOnOwnerUpdate = new Set<Id>();
        Set<Id> contractsOnStatusUpdate = new Set<Id>();

        String textOwnerUpdate = 'Hi,\n notifying you on update of Owner field on following contracts: ';
        String textStatusUpdate = 'Hi,\n notifying you on update of Status field on following contracts: ';

        for (Id id : newMap.keySet()) {
            if (!String.isBlank(newMap.get(id).Sales_Team__c)) {
                if (oldMap.get(id).OwnerId != newMap.get(id).OwnerId) {
                    contractsOnOwnerUpdate.add(newMap.get(id).Sales_Team__c);
                    textOwnerUpdate += '\nContract: ' + id +
                            ', ' + 'old owner: ' + oldMap.get(id).OwnerId +
                            ', ' + 'new owner: ' + newMap.get(id).OwnerId;
                }
                if (oldMap.get(id).Status != newMap.get(id).Status) {
                    contractsOnStatusUpdate.add(newMap.get(id).Sales_Team__c);
                    textStatusUpdate += '\nContract: ' + id +
                            ', ' + 'old status: ' + oldMap.get(id).Status +
                            ', ' + 'new status: ' + newMap.get(id).Status;
                }
            }
        }

        NotificationHelper.sendMessages(textOwnerUpdate, NotificationHelper.UPDATING_OWNER_FIELD, contractsOnOwnerUpdate);
        NotificationHelper.sendMessages(textStatusUpdate, NotificationHelper.UPDATING_STATUS_FIELD, contractsOnStatusUpdate);
    }
}