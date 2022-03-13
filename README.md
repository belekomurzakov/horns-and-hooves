# Proof of Concept: Horns & Hooves

### Feature #1:
- Sales Team Users are grouped by Interested Notification Types (Picklist), so implemented trigger on Sales Team User 
to update Sales Team field (Lookup) based on Notification Type.
- Sales Team Users are real Salesforce users, so based on Username field, updates FirstName, LastName and Id fields.

### Feature #2:
- Sales Teams are primarily based on Notification Types, so implemented Matching and Duplicate rules to prevent creation
duplicate teams with the same Notification Type, because there is no reason to store two groups with the same type in 
separate teams.

## Repo Structure
```
/
├─ src/
│  ├─ classes/ 
│  │  ├─ AccountTriggerHandler      # Domain layer  
│  │  ├─ ContactTriggerHandler
│  │  ├─ ContactTriggerHandler
│  │  ├─ OpportunityTriggerHandler
│  │  ├─ SalesTeamUserHandler
│  │  ├─ AccountService             # Service layer
│  │  ├─ ContactService       
│  │  ├─ ContractService           
│  │  ├─ OpportunityService       
│  │  ├─ SalesTeamUserService     
│  │  ├─ AccountServiceTest         # Unit tests
│  │  ├─ ContactServiceTest       
│  │  ├─ ContractServiceTest      
│  │  ├─ OpportunityServiceTest
│  │  ├─ SalesTeamUserServiceTest    
│  │  ├─ TriggerHandlerTest
│  │  ├─ TestUtility                # Helper class for tests
│  │  ├─ TriggerHandler             # TriggerFramework
│  │  └─ NotificationHelper         # Helper class for sending messages
│  │
│  └─ triggers/                     # Triggers
│     ├─ AccountTrigger             
│     ├─ ContactTrigger       
│     ├─ ContractTrigger           
│     ├─ OpportunityTrigger       
│     └─ SalesTeamUserTriggger
│   
├─ .gitignore                       # List of files and folders not tracked by Git
└─ README.md                        # This file
```

