public with sharing class SalesTeamUserService {

    /**
     * Method updates Sales Team field on Sales Team User object
     * based on Interested Notification Types field.
     * It's required to ensure that data consistency.
     *
     * @param newList list of opportunities on before insert/update
     */
    public static void setSalesTeam(List<Sales_Team_User__c> newList) {
        Map<String, Sales_Team__c> salesTeamMap = new Map<String, Sales_Team__c>();

        for (Sales_Team__c salesTeam : [SELECT Id, Notification_Type__c FROM Sales_Team__c]) {
            salesTeamMap.put(salesTeam.Notification_Type__c, salesTeam);
        }

        for (Sales_Team_User__c salesTeamUser : newList) {
            salesTeamUser.Sales_Team__c = salesTeamMap.get(salesTeamUser.Interested_Notification_Types__c).Id;
        }
    }
}