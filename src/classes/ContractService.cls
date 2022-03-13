public with sharing class ContractService {

    /**
     * Method populate text message content for inserted new Contracts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of Contracts
     */
    public static void notifyOnInsert(List<Contract> newList) {
        Map<Id, Contract> contractsWithSalesTeam = new Map<Id, Contract>();

        String textMessage = 'Checkout new created contracts: ';
        for (Contract Contract : newList) {
            if (Contract.Sales_Team__c != null) {
                contractsWithSalesTeam.put(Contract.Sales_Team__c, Contract);
                textMessage += '\nName: ' + Contract.Name +
                        ', Status: ' + Contract.Status +
                        ', EndDate: ' + Contract.EndDate;
            }
        }

        NotificationHelper.sendMessages(
                textMessage,
                NotificationHelper.selectSalesTeamUsers(
                        NotificationHelper.INSERTING_NEW_RECORD,
                        contractsWithSalesTeam.keySet()
                )
        );
    }
}