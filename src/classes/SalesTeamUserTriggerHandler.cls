public with sharing class SalesTeamUserTriggerHandler extends TriggerHandler {
    private Map<Id, Sales_Team_User__c> newSalesTeamUserMap;
    private Map<Id, Sales_Team_User__c> oldSalesTeamUserMap;
    private List<Sales_Team_User__c> newSalesTeamUserList;

    public SalesTeamUserTriggerHandler() {
        this.newSalesTeamUserMap = (Map<Id, Sales_Team_User__c>) Trigger.newMap;
        this.oldSalesTeamUserMap = (Map<Id, Sales_Team_User__c>) Trigger.oldMap;
        this.newSalesTeamUserList = (List<Sales_Team_User__c>) Trigger.new;
    }

    public override void beforeInsert() {
        SalesTeamUserService.setSalesTeam(newSalesTeamUserList);
    }

    public override void beforeUpdate() {
        SalesTeamUserService.setSalesTeam(newSalesTeamUserList);
    }
}